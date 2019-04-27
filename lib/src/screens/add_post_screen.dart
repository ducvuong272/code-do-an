import 'dart:io';
import 'package:do_an_tn/src/blocs/add_post_bloc.dart';
import 'package:do_an_tn/src/models/post.dart';
import 'package:do_an_tn/src/models/user.dart';
import 'package:do_an_tn/src/services/api_handler.dart';
import 'package:do_an_tn/src/widgets/dialog.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  final User user;

  const AddPostScreen({Key key, this.user}) : super(key: key);

  @override
  AddPostScreenState createState() => AddPostScreenState();
}

class AddPostScreenState extends State<AddPostScreen> {
  TextEditingController _postTitleController = TextEditingController(),
      _addressController = TextEditingController(),
      _phoneController = TextEditingController(),
      _postDetailController = TextEditingController(),
      _highestPriceController = TextEditingController(),
      _lowestPriceController = TextEditingController();
  TimeOfDay _time1 = TimeOfDay(hour: 9, minute: 0),
      _time2 = TimeOfDay(hour: 21, minute: 0);
  AddPostBloc _addPostBloc = AddPostBloc();
  Map<int, String> _areaMap = {
    1: 'Hải Châu',
    2: 'Sơn Trà',
    3: 'Liên Chiểu',
    4: 'Thanh Khê',
    5: 'Ngũ Hành Sơn'
  };
  Map<int, String> _postCategoryMap = {
    1: 'Ẩm thực',
    2: 'Du lịch',
    3: 'Văn hóa',
    4: 'Dịch vụ',
    5: 'Giải trí'
  };
  int _areaIndex, _postCategoryIndex;
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                var timeOpen = _time1.format(context);
                var timeClose = _time2.format(context);
                Post post = Post(
                  userId: widget.user.userId,
                  postTitle: _postTitleController.text,
                  address: _addressController.text,
                  postDetail: _postDetailController.text,
                  postCategories:
                      _postCategoryMap.values.elementAt(_postCategoryIndex),
                  district: 'Quận ' + _areaMap.values.elementAt(_areaIndex),
                  phoneNumber: _phoneController.text,
                  openTime: timeOpen,
                  closeTime: timeClose,
                  highestPrice: _highestPriceController.text,
                  lowestPrice: _lowestPriceController.text,
                );
                CustomDialog dialog = CustomDialog();
                _addPostBloc.addPost(post, context, dialog);
              },
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    'Xong',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
          backgroundColor: Colors.red,
          title: Text('Thêm địa điểm'),
          elevation: 0.0,
          centerTitle: true,
        ),
      ),
      body: Container(
        color: Colors.red,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            children: <Widget>[
              Container(
                color: Color(0xffe4e8e3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildImageSection(_screenSize.height / 3),
                    _headerSection('Chọn Tỉnh/Thành phố'),
                    Container(
                      height: 45,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _locationPickingSection(
                              text: 'Việt Nam', context: context),
                          _locationPickingSection(
                              text: 'Đà Nẵng', context: context),
                          _locationPickingSection(
                              text: _areaIndex == null
                                  ? 'Chọn quận'
                                  : _areaMap.values.elementAt(_areaIndex),
                              context: context,
                              function: () {
                                _buildBottomSheet(context, _areaMap, true);
                              }),
                        ],
                      ),
                    ),
                    _headerSection('Thông tin chính'),
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
                        text: _postCategoryIndex == null
                            ? 'Chọn loại hình địa điểm'
                            : 'Loại hình địa điểm: ' +
                                _postCategoryMap.values
                                    .elementAt(_postCategoryIndex),
                        widget: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        function: () {
                          _buildBottomSheet(
                            context,
                            _postCategoryMap,
                            false,
                          );
                        },
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
                      phoneNumberKeyboard: true,
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
                                _addPostBloc.setOpenTimePicked(
                                  context,
                                  _time1,
                                );
                              },
                              child: StreamBuilder<Object>(
                                stream: _addPostBloc.openTimeStream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    _time1 = snapshot.data;
                                  }
                                  return _timePickerSection(_time1, context);
                                },
                              ),
                            ),
                            Text(
                              'Đến',
                              style: TextStyle(fontSize: 15),
                            ),
                            GestureDetector(
                              onTap: () {
                                _addPostBloc.setCloseTimePicked(
                                  context,
                                  _time2,
                                );
                              },
                              child: StreamBuilder<Object>(
                                stream: _addPostBloc.closeTimeStream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    _time2 = snapshot.data;
                                  }
                                  return _timePickerSection(_time2, context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2, bottom: 2),
                      child: Column(
                        children: <Widget>[
                          _infoSection(
                            iconData: Icons.monetization_on,
                            textField: false,
                            text: 'Mức giá (VND)',
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Container(
                              height: 45,
                              padding: EdgeInsets.only(left: 15),
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: _lowestPriceController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(0),
                                        labelText: 'Giá thấp nhất',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 5, right: 5),
                                    child: Text(
                                      'Đến',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: _highestPriceController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(0),
                                        labelText: 'Giá cao nhất',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                  right: 10,
                                  left: 10,
                                  top: 15,
                                ),
                                child: Icon(
                                  Icons.library_books,
                                  size: 25,
                                  color: Color(0xff797c79),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.multiline,
                                  controller: _postDetailController,
                                  maxLines: 20,
                                  maxLengthEnforced: false,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(0),
                                    labelText: 'Nhập mô tả',
                                    labelStyle: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    alignLabelWithHint: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addPostBloc.showOptionsToPickImage(
            context: context,
            pickImageFromAlbum: _pickImageFromAlbum,
            pickImageFromCamera: _pickImageFromCamera,
          );
          print(_imageFile);
        },
        child: Icon(Icons.add_photo_alternate),
      ),
    );
  }

  _pickImageFromCamera() {
    _addPostBloc.pickImageFromCamera().then((onValue) {
      setState(() {
        _imageFile = onValue;
      });
      Navigator.of(context).pop();
    });
  }

  _pickImageFromAlbum() {
    _addPostBloc.pickImageFromAlbum().then((onValue) {
      setState(() {
        _imageFile = onValue;
      });
      Navigator.of(context).pop();
    });
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

  Widget _infoSection({
    IconData iconData,
    String text,
    Widget widget,
    Function function,
    bool textField,
    TextEditingController texteditController,
    bool numberKeyboard,
    bool phoneNumberKeyboard,
  }) {
    return GestureDetector(
      onTap: function != null
          ? function
          : () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
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
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                            keyboardType:
                                numberKeyboard == null || !numberKeyboard
                                    ? TextInputType.text
                                    : TextInputType.number,
                            maxLength: phoneNumberKeyboard != null &&
                                    phoneNumberKeyboard
                                ? 10
                                : null,
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

  Widget _locationPickingSection({
    String text,
    BuildContext context,
    Function function,
  }) {
    return Container(
      width: (MediaQuery.of(context).size.width - 50) / 3,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xff5ad849),
        borderRadius: BorderRadius.circular(12),
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onPressed: function == null ? () {} : function,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  _buildBottomSheet(
      BuildContext context, Map<int, String> map, bool isAreaIndex) {
    String result;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListView.builder(
            itemCount: map.length,
            itemBuilder: (context, index) {
              return StatefulBuilder(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isAreaIndex
                            ? _areaIndex = index
                            : _postCategoryIndex = index;
                        result = map.values.elementAt(index);
                        Navigator.of(context).pop();
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 20, left: 20),
                      color: Colors.red.withOpacity(0.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            map.values.elementAt(index),
                            style: TextStyle(fontSize: 20),
                          ),
                          _postCategoryIndex == index
                              ? Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.red,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        });
    return result;
  }

  Widget _buildImageSection(double height) {
    return _imageFile == null
        ? Container()
        : Container(
            height: height,
            child: Image.file(
              _imageFile,
            ),
          );
  }

  @override
  void dispose() {
    _addPostBloc.dispose();
    super.dispose();
  }
}
