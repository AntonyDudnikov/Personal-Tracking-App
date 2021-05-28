import 'package:flutter/material.dart';


class HourlyTracking extends StatefulWidget {
  static String route = 'hourlyTracking';
  @override
  _HourlyTrackingState createState() => _HourlyTrackingState();
}

class _HourlyTrackingState extends State<HourlyTracking> {
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
                                image: AssetImage('lib/assets/clockBackground.jpg'),
                                fit: BoxFit.fill
                            )
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Text(
                          'TIME',
                          style: TextStyle(
                              color: Colors.white,
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

