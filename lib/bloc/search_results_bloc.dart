import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dev_tutorial2/main.dart';

class SearchResBlock extends Bloc<String, List<Bar>> {
  SearchResBlock() : super(List<Bar>.empty());

  List<Bar> get initialState => List<Bar>.empty();

  @override
  Stream<List<Bar>> mapEventToState(String query) async* {
    yield state
        .where((bar) => bar.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
