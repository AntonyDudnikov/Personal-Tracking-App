import 'package:flutter/material.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:tracking_app2/collectionViews/happinessTracking.dart';
import 'package:tracking_app2/collectionViews/hourlyTracking.dart';
import 'collectionViews/healthTracking.dart';
import 'collectionViews/coffeeTracking.dart';
import 'collectionViews/mediaTracking.dart';
import 'collectionViews/beerTracking.dart';

class Home extends StatefulWidget {
  static String route = 'home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {                                           //Main

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(                                                          //the scaffold where everything sits on
        backgroundColor: Colors.white,
        body: TabBarView(
          children: <Widget>[                                                   //each container is one of the tabs
            Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlatButton(
                        height: 150,
                        minWidth: 150,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.blue, width: 3)
                        ),
                        child: Text("DRINKS",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 30,
                            )
                        ),
                        onPressed: (){
                          Navigator.pushNamed(context, BeerTracking.route);
                        },
                      ),
                      FlatButton(
                        height: 150,
                        minWidth: 150,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.blue, width: 3)
                        ),
                        child: Text("COFFEE",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 30,
                            )
                        ),
                        onPressed: (){
                          Navigator.pushNamed(context, CoffeeTracking.route);
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlatButton(
                        height: 150,
                        minWidth: 150,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.blue, width: 3)
                        ),
                        child: Text("MEDIA",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 30,
                            )
                        ),
                        onPressed: (){
                          Navigator.pushNamed(context, MediaTracking.route);
                        },
                      ),
                      FlatButton(
                        height: 150,
                        minWidth: 150,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.blue, width: 3)
                        ),
                        child: Text("HEALTH",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 30,
                            )
                        ),
                        onPressed: (){
                          Navigator.pushNamed(context, HealthTracking.route);
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlatButton(
                        height: 150,
                        minWidth: 150,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.blue, width: 3)
                        ),
                        child: Text("TIME",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 30,
                            )
                        ),
                        onPressed: (){
                          Navigator.pushNamed(context, HourlyTracking.route);
                        },
                      ),
                      FlatButton(
                        height: 150,
                        minWidth: 150,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.blue, width: 3)
                        ),
                        child: Text("HAPPINESS",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                            )
                        ),
                        onPressed: (){
                          Navigator.pushNamed(context, HappinessTracking.route);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),                                             //function that returns the desired widget and more
            Container(                                                          //the data visualization view
              color: Colors.blue,
            ),
          ],
        ),
        bottomNavigationBar: Material(
          color: Color.fromRGBO(220, 220, 220, 1.0),                             //allows to change the colour of the tab controller
          child: TabBar(                                                         //the tab controller on the bottom
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.people),
              ),
            ],
            labelColor: Color.fromRGBO(255, 255, 255, 0.8),
            unselectedLabelColor: Color.fromRGBO(255, 255, 255, 0.3),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Color.fromRGBO(255, 255, 255, 0.8),
            indicatorPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 4.0),
            indicatorWeight: 4.0,
          ),
        ),
      ),
    );
  }
}





