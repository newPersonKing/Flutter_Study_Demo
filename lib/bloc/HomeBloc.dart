
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum HomeBottomEvent{
  one,
  two,
  three
}

class HomeBloc extends Bloc<HomeBottomEvent,int>{
  @override
  // TODO: implement initialState
  get initialState => 1;

  /*async* 与 sync* 的 理解*/
  /**
   * sync* 返回的是一个Iterable 每次执行到yield 就会停止 想要继续往下执行需要调用Iterable.moveNext 方法
   * async* 每次执行到yield 都会返回一个stream 不会停止
   */
  @override
  Stream<int> mapEventToState(HomeBottomEvent event) async*{
     switch(event){
       case HomeBottomEvent.one:
         yield 1;
         break;
       case HomeBottomEvent.two:
        yield 2;
         break;
       case HomeBottomEvent.three:
        yield 3;
         break;
     }
     yield 1;
  }
}