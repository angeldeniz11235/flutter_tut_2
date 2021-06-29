import 'dart:async';

class FavoritesBloc {
  //init and get List<bool> StreamContoller
  final _listStreamController = StreamController<List<bool>>();
  StreamSink<List<bool>> get listSink => _listStreamController.sink;

  //expose List<bool> stream
  Stream<List<bool>> get listStream => _listStreamController.stream;

  SearchResBloc(List<bool> list) {
    _queryStreamController.stream.listen((event) {
      List<bool> filteredList =
          list.where((x) => x.name.toLowerCase().contains(event)).toList();

      listSink.add(filteredList);
    });
  }

  dispose() {
    _queryStreamController.close();
    _listStreamController.close();
  }
}
