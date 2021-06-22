import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

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
  Future<List<dynamic>> getData() async {
    var response = await http.get(
        Uri.parse("https://api.openbrewerydb.org/breweries"),
        headers: {"Accept": "application/json"});
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    //getData();
    return new Scaffold(
      appBar: AppBar(
        title: Text('Breweries'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Column(children: [
                Expanded(
                  flex: 8,
                  child: ListView.builder(
                      padding: EdgeInsets.all(8),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.local_drink),
                                title: Text(snapshot.data[index]['name']),
                                subtitle: Text(snapshot.data[index]['city'] +
                                    ', ' +
                                    snapshot.data[index]['state']),
                                onTap: () => {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    List<dynamic> list = snapshot.data;
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
  Bar({required this.city, required this.name, required this.state});

  factory Bar.fromJson(Map<String, dynamic> json) {
    return Bar(name: json['name'], city: json['city'], state: json['state']);
  }
}

class DetailScreen extends StatefulWidget {
  final List<dynamic> data;
  final int index;
  const DetailScreen(this.data, this.index);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> list = widget.data;
    print(list.elementAt(widget.index));
    return Scaffold(
      appBar: AppBar(
        title: Text(list.elementAt(widget.index)['name']),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Back"),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
    );
  }
}
