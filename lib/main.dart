import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
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
    getData();
    return new Scaffold(
      appBar: AppBar(
        title: Text('Breweries'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(snapshot.data[index]['name']),
                          )
                        ],
                      ),
                    );
                  });
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
