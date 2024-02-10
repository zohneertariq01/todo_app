import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/utils/routes/routes.dart';
import 'package:todo_app/utils/routes/routes_name.dart';
import 'package:todo_app/view_model/auth_view_model.dart';
import 'package:todo_app/view_model/user_view_model.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('testBox');
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  bool showHome = sp.getBool('onBoarding_data') ?? false;
  runApp(MyApp(
    showHome: showHome,
  ));
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({super.key, required this.showHome});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],
      child: MaterialApp(
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: showHome ? RoutesName.todo : RoutesName.intro,
        onGenerateRoute: Routes.onGenerated,
      ),
    );
  }
}
