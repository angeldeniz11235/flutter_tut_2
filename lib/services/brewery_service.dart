import 'dart:async';
import 'dart:convert';
import 'package:flutter_dev_tutorial2/main.dart';
import 'package:http/http.dart' as http;

class BreweryService {
  Future<List<Bar>> getData() async {
    var response = await http.get(
        Uri.parse("https://api.openbrewerydb.org/breweries"),
        headers: {"Accept": "application/json"});
    var jsonBody = json.decode(response.body);
    List<Bar> list = [];
    for (var item in jsonBody) {
      list.add(Bar.fromJson(item));
    }
    return list;
  }
}
