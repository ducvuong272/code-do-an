import 'package:flutter/material.dart';

class ManagementList extends StatelessWidget {
  final Map<String, dynamic> map;

  const ManagementList({Key key, this.map}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 5),
      elevation: 4.0,
      shape: Border(
        top: BorderSide(
          color: Colors.black,
          width: 1,
        ),
        left: BorderSide(
          color: Colors.black,
          width: 1,
        ),
        right: BorderSide(
          color: Colors.black,
          width: 1,
        ),
        bottom: BorderSide(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Container(
          height: 50,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width - 100,
        child: Center(
          child: Text(
            '${map['TenLoaiHinhDiaDiem']}',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
                Text('Sửa'),
              ],
            ),
            Column(
              children: <Widget>[
                Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                Text('Xóa'),
              ],
            ),
          ],
        ),
      )
            ],
          ),
        ),
    );
  }
}
