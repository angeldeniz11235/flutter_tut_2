import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_tutorial2/services/brewery_service.dart';
import 'package:flutter_dev_tutorial2/bloc/search_results_bloc.dart';

void main() {
  runApp(new MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  late BreweryService breweryService;
  @override
  void initState() {
    breweryService = BreweryService();
    _getList();
    super.initState();
  }

  Widget _body = CircularProgressIndicator();

  _getList() {
    breweryService.getData().then((List<Bar> res) {
      if (res.isNotEmpty) {
        setState(() => _body = _homeScreen(res));
      } else {
        setState(() => _body = CircularProgressIndicator());
      }
    });
  }

  Widget _homeScreen(List<Bar> fullList) {
    late SearchResBloc _filteredListBloc = SearchResBloc(fullList);

    return new Scaffold(
      appBar: AppBar(
        title: Text('Breweries'),
      ),
      body: Container(
        child: StreamBuilder<List<Bar>>(
          initialData: fullList,
          stream: _filteredListBloc.listStream,
          builder: (BuildContext context, AsyncSnapshot<List<Bar>> snapshot) {
            if (snapshot.hasData) {
              return Column(children: [
                Expanded(
                  flex: 1,
                  child: TextField(
                    onChanged: (String query) {
                      _filteredListBloc.stringSink.add(query);
                    },
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.local_drink),
                                title: Text(snapshot.data![index].name),
                                subtitle: Text(snapshot.data![index].city +
                                    ', ' +
                                    snapshot.data![index].state),
                                onTap: () => {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    List<Bar> list = snapshot.data!;
                                    return DetailScreen(list, index);
                                  }))
                                },
                              )
                            ],
                          ),
                        );
                      }),
                ),
                Expanded(
                    flex: 1,
                    child: Row(children: [
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          'assets/img/beer1-w600.jpg',
                          fit: BoxFit.none,
                        ),
                      )
                    ]))
              ]);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _body;
  }
}

class Bar {
  final String name;
  final String city;
  final String state;
  final String? website;
  Bar(
      {required this.city,
      required this.name,
      required this.state,
      this.website});

  factory Bar.fromJson(Map<String, dynamic> json) {
    return Bar(
        name: json['name'],
        city: json['city'],
        state: json['state'],
        website: json['website_url']);
  }
}

class DetailScreen extends StatefulWidget {
  final List<Bar> data;
  final int index;
  const DetailScreen(this.data, this.index);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    List<Bar> list = widget.data;
    int index = widget.index;
    Bar bar = list[index];
    String name = bar.name;
    String city = bar.city;
    String state = bar.state;
    String? website =
        bar.website != null ? bar.website : "Website not available";
    print(list.elementAt(widget.index));
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: new AssetImage("assets/img/bar_bg.png"),
                fit: BoxFit.fitHeight),
          ),
          child: Center(
              child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: ((MediaQuery.of(context).size.height) / 4) + 60),
              ),
              Text(
                city,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 38.0,
                  height: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                state,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  height: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                website!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  height: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          )),
        ));
  }
}
