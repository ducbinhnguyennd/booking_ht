import 'package:booking_hotel/routers.dart';
import 'package:booking_hotel/screens/discover_screen.dart';
import 'package:booking_hotel/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    int backButtonCount = 0;
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      title: 'MangaLand',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.exo2TextTheme(textTheme).copyWith(
          bodyMedium: GoogleFonts.oswald(textStyle: textTheme.bodyMedium),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: routes,
      home: Builder(
        builder: (BuildContext context) => WillPopScope(
          onWillPop: () async {
            backButtonCount++;

            if (backButtonCount == 2) {
              SystemNavigator.pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Nhấn Back lần nữa để thoát"),
                  duration: Duration(seconds: 2),
                ),
              );
            }
            return false;
          },
          child: const SplashScreen(),
        ),
      ),
    );
  }
}
