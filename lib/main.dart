import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dev_tutorial2/services/brewery_service.dart';

void main() {
  runApp(new MaterialApp(
    home: new HomePage(),
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //getData();
    return new Scaffold(
      appBar: AppBar(
        title: Text('Breweries'),
      ),
      body: Container(
        child: FutureBuilder<List<Bar>>(
          future: breweryService.getData(),
          builder: (BuildContext context, AsyncSnapshot<List<Bar>> snapshot) {
            if (snapshot.hasData) {
              return Column(children: [
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
                    flex: 2,
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
                image: NetworkImage(
                    'http://www.giltbarchicago.com/wp-content/uploads/GiltBar-39.jpg'),
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
