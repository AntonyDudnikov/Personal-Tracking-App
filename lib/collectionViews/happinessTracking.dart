import 'package:flutter/material.dart';


class HappinessTracking extends StatefulWidget {
  static String route = 'happinessTracking';
  @override
  _HappinessTrackingState createState() => _HappinessTrackingState();
}

class _HappinessTrackingState extends State<HappinessTracking> {
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
                  child: Container(                                                //Title
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('lib/assets/happinessBackground.jpg'),
                            fit: BoxFit.fill
                        )
                    ),
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
