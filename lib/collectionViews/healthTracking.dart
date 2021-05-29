import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_picker/flutter_picker.dart';


class HealthTracking extends StatefulWidget {
  static String route = 'healthTracking';
  @override
  _HealthTrackingState createState() => _HealthTrackingState();
}

class _HealthTrackingState extends State<HealthTracking> {
  String muscleString;                                                          // string for the drop down button to show all muscle drops
  String workoutString;
  int runMinutes;
  int runSeconds;
  int cycleHours;
  int cycleMinutes;
  bool addWorkout = false;                                                      //trigger variables for the addition of workout construciotns
  bool removeWorkout = false;
  List muscles = ["Legs", "Core", "Chest", "Shoulders", "Biceps", "Triceps", "Back"];
  List legs = ['Barbell Back Squat', 'Barbell Front Squat', 'Deadlift',"Sumo Deadlift", 'Calf Raises', "Bulgarians", "Hip Band Walks"];
  List core = ['Core Cycle A', 'Core Cycle B'];
  List chest = ['Bench Press', 'Incline Bench Press', 'Decline Bench Press', 'Db Press', 'Incline Db Press', 'Decline Db Press', '1 Arm Rb Fly','1 Arm Incline Rb Fly', '1 Arm Decline Rb Fly', 'Bear Hugs', 'Chest Dips'];
  List shoulders = ['Scoop Raises', 'Db Front Delt Raises', 'Db Side Delt Raises', 'Db Rear Delt Raises', 'Rb Front Delt Raises', 'Rb Side Delt Raises', 'Rb Rear Delt Raises', 'Face Pulls'];
  List biceps = ['Waiter Curls', 'Hammer Curls', 'In & Out Curls', 'In-Knee Curl', 'Rb Prayer Curls', "21's"];
  List triceps = ['Overheard Extensions', 'Rb Tricep Pushdowns', 'Bent Over Tricep Kickbacks', 'Head Crushers'];
  List back = ["Supermans", '1 arm Rb Lat Pulls', 'Pullups', 'Wide-Grip Pullups', 'Rb Pulldowns', 'Shrugs', 'Rb Rows', 'Bent over Rows', "Db Reverse Fly's"];
  List<DropdownMenuItem<String>> workoutMenuItems = List();                     //dropdown menu time list for the workout of the specific muscle
  List<Widget> setRep = [];                                                     //list of row() that display reps and weight of set
  Map tempWorkoutSetsReps = {};                                                 //the current workout sets & reps, move to finalized, workoutSetsReps, once completed by user
  Map workoutSetsReps = {};                                                     //finalized data to push to server/database
  final weightController = TextEditingController();                             //text controller for the weight input textfield
  final repsController = TextEditingController();                               //text controller for the reps input textfield
  final bodyWeightController = TextEditingController();                         //text controller for body weight
  final stepsController = TextEditingController();                              //text controller for daily steps taken
  final kmRunController = TextEditingController();                              //text Controller for km's ran
  final timeRunController = TextEditingController();                            //text controller for time that run took
  final kmCycledController = TextEditingController();                           //text Controller for km's cycled
  final timeCycledController = TextEditingController();                         //text Controller for time that cycle took
  Map enableDenable = {'wokeUp': false, 'sleep': false, 'workouts': false,      //map for true/false values for blocking the data collection tiles when values are inputed
    'bodyWeight': false, 'steps': false, 'runs': false}; //

///Helper function to repopulate the workoutMenuItems after each alteration of the workout lists, or after chosen muscle group
  void populateDropItems(List workouts){
    workoutMenuItems = [];
    for (String x in workouts){
      workoutMenuItems.add(DropdownMenuItem<String>(
        value: x,
        child: Text(x),
      ));
    };
  }

  ///Helper function to populate setRep children list of column() with the reps & weight of each set, called when add is pressed
  void populateSetReps(String muscle, String workout){
    setRep = [];
    for (List listPair in tempWorkoutSetsReps[muscleString][workoutString]){
      setRep.add(Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            listPair[0].toString(),
            style: TextStyle(fontSize: 20),
          ),
          Text(
            ' reps of ',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            listPair[1].toString(),
            style: TextStyle(fontSize: 20),
          ),
        ],
      ));
    }
  }

///Helper function to return the required list when the string input of muscle
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

///To create a textfield or dropdown list to change the workouts list of items, to add/remove
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
                findMuscleList(muscleString).add(str);
                print(findMuscleList(muscleString));
                addWorkout = false;
                populateDropItems(findMuscleList(muscleString));
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
        items: findMuscleList(muscleString).map<DropdownMenuItem<String>>((stringItem) {
          return DropdownMenuItem(
            value: stringItem,
            child: Text(stringItem),
          );
        }).toList(),
        onChanged: (String newValue) { //upon click, remove item from workout, repopulate workouts list, remove dropdown
          findMuscleList(muscleString).remove(newValue);
          setState((){
            removeWorkout = false;

            (newValue == workoutString) ? workoutString = null : null;
            populateDropItems(findMuscleList(muscleString)); //repopulate the workouts list
          });
        },
      );
    }else {
      return SizedBox(height: 0);
    }
  }
  /// creates the picker for the min and sec for the run and the hr and min for the cycle
  showPickerNumber(BuildContext context, String activity) {
    Picker(
        adapter: (activity == 'run') ? NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: 60, suffix: Text('min')),
          NumberPickerColumn(begin: 0, end: 60,  suffix: Text('sec')),
        ]) : NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: 24, suffix: Text('hr')),
          NumberPickerColumn(begin: 0, end: 60,  suffix: Text('min')),
        ]),
        delimiter: [
          PickerDelimiter(child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: Icon(Icons.more_vert),
          ))
        ],
        hideHeader: true,
        title: Text("Please Select"),
        selectedTextStyle: TextStyle(color: Colors.blue),
        onConfirm: (Picker picker, List value) {
          setState(() {
            if (activity == 'run'){
              timeRunController.text = "${value[0].toString()} min, ${value[1].toString()} sec";
              runMinutes = value[0];
              runSeconds = value[1];
            }else{
              timeCycledController.text = "${value[0].toString()} hr, ${value[1].toString()} min";
              cycleHours = value[0];
              cycleMinutes = value[1];
            };
          });
        }
    ).showDialog(context);
  }

  @override
  void dispose() {
    weightController.dispose();
    repsController.dispose();
    bodyWeightController.dispose();
    stepsController.dispose();
    kmRunController.dispose();
    timeRunController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(245, 245, 245, 1.0),
        child: Stack(
          children: [ListView(
            addAutomaticKeepAlives: false,
            children: [
              Container(
                height: 200,
                color: Colors.lightBlue,
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
                margin: EdgeInsets.fromLTRB(20, 15, 0, 15),
                //padding: EdgeInsets.fromLTRB(10, 0, 300, 0),
                child: Center(
                  child: Text(
                    'SLEEP',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontFamily: 'KronaOne Regular'
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 130,
                    width: 170,
                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
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
                    margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
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
                margin: EdgeInsets.fromLTRB(20, 15, 0, 15),
                //padding: EdgeInsets.fromLTRB(10, 0, 300, 0),
                child: Center(
                  child: Text(
                    'WORKOUTS',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontFamily: 'KronaOne Regular',
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Column(
                  children: <Widget>[
                    DropdownButton<String>(
                      dropdownColor: Colors.white,
                      value: this.muscleString,
                      hint: Text('Please choose muscle group'),
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
                          setRep = [];
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
                                  setRep = [];
                                });
                              },
                            ),
                          ),
                        ),
                        IconButton(
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
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Row(
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
                                print(repsController.text);
                                if ((muscleString != null || workoutString != null)&& (repsController.text != '' && weightController.text != '')) {
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
                                repsController.text = '';
                                weightController.text = '';
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
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(100, 0, 0, 0),
                      child: Column(
                        children: (setRep.length == 0) ? [SizedBox(height: 0)] : setRep,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: (setRep.length == 0) ? [SizedBox(height: 0)] : [Container(
                        height: 28,
                        width: 80,
                        margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                        child: FlatButton(
                          color: Colors.blue,
                          child: Text('Done', style: TextStyle(fontSize: 16,color: Colors.white)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.blue)
                          ),
                          onPressed: () {
                            workoutSetsReps.addAll(tempWorkoutSetsReps[muscleString]);
                            print(workoutSetsReps);
                            setState(() {
                              setRep = [];
                              muscleString = null;
                              workoutString = null;
                            });
                          },
                        ),
                      )],
                    ),
                  ],
                ),
              ),
              Container(
                height: 25,
                margin: EdgeInsets.fromLTRB(20, 15, 0, 15),
                //padding: EdgeInsets.fromLTRB(10, 0, 300, 0),
                child: Center(
                  child: Text(
                    'BODY WEIGHT',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontFamily: 'KronaOne Regular',
                    ),
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
                //color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: Text(
                          "Body Weight:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        width: 220,
                        height: 40,
                        child: TextField(
                          controller: bodyWeightController,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 25,
                margin: EdgeInsets.fromLTRB(20, 15, 0, 15),
                //padding: EdgeInsets.fromLTRB(10, 0, 300, 0),
                child: Center(
                  child: Text(
                    'STEPS WALKED',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontFamily: 'KronaOne Regular',
                    ),
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
                //color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: Text(
                          "Steps walked:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        width: 220,
                        height: 40,
                        child: TextField(
                          controller: stepsController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 25,
                margin: EdgeInsets.fromLTRB(20, 15, 0, 15),
                //padding: EdgeInsets.fromLTRB(10, 0, 300, 0),
                child: Center(
                  child: Text(
                    'RUNS',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontFamily: 'KronaOne Regular',
                    ),
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
                //color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Container(
                            width: 140,
                            child: Text(
                              "Km ran:",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                            width: 220,
                            height: 40,
                            child: TextField(
                              controller: kmRunController,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Container(
                            width: 140,
                            child: Text(
                              "Time took:",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            child: TextField(
                              enabled: false,
                              controller: timeRunController,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                            child: FlatButton(
                                height: 30,
                                minWidth: 50,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(color: Colors.blue)
                                ),
                                onPressed: (){
                                  showPickerNumber(context, 'run');
                                },
                                child: Text('Time', style: TextStyle(color: Colors.blue),)
                            ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 25,
                margin: EdgeInsets.fromLTRB(20, 15, 0, 15),
                //padding: EdgeInsets.fromLTRB(10, 0, 300, 0),
                child: Center(
                  child: Text(
                    'BIKE RIDES',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontFamily: 'KronaOne Regular',
                    ),
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
                //color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Container(
                            width: 140,
                            child: Text(
                              "Km Cycled:",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                            width: 220,
                            height: 40,
                            child: TextField(
                              controller: kmCycledController,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Container(
                            width: 140,
                            child: Text(
                              "Time took:",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            child: TextField(
                              enabled: false,
                              controller: timeCycledController,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: FlatButton(
                              height: 30,
                              minWidth: 50,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Colors.blue)
                              ),
                              onPressed: (){
                                showPickerNumber(context, 'bike');
                              },
                              child: Text('Time', style: TextStyle(color: Colors.blue),)
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15)
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
