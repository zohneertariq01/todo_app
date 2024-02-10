import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view_model/auth_view_model.dart';
import '../utils/routes/routes_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 45),
                Center(
                  child: Image(
                    height: 180,
                    width: 180,
                    image: AssetImage('images/todo.png'),
                  ),
                ),
                SizedBox(height: 70),
                Text(
                  'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    fontFamily: GoogleFonts.aBeeZee().fontFamily,
                    color: Color(0xFF2E384D),
                  ),
                ),
                SizedBox(height: 25),
                TextFormField(
                  cursorColor: Colors.deepOrangeAccent,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: emailFocus,
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.deepOrangeAccent,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    hintText: 'Email or User Name',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.deepOrangeAccent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.deepOrangeAccent),
                    ),
                  ),
                  onFieldSubmitted: (value) {
                    Utils.fieldChangeContext(
                        context, emailFocus, passwordFocus);
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  focusNode: passwordFocus,
                  obscuringCharacter: '*',
                  obscureText: true,
                  keyboardType: TextInputType.phone,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.deepOrangeAccent,
                    ),
                    suffixIcon: Icon(Icons.visibility_off,
                        color: Colors.deepOrangeAccent),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.deepOrangeAccent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.deepOrangeAccent),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2E384D),
                    ),
                  ),
                ),
                SizedBox(height: 80),
                InkWell(
                  onTap: () async {
                    if (_emailController.text.isEmpty) {
                      return Utils.flushBarMessage(
                          'Please enter email', context);
                    } else if (_passwordController.text.isEmpty) {
                      return Utils.flushBarMessage(
                          'Please enter password', context);
                    } else if (_passwordController.text.length < 6) {
                      return Utils.flushBarMessage(
                          'Please enter 6 digits password', context);
                    } else {
                      Map data = {
                        "email": "eve.holt@reqres.in",
                        "password": "cityslicka"
                      };
                      SharedPreferences sp =
                          await SharedPreferences.getInstance();
                      sp.setBool('onBoarding_data', true);
                      provider.loginApi(context, data);
                      return print('Api hit');
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.deepOrangeAccent,
                    ),
                    child: Center(
                      child: provider.loading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2E384D),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.signup);
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.deepOrangeAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
