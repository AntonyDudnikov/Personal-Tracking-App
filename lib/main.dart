import 'package:flutter/material.dart';
import 'package:tracking_app2/collectionViews/coffeeTracking.dart';
import 'package:tracking_app2/collectionViews/happinessTracking.dart';
import 'loading.dart';
import 'home.dart';
import 'collectionViews/healthTracking.dart';
import 'collectionViews/coffeeTracking.dart';
import 'collectionViews/mediaTracking.dart';
import 'collectionViews/beerTracking.dart';
import 'collectionViews/hourlyTracking.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: Loading.route,
    routes: <String, WidgetBuilder>{
      Loading.route:(context) => Loading(),
      Home.route: (context) => Home(),
      HealthTracking.route: (context) => HealthTracking(),
      CoffeeTracking.route: (context) => CoffeeTracking(),
      MediaTracking.route: (context) => MediaTracking(),
      BeerTracking.route: (context) => BeerTracking(),
      HourlyTracking.route: (context) => HourlyTracking(),
      HappinessTracking.route: (context) => HappinessTracking(),
    },

  ));
}
