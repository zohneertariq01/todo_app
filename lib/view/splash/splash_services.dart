import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import '../../model/user_model.dart';
import '../../utils/routes/routes_name.dart';
import '../../view_model/user_view_model.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) {
      if (value.token == 'null' || value.token == '') {
        print('welcome');
        Navigator.pushNamed(context, RoutesName.login);
      } else {
        print('hi'.toString());
        Navigator.pushNamed(context, RoutesName.todo);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
