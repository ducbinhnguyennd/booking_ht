import 'dart:async';
import 'package:booking_hotel/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:booking_hotel/constant/asset_path_const.dart';
import 'package:booking_hotel/constant/colors_const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static String routeName = '/splash_screen';

  @override
  State<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFirstTime = true;

  @override
  void initState() {
    super.initState();
    startSplashTimer();
    // checkFirstRead();
    // checkLoginStatus();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void startSplashTimer() {
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: ColorConst.colorPrimary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AssetsPathConst.splashBackgroundNgonTinh,
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              'MangaLand',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
