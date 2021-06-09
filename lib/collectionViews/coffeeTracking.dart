import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class CoffeeTracking extends StatefulWidget {
  static String route = 'coffeeTracking';
  @override
  _CoffeeTrackingState createState() => _CoffeeTrackingState();
}

class _CoffeeTrackingState extends State<CoffeeTracking> {
  bool showGuide = false;
  bool coffeeEspresso = false;    //false = espresso, true = coffee
  List coffeeOptions = ['American', 'Arabic', 'Cappuchino', 'Caramel Macchiato',
    'Caribbean', 'Coffee Amaretto', 'Coffee Latte', 'Expresso', 'Expresso Panna',
  'Flat white', 'Hawaiian', 'Irish', 'Large', 'Macchiato', 'Milk Punch', 'Short',
  'Submarine', 'Viennese', 'White coffee', 'With a dash of milk'];
  List espressoOptions = ['Espresso', 'Espresso Doppio', 'Ristretto', 'Lungo',
  'Cafe Macchiato', 'Cafe Creme', 'Cafe Noisette', 'Cafe Cortado', 'Cappuchino',
  'Dry Cappuccino', 'Caffe Americano', 'Cafe Con Hielo', 'Breve', 'Mocha Breve',
  'Mocha', 'caffee Affogato', 'Viennois', 'Con Panna', 'Flat White', 'Black Eye',
  'Caffe Latte', 'Caffe Au Lait', 'Cafe Con Leche'];
  bool save = false; //bool to engage the save button upon any changes
  bool espressoPressed = false; //change colour of espresso button when pressed
  bool coffeePressed = false; //change colour of coffee button when pressed
  List<DropdownMenuItem<String>> caffeineList = []; //list of either espresso/coffee options
  String caffeineDrink = null;
  final espressoShotsController = TextEditingController();

  ///Populate caffeineList with either coffeeOptions or espressoOptions in the DropDownMenuItem type class
  List populateCaffeineList(String choice) {
    caffeineList = [];
    caffeineDrink = null;
    if (choice == "Espresso"){
      for (String x in espressoOptions){
        caffeineList.add(DropdownMenuItem<String>(
            value: x,
            child: Text(x)
        ));
      }
    }else{
      for (String x in coffeeOptions){
        caffeineList.add(DropdownMenuItem<String>(
            value: x,
            child: Text(x)
        ));
      }
    }
  }

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
                            image: AssetImage('lib/assets/latte_background.jpg'),
                            fit: BoxFit.fill
                          )
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Text(
                          'COFFEE',
                          style: TextStyle(
                              color: Colors.brown,
                              fontSize: 45,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(                                                      //Coffee input container
                  margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: coffeePressed ? Colors.blue[200] : Colors.blue[400],
                                    primary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                  ),
                                  child: Text(
                                      'Espresso'
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      coffeePressed = !coffeePressed;
                                      espressoPressed = false;
                                      coffeeEspresso = false;
                                      populateCaffeineList('Espresso');
                                    });
                                  },
                                ),
                              ),
                              Container(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: espressoPressed ? Colors.orange[200] : Colors.orange[400],
                                    primary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                  ),
                                  child: Text(
                                      'Coffee'
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      espressoPressed = !espressoPressed;
                                      coffeePressed = false;
                                      coffeeEspresso = true;
                                      populateCaffeineList('Coffee');
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.pink[400],
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                              ),
                              child: Text(
                                  'Guide'
                              ),
                              onPressed: () {
                                setState(() {
                                  showGuide ? showGuide = false : showGuide = true;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      showGuide ? Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: coffeeEspresso ? AssetImage('lib/assets/coffee_guide.jpg') : AssetImage('lib/assets/espresso_guide.jpg'),
                                fit: BoxFit.fill
                            )
                        ),
                      ) : SizedBox(height: 0,),
                      DropdownButton<String>(
                          disabledHint: Text('Please choose Espresso or Coffee first'),
                          hint: Text('Choose drink option'),
                          isExpanded: true,
                          value: this.caffeineDrink,
                          items: caffeineList,
                          onChanged: (String value) {
                            setState(() {
                              this.caffeineDrink = value;
                              save = true;
                            });
                          },
                      ),
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
            save ? Positioned(
              top: 50,
              right: 10,
              child: FlatButton(
                color: Color.fromRGBO(255, 255, 255, 0.5),
                child: Text('Save', style: TextStyle(color: Colors.black, fontSize: 18)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.black, style: BorderStyle.solid)
                ),
                onPressed: () {
                  //TODO: save the data inputted
                  setState(() {
                    save = false;
                    caffeineDrink = null;
                    caffeineList = [];
                    espressoPressed = false;
                    coffeePressed = false;
                  });
                },
              ),
            ) : SizedBox(height: 0,),
          ],
        ),
      ),
    );
  }
}
