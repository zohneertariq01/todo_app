import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_app/utils/routes/routes_name.dart';
import 'package:todo_app/view/splash/splash_services.dart';
import '../../utils/components/onboarding_data.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _currentIndex = 0;
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    SplashServices splashServices = SplashServices();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFF4F4F4),
        actions: [
          TextButton(
            onPressed: () async {
              SharedPreferences sp = await SharedPreferences.getInstance();
              sp.setBool('onBoarding_data', true);

              Navigator.pushNamed(context, RoutesName.login);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                'Skip',
                style: TextStyle(
                  color: Colors.deepOrangeAccent,
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFFF4F4F4),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 80),
            child: PageView(
              onPageChanged: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              children: [
                OurData(
                  title: 'Welcome to ToDo App!',
                  image: 'images/todo.png',
                  content: 'Organize your tasks and boost productivity',
                ),
                OurData(
                  title: 'Get Started in 3 Easy Steps!',
                  image: 'images/info1.png',
                  content: 'Add tasks, set due dates, and manage priorities',
                ),
                OurData(
                  title: 'Make ToDo Your Own!',
                  image: 'images/project.png',
                  content: 'Personalize themes, categories, and set reminders',
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              _currentIndex == 2
                  ? Padding(
                      padding: EdgeInsets.only(top: 570, right: 15, left: 15),
                      child: InkWell(
                        onTap: () {
                          splashServices.checkAuthentication(context);
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.deepOrangeAccent,
                          ),
                          child: Center(
                            child: Text(
                              "Let's Go",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ],
      ),
      bottomSheet: _currentIndex == 2
          ? null
          : Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFF4F4F4),
              ),
              child: Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  axisDirection: Axis.horizontal,
                  effect: WormEffect(
                    spacing: 8.0,
                    radius: 8.0,
                    dotHeight: 12,
                    dotWidth: 12,
                    dotColor: Colors.grey.shade700,
                    activeDotColor: Colors.deepOrangeAccent,
                  ),
                ),
              ),
            ),
    );
  }
}
