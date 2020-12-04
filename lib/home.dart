import 'package:flutter/material.dart';
import 'package:imagebutton/imagebutton.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int choosenCat = 1; //var needed for helper function to display the correct category of data to be recorded
  String workoutTxt = ""; //var for text inputed to record the workout movement

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(          //the scaffold where everything sits on
        backgroundColor: Colors.white,
        body: TabBarView(
          children: <Widget>[       //each container is one of the tabs
            getSetting(choosenCat),   //function that returns the desired widget and more
            Container(              //the data visualization view
              color: Colors.blue,
            ),
          ],
        ),
        bottomNavigationBar: Material(
          color: Color.fromRGBO(27, 27, 27, 0.95), //allows to change the colour of the tab controller
          child: TabBar(      //the tab controller on the bottom
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
  //helper function to reset the state to display the desired data collection category
  Widget getSetting(int setting){
    switch (setting) {
      case 1: {                   //the home page with 4 options
        return Container(              //the data recording view
          color: Color.fromRGBO(27, 27, 27, 0.95),
          child: Stack(
            children: <Widget>[
              Align(
                  alignment: Alignment(0.75,-0.4),
                  child: ImageButton(children: [], unpressedImage: Image.asset("beer_pic.png"), pressedImage: Image.asset("beer_pic.png"), width: 150, height: 130, onTap: () {setState(() {choosenCat = 3;});},)
              ),
              Align(
                  alignment: Alignment(0.75,0.6),
                  child: ImageButton(children: [], unpressedImage: Image.asset("coffee_pic.png"), pressedImage: Image.asset("coffee_pic.png"), width: 150, height: 150, onTap: () {setState(() {choosenCat = 5;});},)
              ),
              Align(
                  alignment: Alignment(-0.75, 0.6),
                  child: ImageButton(children: [], unpressedImage: Image.asset("media.png"), pressedImage: Image.asset("media.png"), width: 150, height: 130, onTap: () {setState(() {choosenCat = 4;});},)
              ),
              Align(
                  alignment: Alignment(-0.75,-0.4),
                  child: ImageButton(children: [], unpressedImage: Image.asset("health.png"), pressedImage: Image.asset("health.png"), width: 150, height: 150, onTap: () {setState(() {choosenCat = 2;});},)
              ),
            ],
          ),
        );
      }
      case 2: {                   //the health option
        return Container(
          color: Color.fromRGBO(27, 27, 27, 0.95),
          child: Column(
            children: [
              SizedBox(height: 43),
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Container(width: 10, color: Colors.red,),
                    Expanded(
                      child: Container(
                        height: 100,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.lightGreenAccent),
                          ),
                          color: Color.fromRGBO(27, 27, 27, 0.95),
                          textColor: Colors.lightGreenAccent,
                          child: Text('WOKE UP', style: TextStyle(fontSize: 18),),
                          onPressed: () {},                                           //TODO: record wake up
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Container(
                        height: 100,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.lightGreenAccent),
                          ),
                          color: Color.fromRGBO(27, 27, 27, 0.95),
                          textColor: Colors.lightGreenAccent,
                          child: Text('WENT TO SLEEP', style: TextStyle(fontSize: 18),),
                          onPressed: () {},                                           //TODO: record sleep time
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                  ],
                ),
              ),
              Container(
                height: 25,
                //padding: EdgeInsets.fromLTRB(10, 0, 300, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 10,),
                    Text(
                    'WORKOUTS:',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),]
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(width: 10, color: Colors.green,),
                    Expanded(
                      child: Container(
                        height: 60,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.lightGreenAccent),
                          ),
                          color: Color.fromRGBO(27, 27, 27, 0.95),
                          textColor: Colors.lightGreenAccent,
                          child: Text("BACK", style: TextStyle(fontSize: 18),),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Container(
                        height: 60,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.lightGreenAccent),
                          ),
                          color: Color.fromRGBO(27, 27, 27, 0.95),
                          textColor: Colors.lightGreenAccent,
                          child: Text("SHOULDERS", style: TextStyle(fontSize: 14),),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child: Container(
                        height: 60,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.lightGreenAccent),
                          ),
                          color: Color.fromRGBO(27, 27, 27, 0.95),
                          textColor: Colors.lightGreenAccent,
                          child: Text("ARMS", style: TextStyle(fontSize: 18),),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Container(width: 10, color: Colors.green,),
                    Expanded(
                      child: Container(
                        height: 60,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.lightGreenAccent),
                          ),
                          color: Color.fromRGBO(27, 27, 27, 0.95),
                          textColor: Colors.lightGreenAccent,
                          child: Text("CORE", style: TextStyle(fontSize: 18),),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Container(
                        height: 60,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.lightGreenAccent),
                          ),
                          color: Color.fromRGBO(27, 27, 27, 0.95),
                          textColor: Colors.lightGreenAccent,
                          child: Text("CHEST", style: TextStyle(fontSize: 14),),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child: Container(
                        height: 60,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.lightGreenAccent),
                          ),
                          color: Color.fromRGBO(27, 27, 27, 0.95),
                          textColor: Colors.lightGreenAccent,
                          child: Text("LEGS", style: TextStyle(fontSize: 18),),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                  ],
                ),
              ),
              Expanded( //TODO: fix the textinput widget
                flex: 1,
                child: Row(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Input movement'
                      ),
                      onSubmitted: (String str) {
                        workoutTxt = str;
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(color: Colors.white,),
              ),

            ],
          ),
        );
      }
      case 3: {                   //the beer option
        return Container();
      }
      case 4: {                   //the media option
        return Container();
      }
      case 5: {                   //the coffee option
        return Container();
      }
    }
  }


}


