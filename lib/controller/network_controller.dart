import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        titleText: Text(
          ' Cannot connect to network.',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFF090735)),
        ),
        messageText: const Text(
            'There was an error connecting to the network. Please check your internet connection and try again. If the problem persists, please contact your network administrator for assistance.',
            style: TextStyle(color: Colors.white, fontSize: 24)),
        isDismissible: false,
        duration: const Duration(days: 1),
        backgroundColor: Color.fromARGB(255, 230, 15, 8),
        // icon: SvgPicture.asset(
        //   'assets/icons/no_signal.svg',
        //   height: 500,
        //   width: 500,
        //   allowDrawingOutsideViewBox: true,
        // ),
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
