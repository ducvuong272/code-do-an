import 'dart:io';
import 'package:do_an_tn/src/blocs/change_user_information_bloc.dart';
import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class UserInformationScreen extends StatefulWidget {
  final User user;

  const UserInformationScreen({Key key, this.user}) : super(key: key);

  @override
  UserInformationScreenState createState() => UserInformationScreenState();
}

class UserInformationScreenState extends State<UserInformationScreen> {
  TextEditingController _firstNameController,
      _lastNameController,
      _emailController;
  UpdateUserInfoBloc _updateUserInfoBloc = UpdateUserInfoBloc();
  File _imageFile;

  @override
  void initState() {
    _firstNameController =
        TextEditingController(text: '${widget.user.firstName}');
    _lastNameController =
        TextEditingController(text: '${widget.user.lastName}');
    _emailController = TextEditingController(text: '${widget.user.email}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text('Thông tin cá nhân'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          padding: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff36c5f7),
                Color(0xff87e0ff),
                Color(0xffb2ebff),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text('Tên tài khoản : '),
                        width: 100,
                      ),
                      Expanded(
                        child: Container(
                          height: 40,
                          margin: EdgeInsets.only(
                            right: 10,
                          ),
                          padding: EdgeInsets.only(
                            left: 5,
                            right: 5,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('${widget.user.username}'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text('Họ: '),
                          width: 100,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                              right: 10,
                            ),
                            padding: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: TextField(
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              controller: _firstNameController,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text('Tên: '),
                          width: 100,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                              right: 10,
                            ),
                            padding: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: TextField(
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              controller: _lastNameController,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text('Email: '),
                          width: 100,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                              right: 10,
                            ),
                            padding: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                            child: TextField(
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              controller: _emailController,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        StreamBuilder<Object>(
                            stream: _updateUserInfoBloc.getImageFileStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                _imageFile = snapshot.data;
                                return CircleAvatar(
                                  backgroundImage: FileImage(snapshot.data),
                                  radius: 100,
                                );
                              } else {
                                return UserAvatar(
                                  avatarSize: 100,
                                  lastName: widget.user.lastName,
                                  userAvatarImageUrl: widget.user.imageUrl,
                                );
                              }
                            }),
                        RaisedButton(
                          onPressed: () {
                            _updateUserInfoBloc.pickImageFromAlbum();
                          },
                          child: Text('Đổi hình đại diện'),
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          disabledColor: Colors.grey,
                          onPressed: () {
                            //Not update user at home screen yet
                            User user = widget.user;
                            user.email = _emailController.text.trim();
                            user.firstName = _firstNameController.text.trim();
                            user.lastName = _lastNameController.text.trim();
                            user.userId = widget.user.userId;
                            _updateUserInfoBloc.updateUserInfor(
                              user,
                              context,
                              _imageFile,
                            );
                          },
                          child: Text('Xong'),
                          color: Colors.green,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
