import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class NetworkConnection {
  Future<bool> checkNetworkConnectivity(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text('Không có kết nối mạng'),
            ),
      );
      return false;
    }
    return true;
  }
}
