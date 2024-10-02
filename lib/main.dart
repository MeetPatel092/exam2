import 'package:exam2/views/screens/home_page.dart';
import 'package:exam2/views/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "splash_page",
      routes: {
        '/': (context) => HomePage(),
        'splash_page': (context) => SplashPage(),
      },
    ),
  );
}
