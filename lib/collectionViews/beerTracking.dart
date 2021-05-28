import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class BeerTracking extends StatefulWidget {
  static String route = 'beerTracking';
  @override
  _BeerTrackingState createState() => _BeerTrackingState();
}

class _BeerTrackingState extends State<BeerTracking> {
  String beerBrand;
  List brands = ['Budlight', 'Molson', 'LostCraft', 'Lowenbrau'];
  String beerType;
  List types = ['Ale', 'Pale Ale', 'Brown Ale', 'Sour Ale','Lager', 'Porter', 'Wheat', 'IPA', 'Stout', 'Pilsner'];
  String measurement;
  List measurements = ['Pints', 'Cups', 'Cans', 'Tall Cans'];
  String beerQuantity;
  bool addBrand = false;
  bool removeBrand = false;
  bool changedBrand = false;
  final measurementController = TextEditingController();


  ///To create a textfield or dropdown list to change the beer brand list of items, to add/remove
  Widget addRemoveBeerBrand(bool add, bool remove) {
    if (add == true && remove == false){
      print('clicked');
      return Material(
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Add Brand',
          ),
          onSubmitted: (String str) {
            if (str != ''){
              print(str);
              setState(() {
                brands.add(str);
                print(brands);
                addBrand = false;
                changedBrand = true;
              });
            };
          },
        ),
      );
    }else if (add == false && remove == true){
      return DropdownButton<String>(
        dropdownColor: Colors.white,
        hint: Text('Click Brand to delete'),
        //value: this.removeString,
        isExpanded: true,
        items: brands.map<DropdownMenuItem<String>>((stringItem) {
          return DropdownMenuItem(
            value: stringItem,
            child: Text(stringItem),
          );
        }).toList(),
        onChanged: (String newValue) { //upon click, remove item from workout, repopulate workouts list, remove dropdown
          brands.remove(newValue);
          setState((){
            removeBrand = false;
            changedBrand = true;
          });
        },
      );
    }else {
      return SizedBox(height: 0);
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
                  Container(                                                    //Title
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('lib/assets/beerBackground.jpg'),
                            fit: BoxFit.fill
                        )
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Text(
                      'DRINKS',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 45,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(                                                          //BEER
              height: 25,
              margin: EdgeInsets.fromLTRB(20, 15, 0, 15),
              //padding: EdgeInsets.fromLTRB(10, 0, 300, 0),
              child: Center(
                child: Text(
                  'BEER',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontFamily: 'KronaOne Regular'
                  ),
                ),
              ),
            ),
            Container(                                                          //BEER container
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Column(
                children: [
                  Row(                                                          //BRAND
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 200,
                        height: 40,
                        child: DropdownButton<String>(
                          value: this.beerBrand,
                          hint: Text('Beer Brand'),
                          isExpanded: true,
                          items: brands.map<DropdownMenuItem<String>>((stringItem) {
                            return DropdownMenuItem(
                              value: stringItem,
                              child: Text(stringItem),
                            );
                          }).toList(),
                          onChanged: (String choice) {
                            setState(() {
                              beerBrand = choice;
                              print(beerBrand);
                            });
                          },
                        )
                      ),
                      TextButton.icon(
                        label: Text(''),
                        icon: Icon(
                          Icons.add_box,
                          size: 30,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          if (addBrand == true){
                            setState(() {
                              addBrand = false;
                            });
                          }else{
                            setState(() {
                              addBrand = true;
                            });
                          }},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.indeterminate_check_box,
                          size: 30,
                          color: Colors.red,
                        ),
                        onPressed: (beerBrand != null) ? () {
                          if (removeBrand == true){
                            setState(() {
                              removeBrand = false;
                            });
                          }else{
                            setState(() {
                              removeBrand = true;
                            });
                          }
                        } : null,
                      ),
                    ],
                  ),
                  addRemoveBeerBrand(addBrand, removeBrand),
                  Row(                                                          //TYPE
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          width: 200,
                          height: 40,
                          child: DropdownButton<String>(
                            value: this.beerType,
                            hint: Text('Beer Style'),
                            isExpanded: true,
                            items: types.map<DropdownMenuItem<String>>((stringItem) {
                              return DropdownMenuItem(
                                value: stringItem,
                                child: Text(stringItem),
                              );
                            }).toList(),
                            onChanged: (String choice) {
                              setState(() {
                                beerType = choice;
                                print(beerType);
                              });
                            },
                          )
                      ),
                    ],
                  ),
                  Container(                                                    //QUANTITY
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 200,
                          height: 40,
                          child: DropdownButton<String>(
                            value: this.measurement,
                            isExpanded: true,
                            hint: Text('Quantity'),
                            items: measurements.map<DropdownMenuItem<String>>((stringItem) {
                              return DropdownMenuItem(
                                value: stringItem,
                                child: Text(stringItem),
                              );
                            }).toList(),
                            onChanged: (String choice) {
                              setState(() {
                                measurement = choice;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            width: 60,
                            height: 35,
                            child: TextField(
                              controller: measurementController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(                                                          //HARD SPIRITS
              margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Center(
                child: Text(
                  'HARD SPIRITS',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontFamily: 'KronaOne Regular'
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: SizedBox(height: 75,),
            ),
            Container(                                                          //COCKTAILS
              margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Center(
                child: Text(
                  'COCKTAILS',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontFamily: 'KronaOne Regular'
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: SizedBox(height: 75,),
            ),
            Container(                                                          //COOLERS
              margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Center(
                child: Text(
                  'COOLERS',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontFamily: 'KronaOne Regular'
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: SizedBox(height: 75,),
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
