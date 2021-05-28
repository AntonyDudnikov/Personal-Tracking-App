import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  static String route = 'loading';
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  
  void getData() async{
    await Future.delayed(Duration(seconds: 3), () {
      print('data received');
    });
    Navigator.pushReplacementNamed(context, 'home');
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            color: Colors.grey[850],
            child: Center(
            child: SpinKitCubeGrid(
              color: Colors.white,
              size: 50,
              ),
            ),
          )
        ],
      ),
    );
  }

}


