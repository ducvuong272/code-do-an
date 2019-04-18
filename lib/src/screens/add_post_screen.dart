import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  @override
  AddPostState createState() => AddPostState();
}

class AddPostState extends State<AddPost> {
  TextEditingController _postTitleController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TimeOfDay _time1 = TimeOfDay(hour: 9, minute: 0),
      _time2 = TimeOfDay(hour: 21, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.red,
          title: Text('Thêm địa điểm'),
          elevation: 0.0,
          centerTitle: true,
        ),
      ),
      body: Container(
        color: Color(0xffe4e8e3),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _headerSection('Chọn Tỉnh/Thành phố'),
                Container(
                  height: 45,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _locationPickingSection('Việt Nam', context),
                      _locationPickingSection('Đà Nẵng', context),
                      _locationPickingSection('Chọn quận', context),
                    ],
                  ),
                ),
                _headerSection('Thông tin bắt buộc'),
                _infoSection(
                  iconData: Icons.account_balance,
                  textField: true,
                  text: 'Tên địa điểm',
                  texteditController: _postTitleController,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2, bottom: 2),
                  child: _infoSection(
                    iconData: Icons.add_to_photos,
                    textField: false,
                    text: 'Loại hình địa điểm',
                    widget: Icon(Icons.navigate_next),
                    function: () {},
                  ),
                ),
                _infoSection(
                  iconData: Icons.add_location,
                  textField: true,
                  text: 'Địa chỉ',
                  texteditController: _addressController,
                ),
                _headerSection('Thông tin khác'),
                _infoSection(
                  iconData: Icons.phone_iphone,
                  text: 'Số điện thoại',
                  textField: true,
                  texteditController: _phoneController,
                  numberKeyboard: true,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: _infoSection(
                    iconData: Icons.access_time,
                    text: 'Giờ mở cửa',
                    textField: false,
                    widget: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Future<TimeOfDay> _future =
                                _setTime(context, _time1);
                            _future.then((onValue) {
                              setState(() {
                                _time1 = onValue;
                              });
                            });
                          },
                          child: _timePickerSection(_time1, context),
                        ),
                        Text(
                          'Đến',
                          style: TextStyle(fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: () {
                            Future<TimeOfDay> _future =
                                _setTime(context, _time2);
                            _future.then((onValue) {
                              setState(() {
                                _time2 = onValue;
                              });
                            });
                          },
                          child: _timePickerSection(_time2, context),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: _infoSection(
                    iconData: Icons.monetization_on,
                    textField: false,
                    text: 'Mức giá',
                    widget: Container(
                      width: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                hintText: 'Giá thấp nhất',
                              ),
                            ),
                          ),
                          Container(
                            child: Text('Đến'),
                            margin: EdgeInsets.only(left: 5, right: 5),
                          ),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                                hintText: 'Giá cao nhất',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _timePickerSection(TimeOfDay time, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(left: 5, right: 5),
      color: Color(0xff5ad849),
      child: Center(
        child: Text(
          time.format(context),
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

//Chuyển sang bloc
  Future<TimeOfDay> _setTime(BuildContext context, TimeOfDay time) async {
    var _timePicked = await showTimePicker(
      context: context,
      initialTime: time,
    );
    return _timePicked;
  }

  Widget _infoSection({
    IconData iconData,
    String text,
    Widget widget,
    Function function,
    bool textField,
    TextEditingController texteditController,
    bool numberKeyboard,
  }) {
    return GestureDetector(
      onTap: function != null ? function : () {},
      child: Container(
        height: 45,
        padding: EdgeInsets.only(left: 10),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      iconData,
                      size: 25,
                      color: Color(0xff797c79),
                    ),
                  ),
                  textField
                      ? Expanded(
                          child: TextField(
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                            keyboardType:
                                numberKeyboard == null || !numberKeyboard
                                    ? TextInputType.text
                                    : TextInputType.number,
                            controller: texteditController,
                            autocorrect: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: text,
                              labelStyle: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                              ),
                              contentPadding: EdgeInsets.all(5),
                              hintStyle: TextStyle(
                                fontSize: 19,
                              ),
                            ),
                          ),
                        )
                      : Text(
                          text,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ],
              ),
            ),
            widget != null ? widget : Container(),
          ],
        ),
      ),
    );
  }

  Widget _headerSection(String text) {
    return Container(
      color: Color(0xffe4e8e3),
      padding: EdgeInsets.only(left: 10),
      height: 40,
      child: Row(
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Color(0xff8a9389),
            ),
          ),
        ],
      ),
    );
  }

  Widget _locationPickingSection(String text, BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 50) / 3,
      margin: EdgeInsets.all(8),
      // padding: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Color(0xff5ad849),
        borderRadius: BorderRadius.circular(12),
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onPressed: () {},
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
