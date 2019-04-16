import 'package:do_an_tn/src/screens/login_dashboard.dart';
import 'package:flutter/material.dart';

class LoginNotifyWidget extends StatelessWidget {
  final BuildContext context;

  const LoginNotifyWidget({Key key, this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.lock,
              size: 100,
            ),
            _loginNotifyButton(context),
          ],
        ),
      ),
    );
  }

  Widget _loginNotifyButton(BuildContext _context) {
    return RaisedButton(
      color: Color(0xff383c42),
      onPressed: () {
        Navigator.push(_context,
            MaterialPageRoute(builder: (context) => LoginDashboard()));
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.account_circle,
              color: Colors.white,
              size: 35.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            Text(
              'Vui lòng đăng nhập để tiếp tục',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
