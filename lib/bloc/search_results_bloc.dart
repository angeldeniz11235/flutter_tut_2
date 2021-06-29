import 'package:bloc/bloc.dart';
import 'package:flutter_dev_tutorial2/main.dart';

class BarListAndQuery {
  List<Bar> list;
  String query;
  BarListAndQuery(this.list, this.query);
}

// class SearchResBloc extends Bloc<, List<Bar>> {
//   SearchResBloc() : super(List<Bar>.empty());

//   List<Bar> get initialState => List<Bar>.empty();

//   @override
//   Stream<List<Bar>> mapEventToState(Bar list) async* {
//     yield state;
//     // yield state
//     //     .where((bar) => bar.name.toLowerCase().contains(query.toLowerCase()))
//     //     .toList();
//   }
// }
//
