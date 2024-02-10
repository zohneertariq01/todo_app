import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/utils/routes/routes_name.dart';
import 'package:todo_app/view/login_screen.dart';
import 'package:todo_app/view/splash/intro_screen.dart';
import 'package:todo_app/view/todo_screen.dart';

class Routes {
  static Route<dynamic> onGenerated(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case RoutesName.intro:
        return MaterialPageRoute(builder: (context) => IntroScreen());
      case RoutesName.todo:
        return MaterialPageRoute(builder: (_) => TodoScreen());
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('No route is defined'),
              ),
            );
          },
        );
    }
  }
}
