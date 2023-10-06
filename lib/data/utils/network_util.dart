import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtil {
  static bool lastNetworkCheck = false;

  // static Future<bool> hasNetwork(String url) async {
  //   try {
  //     final result = await InternetAddress.lookup(url);
  //     lastNetworkCheck = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  //   } on SocketException catch (_) {
  //     lastNetworkCheck = false;
  //   }
  //   return lastNetworkCheck;
  // }
  static Future<bool> hasNetwork(String url) async {
    try {
      final ConnectivityResult connectivityResult =
          await (Connectivity().checkConnectivity());
      print(connectivityResult.toString());
      lastNetworkCheck = connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile;
    } catch (e) {
      print(e);
      lastNetworkCheck = false;
    }
    return lastNetworkCheck;
  }
}
