
import 'package:first_flutter_app/widgets/state_layout.dart';
import 'package:flutter/material.dart';

/*类似于 android中的adapter*/
class BaseListProvider<T> extends ChangeNotifier {

  final List<T> _list = [];
  List<T> get list => _list;

  StateType _stateType = StateType.loading;
  bool _hasMore = true;

  StateType get stateType => _stateType;
  bool get hasMore => _hasMore;

  void setStateTypeNotNotify(StateType stateType){
    _stateType = stateType;
  }

  void setStateType(StateType stateType){
    _stateType = stateType;
    notifyListeners();
  }

  void setHasMore(bool hasMore){
    _hasMore = hasMore;
  }

  void add(T data) {
    _list.add(data);
    notifyListeners();
  }

  void addAll(List<T> data) {
    _list.addAll(data);
    notifyListeners();
  }

  void insert(int i, T data) {
    _list.insert(i, data);
    notifyListeners();
  }

  void insertAll(int i, List<T> data) {
    _list.insertAll(i, data);
    notifyListeners();
  }

  void remove(T data) {
    _list.remove(data);
    notifyListeners();
  }

  void removeAt(int i) {
    _list.removeAt(i);
    notifyListeners();
  }

  void clear() {
    _list.clear();
    notifyListeners();
  }

  void refresh(){
    notifyListeners();
  }
}