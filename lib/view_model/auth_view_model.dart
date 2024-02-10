import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/user_model.dart';
import 'package:todo_app/repository/user_repository.dart';
import 'package:todo_app/utils/routes/routes_name.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view_model/user_view_model.dart';

class AuthViewModel with ChangeNotifier {
  UserRepository _userRepository = UserRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  void isLoading(value) {
    _loading = value;
    notifyListeners();
  }

  void isSignUpLoading(value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(BuildContext context, dynamic data) async {
    isLoading(true);
    _userRepository.getLoginApi(data).then((value) {
      isLoading(false);
      Utils.flushBarMessage('Login Successfully', context);
      Navigator.pushNamed(context, RoutesName.todo);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      isLoading(false);
      Utils.flushBarMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> signUpApi(BuildContext context, dynamic data) async {
    isSignUpLoading(true);
    _userRepository.getSignUpApi(data).then((value) {
      final provider = Provider.of<UserViewModel>(context, listen: false);
      provider.saverUser(
        UserModel(token: value['token'].toString()),
      );
      isSignUpLoading(false);
      Utils.flushBarMessage('Login Successfully', context);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      isSignUpLoading(false);
      Utils.flushBarMessage(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
