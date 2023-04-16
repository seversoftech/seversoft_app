import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.rawSnackbar(
        snackPosition: SnackPosition.TOP,
        messageText: Text('There is an Error in Network Communication.',
            style: TextStyle(
                letterSpacing: 1.5, fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.center),
        titleText: SvgPicture.asset('assets/icons/no_signal.svg'),
        isDismissible: false,
        duration: const Duration(days: 7),
        backgroundColor: Colors.white,
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED,
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}
