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
  //String removeString;
  bool addWorkout = false;
  bool removeWorkout = false;
  String muscleHint = 'Please choose muscle group';
  List muscles = ["Legs", "Core", "Chest", "Shoulders", "Biceps", "Triceps", "Back"];
  List legs = ['Barbell Back Squat', 'Barbell Front Squat', 'Deadlift',"Sumo Deadlift", 'Calf Raises', "Bulgarians", "Hip Band Walks"];
  List core = ['Core Cycle A', 'Core Cycle B'];
  List chest = ['Bench Press', 'Incline Bench Press', 'Decline Bench Press', 'Db Press', 'Incline Db Press', 'Decline Db Press', '1 Arm Rb Fly','1 Arm Incline Rb Fly', '1 Arm Decline Rb Fly', 'Bear Hugs', 'Chest Dips'];
  List shoulders = ['Scoop Raises', 'Db Front Delt Raises', 'Db Side Delt Raises', 'Db Rear Delt Raises', 'Rb Front Delt Raises', 'Rb Side Delt Raises', 'Rb Rear Delt Raises', 'Face Pulls'];
  List biceps = ['Waiter Curls', 'Hammer Curls', 'In & Out Curls', 'In-Knee Curl', 'Rb Prayer Curls', "21's"];
  List triceps = ['Overheard Extensions', 'Rb Tricep Pushdowns', 'Bent Over Tricep Kickbacks', 'Head Crushers'];
  List back = ["Supermans", '1 arm Rb Lat Pulls', 'Pullups', 'Wide-Grip Pullups', 'Rb Pulldowns', 'Shrugs', 'Rb Rows', 'Bent over Rows', "Db Reverse Fly's"];
  List<DropdownMenuItem<String>> workoutMenuItems = List();                     //dropdown menu time list for the workout of the specific muscle
  List<Widget> setRep = [];                                                          //list of row() that display reps and weight of set
  Map tempWorkoutSetsReps = {};                                                 //the current workout sets & reps, move to finalized, workoutSetsReps, once completed by user
  Map workoutSetsReps = {};                                                     //finalized data to push to server/database
  final weightController = TextEditingController();                             //text controller for the weight input textfield
  final repsController = TextEditingController();                               //text controller for the reps input textfield

//helper function to repopulate the workoutMenuItems after each alteration of the workout lists, or after chosen muscle group
  void populateDropItems(List workouts){
    workoutMenuItems = [];
    for (String x in workouts){
      workoutMenuItems.add(DropdownMenuItem<String>(
        value: x,
        child: Text(x),
      ));
    };
  }

  void populateSetReps(String muscle, String workout){
    setRep = [];
    for (List listPair in tempWorkoutSetsReps[muscleString][workoutString]){
      setRep.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Reps:',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            listPair[0].toString(),
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'Weight:',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            listPair[1].toString(),
            style: TextStyle(fontSize: 18),
          ),
        ],
      ));
    }
  }

//helper function for adding/removing workout to return the right list when the list name is given in string
  List findMuscleList(String str){
    String value = str.toLowerCase();
    switch (value){
      case 'legs': {
        return legs;
      }
      case 'core': {
        return core;
      }
      case 'chest': {
        return chest;
      }
      case 'shoulders': {
        return shoulders;
      }
      case 'biceps': {
        return biceps;
      }
      case 'triceps': {
        return triceps;
      }
      case 'back': {
        return back;
      }
    }
  }

//to create a textfield or dropdown list to change the workouts list of items, to add/remove
  Widget addRemoveWorkout(bool add, bool remove) {
    if (add == true && remove == false){
      return Material(
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Add Workout',
          ),
          onSubmitted: (String str) {
            if (str != ''){
              print(str);
              setState(() {
                print('New State');
                findMuscleList(muscleHint).add(str);
                print(findMuscleList(muscleHint));
                addWorkout = false;
                populateDropItems(findMuscleList(muscleHint));
              });
            };
          },
        ),
      );
    }else if (add == false && remove == true){
      return DropdownButton<String>(
        dropdownColor: Colors.white,
        hint: Text('Click workout to delete'),
        //value: this.removeString,
        isExpanded: true,
        items: findMuscleList(muscleHint).map<DropdownMenuItem<String>>((stringItem) {
          return DropdownMenuItem(
            value: stringItem,
            child: Text(stringItem),
          );
        }).toList(),
        onChanged: (String newValue) { //upon click, remove item from workout, repopulate workouts list, remove dropdown
          findMuscleList(muscleHint).remove(newValue);
          setState((){
            removeWorkout = false;
            populateDropItems(findMuscleList(muscleHint)); //repopulate the workouts list
          });
        },
      );
    }else {
      return SizedBox(height: 0);
    }
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
          Container(
            height: 25,
            margin: EdgeInsets.fromLTRB(20, 0, 0, 20),
            //padding: EdgeInsets.fromLTRB(10, 0, 300, 0),
            child: Center(
              child: Text(
                'SLEEP:',
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 130,
                width: 170,
                margin: EdgeInsets.fromLTRB(20, 0, 0, 20),
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
                      print('Woke up');//TODO record wake up
                    }
                ),
              ),
              Container(
                height: 130,
                width: 170,
                margin: EdgeInsets.fromLTRB(10, 0, 20, 20),
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
                      print('Went to sleep');//TODO record sleep
                    }
                ),
              ),
            ],
          ),
          Container(
            height: 25,
            margin: EdgeInsets.fromLTRB(20, 0, 0, 20),
            //padding: EdgeInsets.fromLTRB(10, 0, 300, 0),
            child: Center(
              child: Text(
                'WORKOUTS:',
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Column(
              children: <Widget>[
                DropdownButton<String>(
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
                      addWorkout = false;                                       //remove the add/remove feature
                      removeWorkout = false;
                      this.workoutString = null;
                      this.muscleString = newValue;
                      populateDropItems(findMuscleList(newValue));
                    });
                  },
                ),
                Row(
                  children: <Widget>[
                    Container(
                      child: Expanded(
                        child: DropdownButton<String>(
                          dropdownColor: Colors.white,
                          value: this.workoutString,
                          isExpanded: true,
                          hint: Text('Please choose muscle group'),
                          disabledHint: Text('Choose muscle first.'),
                          items: workoutMenuItems,
                          onChanged: (String newValue) {
                            setState((){
                              this.workoutString = newValue;
                              this.muscleHint = this.muscleString;
                              //this.muscleString = null;
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: IconButton(
                          icon: Icon(
                            Icons.add_box,
                            size: 30,
                            color: Colors.blue,
                          ),
                          onPressed: (muscleString != null) ? () {
                            if (addWorkout == true){
                              setState(() {
                                addWorkout = false;
                              });
                            }else{
                              setState(() {
                                addWorkout = true;
                              });
                            }
                          } : null,
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.indeterminate_check_box,
                          size: 30,
                          color: Colors.red,
                        ),
                        onPressed: (muscleString != null) ? () {
                          if (removeWorkout == true){
                            setState(() {
                              removeWorkout = false;
                            });
                          }else{
                            setState(() {
                              removeWorkout = true;
                            });
                          }
                        } : null,
                    ),
                  ],
                ),
                addRemoveWorkout(addWorkout, removeWorkout),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Text('Reps:', style: TextStyle(fontSize: 14))
                    ),
                    Container(
                      width: 30,
                      height: 35,
                      child: TextField(
                        controller: repsController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Text('Weight:', style: TextStyle(fontSize: 14),)
                    ),
                    Container(
                      width: 60,
                      height: 35,
                      child: TextField(
                        controller: weightController,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      width: 75,
                      height: 28,
                      child: FlatButton(
                        color: Colors.blue,
                        child: Text('Add', style: TextStyle(fontSize: 16, color: Colors.white), ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.blue)
                        ),
                        onPressed: () {
                          print(weightController.text);
                          print(repsController.text);
                          print(muscleString);
                          print(workoutString);
                          if (muscleString != null || workoutString != null) {
                            setState(() {
                              //tempWorkoutSetsReps[muscleString] = {workoutString: [[repsController.text, weightController.text]]};
                              try {
                                tempWorkoutSetsReps[muscleString][workoutString].add([repsController.text, weightController.text]);
                              } on NoSuchMethodError {
                                tempWorkoutSetsReps[muscleString] = {workoutString: [[repsController.text, weightController.text]]};
                              }
                              populateSetReps(muscleString, workoutString);
                            });
                          }
                          print(tempWorkoutSetsReps);
                          },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                      width: 75,
                      height: 28,
                      child: FlatButton(
                        color: Colors.orangeAccent[400],
                        child: Text('Clear', style: TextStyle(fontSize: 16, color: Colors.white),),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.orangeAccent[400])
                        ),
                        onPressed: () {
                          setState(() {
                            tempWorkoutSetsReps = {};
                            setRep = [];
                          });
                        },
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(100, 0, 0, 0),
                  child: Column(
                    children: (setRep.length == 0) ? [SizedBox(height: 0)] : setRep,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
