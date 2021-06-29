import 'dart:async';
import 'package:flutter_dev_tutorial2/classes/bar_class.dart';

class FavoritesBloc {
  //init and get String StreamContoller
  final _indexStreamController = StreamController<String>();
  StreamSink<String> get barNameSink => _indexStreamController.sink;

  //expose String stream
  Stream<String> get barNameStream => _indexStreamController.stream;

  //init and get List<bool> StreamContoller
  final _favListStreamController =
      StreamController<Map<String, bool>>.broadcast();
  StreamSink<Map<String, bool>> get favListSink =>
      _favListStreamController.sink;

  //expose List<bool> stream
  Stream<Map<String, bool>> get favListStream =>
      _favListStreamController.stream;

  late Map<String, bool> _isFavorite;
  getFavList() => _isFavorite;

  FavoritesBloc(List<Bar> list) {
    _isFavorite =
        Map.fromIterable(list, key: (e) => e.name, value: (e) => false);
    _indexStreamController.stream.listen((name) {
      _isFavorite.update(name, (value) => !value);
      favListSink.add(_isFavorite);
    });
  }

  dispose() {
    _indexStreamController.close();
    _favListStreamController.close();
  }
}
