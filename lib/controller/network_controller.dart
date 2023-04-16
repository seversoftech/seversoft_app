import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seversoftapp/navbar.dart';
import '../screens/hompage.dart';

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
        titleText: ErrorImg(),
        messageText: Text('Message'),
        isDismissible: false,
        duration: const Duration(days: 1),
        backgroundColor: Colors.white,
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.FLOATING,
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}

class ErrorImg extends StatelessWidget {
  const ErrorImg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: ExactAssetImage('assets/images/icon.png'),
          fit: BoxFit.contain,
        )

            // child: SvgPicture.asset(

            //   height: 200,
            //   'assets/icons/no_signal.svg',
            //   // allowDrawingOutsideViewBox: false,
            // ),
            ));
  }
}


