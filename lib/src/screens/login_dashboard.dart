import 'package:do_an_tn/src/screens/forgot_password_screen.dart';
import 'package:do_an_tn/src/screens/login_screen.dart';
import 'package:do_an_tn/src/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class LoginDashboard extends StatefulWidget {
  @override
  _LoginDashboard createState() => _LoginDashboard();
}

class _LoginDashboard extends State<LoginDashboard> {
  int _pageIndex = 0;
  final _pageController = SwiperController();
  List<Widget> _listWidget = [];

  @override
  void initState() {
    _listWidget = [
      LoginScreen(
        onSignUpTapped: _goToSignUp,
        onForgetPassTapped: _goToForgetPassword,
      ),
      SignUpScreen(
        haveAccountTapped: _goToLogin,
      ),
      ForgotPasswordScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
              child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff42f45f),
                    Color(0xff41f4b8),
                  ],
                ),
              ),
              child: Swiper(
                onIndexChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                loop: false,
                index: _pageIndex,
                itemCount: 3,
                controller: _pageController,
                itemBuilder: (context, index) => _listWidget[index],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _goToSignUp() {
    _pageController.move(1);
  }

  _goToLogin() {
    _pageController.move(0);
  }

  _goToForgetPassword() {
    _pageController.move(2);
  }
}
