import 'package:flutter_dev_tutorial2/classes/bar_class.dart';
import 'dart:async';

class SearchResBloc {
  //init and get String StreamContoller
  final _queryStreamController = StreamController<String>();
  StreamSink<String> get stringSink => _queryStreamController.sink;

  //expose String stream
  Stream<String> get stringStream => _queryStreamController.stream;

  //init and get List<Bar> StreamContoller
  final _listStreamController = StreamController<List<Bar>>();
  StreamSink<List<Bar>> get listSink => _listStreamController.sink;

  //expose List<Bar> stream
  Stream<List<Bar>> get listStream => _listStreamController.stream;

  SearchResBloc(List<Bar> list) {
    _queryStreamController.stream.listen((event) {
      List<Bar> filteredList =
          list.where((x) => x.name.toLowerCase().contains(event)).toList();

      listSink.add(filteredList);
    });
  }

  dispose() {
    _queryStreamController.close();
    _listStreamController.close();
  }
}
