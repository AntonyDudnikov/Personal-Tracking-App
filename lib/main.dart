import 'package:flutter/material.dart';
import 'loading.dart';
import 'home.dart';
import 'healthTracking.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: 'loading',
    routes: {
      'loading':(context) => Loading(),
      'home': (context) => Home(),
      'trackingHealth': (context) => HealthTracking(),
    },

  ));
}
