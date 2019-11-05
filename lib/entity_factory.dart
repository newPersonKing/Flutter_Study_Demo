
import 'package:first_flutter_app/page/net/account_entity.dart';
import 'package:first_flutter_app/page/order/model/search_entity.dart';
import 'package:first_flutter_app/page/shop/model/user_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "AccountEntity") {
      return AccountEntity.fromJson(json) as T;
    } else if (T.toString() == "SearchEntity") {
      return SearchEntity.fromJson(json) as T;
    } else if (T.toString() == "UserEntity") {
      return UserEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}