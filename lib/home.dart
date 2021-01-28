import 'package:flutter/material.dart';
import 'package:imagebutton/imagebutton.dart';
import 'package:tracking_app2/healthTracking.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {                                           //Main
  int choosenCat = 1;                                                            //var needed for helper function to display the correct category of data to be recorded
  String workoutTxt = "";                                                        //var for text inputed to record the workout movement
  String muscleString;                                                          // string for the drop down button to show all muscle drops
  String workoutString;
  String muscleHint = 'Please choose muscle group';
  List muscles = ["Legs", "Core", "Chest", "Shoulders", "Biceps", "Triceps", "Back"];
  List legs = ['Barbell Back Squat', 'Barbell Front Squat', 'Deadlift',"Sumo Deadlift", 'Calf Raises', "Bulgarians", "Hip Band Walks"];
  List core = ['Core Cycle A', 'Core Cycle B'];
  List chest = ['Bench Press', 'Incline Bench Press', 'Decline Bench Press', 'Db Press', 'Incline Db Press', 'Decline Db Press', '1 Arm Rb Fly','1 Arm Incline Rb Fly', '1 Arm Decline Rb Fly', 'Bear Hugs', 'Chest Dips'];
  List shoulders = ['Scoop Raises', 'Db Front Delt Raises', 'Db Side Delt Raises', 'Db Rear Delt Raises', 'Rb Front Delt Raises', 'Rb Side Delt Raises', 'Rb Rear Delt Raises', 'Face Pulls'];
  List biceps = ['Waiter Curls', 'Hammer Curls', 'In & Out Curls', 'In-Knee Curl', 'Rb Prayer Curls', "21's"];
  List triceps = ['Overheard Extensions', 'Rb Tricep Pushdowns', 'Bent Over Tricep Kickbacks', 'Head Crushers'];
  List back = ["Supermans", '1 arm Rb Lat Pulls', 'Pullups', 'Wide-Grip Pullups', 'Rb Pulldowns', 'Shrugs', 'Rb Rows', 'Bent over Rows', "Db Reverse Fly's"];
  List<DropdownMenuItem<String>> menuItems = List();


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(                                                          //the scaffold where everything sits on
        backgroundColor: Colors.white,
        body: TabBarView(
          children: <Widget>[                                                   //each container is one of the tabs
            getSetting(choosenCat),                                             //function that returns the desired widget and more
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

                                                                                //helper function to reset the state to display the desired data collection category
  Widget getSetting(int setting){
     //all possible major muscle groups
    switch (setting) {
      case 1: {                                                                 //the home page with 4 options
        return Container(
          color: Color.fromRGBO(220, 220, 220, 1.0),
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
      case 2: {                                                                 //the health option
        return HealthTracking();
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
    };



  }


}


