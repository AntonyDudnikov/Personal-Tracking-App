import 'package:flutter/material.dart';


class MediaTracking extends StatefulWidget {
  static String route = 'mediaTracking';
  @override
  _MediaTrackingState createState() => _MediaTrackingState();
}

class _MediaTrackingState extends State<MediaTracking> {






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
                    color: Color.fromRGBO(0, 255, 0, 0.5),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Text(
                      'MEDIA',
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
