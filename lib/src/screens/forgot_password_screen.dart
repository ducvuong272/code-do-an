import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(30, 100, 30, 20),
            padding: EdgeInsets.only(left: 10, right: 10),
            height: 500,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                tileMode: TileMode.repeated,
                colors: [
                  Color(0xffef7339),
                  Color(0xfff4ad70),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.mail_outline,
                      size: 50,
                      color: Colors.black,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        'Nhập email khôi phục',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: _emailController,
                  autocorrect: false,
                  style: TextStyle(fontSize: 23),
                  decoration: InputDecoration(
                    labelText: 'Nhập email',
                    suffix: GestureDetector(
                      onTap: (){
                        _emailController.clear();
                      },
                      child: Icon(
                        Icons.clear,
                        size: 25,
                        color: Colors.black,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: RaisedButton(
                    elevation: 0.0,
                    color: Colors.blue,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      child: Center(
                        child: Text(
                          'Xác nhận',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
