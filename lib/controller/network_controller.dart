import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        titleText: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ErrorImg(),
            // RetryButton(
            //   onPressed: () {},
            // )
          ],
        ),
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
    return SvgPicture.asset(
      height: 200,
      'assets/icons/no_signal.svg',
      // allowDrawingOutsideViewBox: false,
    );
  }
}

class RetryButton extends StatelessWidget {
  final Function() onPressed;

  const RetryButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color.fromARGB(255, 3, 19, 109);

    const double borderRadius = 40;

    return OutlinedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NavBarHome()),
        );
      },
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          "Network Error",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w300, color: primaryColor),
        ),
        Icon(Icons.refresh, color: primaryColor)
      ]),
      style: ButtonStyle(
        side: MaterialStateProperty.all(
            BorderSide(color: primaryColor, width: 1.3)),
        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
        ),
      ),
    );
  }
}
