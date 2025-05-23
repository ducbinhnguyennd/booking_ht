import 'package:booking_hotel/screens/account/login_screen.dart';
import 'package:booking_hotel/screens/account/register_screen.dart';
import 'package:booking_hotel/screens/main_screen.dart';
import 'package:booking_hotel/screens/splash_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => const LoginScreen(),
  MainScreen.routeName: (context) => const MainScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),
  RegisterScreen.routeName: (context) => const RegisterScreen(),
};
