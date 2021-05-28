import 'package:flutter/material.dart';



class CoffeeTracking extends StatefulWidget {
  static String route = 'coffeeTracking';
  @override
  _CoffeeTrackingState createState() => _CoffeeTrackingState();
}

class _CoffeeTrackingState extends State<CoffeeTracking> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            ListView(
              addAutomaticKeepAlives: false,
              children: [
                Container(
                  height: 200,
                  child: Stack(
                    children: [
                      Container(                                                //Title
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('lib/assets/latte_background.jpg'),
                            fit: BoxFit.fill
                          )
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Text(
                          'COFFEE',
                          style: TextStyle(
                              color: Colors.brown,
                              fontSize: 45,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),
            Positioned(
              top: 50,
              left: 10,
              child: FlatButton(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                child: Text('Back', style: TextStyle(color: Colors.black, fontSize: 18)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.black, style: BorderStyle.solid)
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
