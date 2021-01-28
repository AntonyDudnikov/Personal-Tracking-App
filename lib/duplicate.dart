import 'package:flutter/material.dart';
import 'package:imagebutton/imagebutton.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {                                           //Main
  int choosenCat = 1;                                                            //var needed for helper function to display the correct category of data to be recorded
  String workoutTxt = "";                                                        //var for text inputed to record the workout movement
  String muscle_string;                                                         // string for the drop down button to show all muscle drops
  String muscle_to_workout;
  String workout_string;
  List muscles = ["Legs", "Core", "Chest", "Shoulders", "Biceps", "Triceps", "Back"];
  List legs = ['Barbell Back Squat', 'Barbell Front Squat', 'Deadlift',"Sumo Deadlift", 'Calf Raises', "Bulgarians", "Hip Band Walks"];
  List core = ['Core Cycle A', 'Core Cycle B'];
  List chest = ['Bench Press', 'Incline Bench Press', 'Decline Bench Press', 'Db Press', 'Incline Db Press', 'Decline Db Press', '1 Arm Rb Fly','1 Arm Incline Rb Fly', '1 Arm Decline Rb Fly', 'Bear Hugs', 'Chest Dips'];
  List shoulders = ['Scoop Raises', 'Db Front Delt Raises', 'Db Side Delt Raises', 'Db Rear Delt Raises', 'Rb Front Delt Raises', 'Rb Side Delt Raises', 'Rb Rear Delt Raises', 'Face Pulls'];
  List biceps = ['Waiter Curls', 'Hammer Curls', 'In & Out Curls', 'In-Knee Curl', 'Rb Prayer Curls', "21's"];
  List triceps = ['Overheard Extensions', 'Rb Tricep Pushdowns', 'Bent Over Tricep Kickbacks', 'Head Crushers'];
  List back = ["Supermans", '1 arm Rb Lat Pulls', 'Pullups', 'Wide-Grip Pullups', 'Rb Pulldowns', 'Shrugs', 'Rb Rows', 'Bent over Rows', "Db Reverse Fly's"];

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
        return Container(
          color: Color.fromRGBO(240, 240, 240, 1.0),
          child: ListView(
            addAutomaticKeepAlives: false,
            children: [
              Row(
                children: [
                  Container(width: 10, color: Colors.red,),
                  Expanded(
                    child: Container(
                      height: 100,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Color.fromRGBO(255, 255, 255, 1.0)),
                        ),
                        color: Color.fromRGBO(30,144,255, 0.50),
                        textColor: Color.fromRGBO(0, 50, 50, 1.0),
                        child: Text('F=4, WOKE UP', style: TextStyle(fontSize: 18),),
                        onPressed: () {},                                           //TODO: record wake up
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.white),
                        ),
                        color: Color.fromRGBO(255,255,255, 0.95),
                        textColor: Colors.black,
                        child: Text('WENT TO SLEEP', style: TextStyle(fontSize: 18),),
                        onPressed: () {},                                       //TODO: record sleep time
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
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
                  child: ;                                                        //TODO
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Align(
                  alignment: Alignment(-0.7, 0),
                  child: DropdownButton<String>(
                    dropdownColor: Color.fromRGBO(128, 255, 0, 0.9),
                    value: workout_string,
                    hint: Text('Please choose workout'),
                    items: workout_items(muscle_to_workout).map<DropdownMenuItem<String>>((stringItem) {    //TODO: change back to workouts[muscle_to_workout]
                      return DropdownMenuItem<String>(
                        value: stringItem,
                        child: new Text(stringItem),
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        workout_string = newValue;
                        print(newValue);
                      });
                    },
                  ),
                ),
              )
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

  List workout_items(muscle_to_workout){
    if (workouts.containsKey(muscle_to_workout)){
      return workouts[muscle_to_workout];
    }else{
      return ['Please choose a Muscle Group First'];
    }




  }


}
