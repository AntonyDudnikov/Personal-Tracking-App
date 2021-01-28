import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';


class HealthTracking extends StatefulWidget {
  @override
  _HealthTrackingState createState() => _HealthTrackingState();
}

class _HealthTrackingState extends State<HealthTracking> {
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

  void populateDropItems(String muscle, List workouts){
    menuItems = [];
    for (String x in workouts){
      menuItems.add(DropdownMenuItem<String>(
        value: x,
        child: Text(x),
      ));
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(245, 245, 245, 1.0),
      child: ListView(
        addAutomaticKeepAlives: false,
        children: [
          Container(
            height: 200,
            color: Colors.white,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Stack(
              children: <Widget>[
                Container(color: Colors.lightBlue,),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(
                    'HEALTH',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 130,
                width: 170,
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                            image:AssetImage("day.JPG"),
                            fit:BoxFit.cover
                        ), // button text
                      ),
                      child: Stack(
                        children: <Widget>[
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Woke Up",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 2
                                    ..color = Colors.black,
                                ),
                              )
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Woke Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                          ),
                        ],
                      )
                    ),
                    onTap:(){
                      print('works');//TODO record wake up
                    }
                ),
              ),
              Container(
                height: 130,
                width: 170,
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: GestureDetector(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                              image:AssetImage("night.JPG"),
                              fit:BoxFit.cover
                          ), // button text
                        ),
                        child: Stack(
                          children: <Widget>[
                            Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Went to sleep",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 2
                                      ..color = Colors.black,
                                  ),
                                )
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Went to sleep",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ),
                          ],
                        )
                    ),
                    onTap:(){
                      //TODO record sleep
                    }
                ),
              ),
            ],
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
                    style: TextStyle(fontSize: 17, color: Colors.black),
                  ),]
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: DropdownButton<String>(
              dropdownColor: Colors.white,
              value: this.muscleString,
              hint: Text(muscleHint),
              isExpanded: true,
              items: muscles.map<DropdownMenuItem<String>>((stringItem) {
                return DropdownMenuItem(
                  value: stringItem,
                  child: Text(stringItem),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState((){
                  this.workoutString = null;
                  this.muscleString = newValue;
                  if (newValue == "Legs"){
                    populateDropItems(newValue, legs);
                  }else if (newValue == 'Core'){
                    populateDropItems(newValue, core);
                  }else if (newValue == 'Chest'){
                    populateDropItems(newValue, chest);
                  }else if (newValue == 'Shoulders'){
                    populateDropItems(newValue, shoulders);
                  }else if (newValue == 'Biceps'){
                    populateDropItems(newValue, biceps);
                  }else if (newValue == 'Triceps'){
                    populateDropItems(newValue, triceps);
                  }else if (newValue == 'Back'){
                    populateDropItems(newValue, back);
                  }else{
                    print('ERROR');
                  }
                });
              },
            ),                                                        //TODO DropdownMenu
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: DropdownButton<String>(
              dropdownColor: Colors.white,
              value: this.workoutString,
              isExpanded: true,
              hint: Text('Please choose muscle group'),
              disabledHint: Text('Choose muscle first.'),
              items: menuItems,
              onChanged: (String newValue) {
                setState((){
                  this.workoutString = newValue;
                  this.muscleHint = this.muscleString;
                  this.muscleString = null;
                });
              },
            ),                                                       //TODO DropdownMenu
          )
        ],
      ),
    );
  }
}
