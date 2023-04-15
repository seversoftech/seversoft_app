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
        titleText: SvgPicture.asset(
          'assets/icons/no_signal.svg',
          allowDrawingOutsideViewBox: false,
          height: 400,
        ),
        messageText: const Text(
            'There was an error connecting to the network. Please check your internet connection and try again. If the problem persists, please contact your network administrator for assistance.',
            style: TextStyle(
                color: Color.fromARGB(255, 3, 19, 109), fontSize: 20)),
        isDismissible: false,
        duration: const Duration(days: 1),
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
