import 'dart:async';

class FavoritesBloc {
  //init and get int StreamContoller
  final _indexStreamController = StreamController<int>();
  StreamSink<int> get indexSink => _indexStreamController.sink;

  //expose int stream
  Stream<int> get indexStream => _indexStreamController.stream;

  //init and get List<bool> StreamContoller
  final _favListStreamController = StreamController<List<bool>>();
  StreamSink<List<bool>> get favListSink => _favListStreamController.sink;

  //expose List<bool> stream
  Stream<List<bool>> get favListStream => _favListStreamController.stream;

  FavoritesBloc(List<bool> list) {
    List<bool> _isFavorite = List.filled(list.length, false);
    _indexStreamController.stream.listen((index) {
      _isFavorite[index] = !_isFavorite[index];
      favListSink.add(_isFavorite);
    });
  }

  dispose() {
    _indexStreamController.close();
    _favListStreamController.close();
  }
}
