import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BeerTracking extends StatefulWidget {
  static String route = 'beerTracking';
  @override
  _BeerTrackingState createState() => _BeerTrackingState();
}

class _BeerTrackingState extends State<BeerTracking> {
  String beerBrand;
  List brands = ['Budlight', 'Molson', 'LostCraft', 'Lowenbrau'];
  String beerType;
  List beerTypes = ['Ale', 'Pale Ale', 'Brown Ale', 'Sour Ale','Lager', 'Porter'
    , 'Wheat', 'IPA', 'Stout', 'Pilsner'];
  String measurement;
  List measurements = ['Pints', 'Cups', 'Cans', 'Tall Cans'];
  List hardTypes = ['Gin', 'Vodka', 'Whiskey', 'Rum','Tequila', 'Brandy'];
  String hardType;
  List cocktails = ['Gin and Tonic', 'Espresso Martini', 'Black Russian',
    'White Russian', 'Rum & Coke', 'Mojito'];
  String cocktail;
  List coolersCiders = ['White Claw', 'Growers', "Mike's", 'Cottage Springs',
    'Palm Bay'];
  String coolerCider;
  //all add/remove bools are for engaging the widgets to add/remove to the lists
  //seperate for each category so they dont all engage at the same time
  bool addBeer = false;
  bool removeBeer = false;
  bool addCocktail = false;
  bool removeCocktail = false;
  bool addCC = false;
  bool removeCC = false;
  bool save = false;

  final measurementController = TextEditingController();
  final shotsController = TextEditingController();
  final shotsCocktailController = TextEditingController();
  final coolerCiderController = TextEditingController();

  //variables to record
  //BEER: beerBrand, beerType, measurement, measurementController
  //HARD LIQUOR: hardType, shotsController
  //COCKTAILS: cocktail, shotsCocktailController
  //COOLERS AND CIDERS: coolerCider, coolerCiderController



  ///To create a textfield or dropdown list to change the beer brand/cocktail/cooler list of items, to add/remove
  ///
  ///parameters:
  ///       add: bool to initiate textfield to input new item in list
  ///       remove: bool to initiate dropdownmenuitem to remove item from list
  ///       drink: specifiy which list to manipulate
  Widget addRemoveList(bool add, bool remove, String drink) {
    if (add == true && remove == false){
      return Material(
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Add to List',
          ),
          onSubmitted: (String str) {
            if (str != ''){
              setState(() {
                addRemoveHelper(drink).add(str);
                if (drink == 'Beer'){
                  addBeer = false;
                }else if (drink == 'Cocktail'){
                  addCocktail = false;
                }else{
                  addCC = false;
                }
              });
            };
          },
        ),
      );
    }else if (add == false && remove == true){
      return DropdownButton<String>(
        dropdownColor: Colors.white,
        hint: Text('Click Item to delete'),
        //value: this.removeString,
        isExpanded: true,
        items: addRemoveHelper(drink).map<DropdownMenuItem<String>>((stringItem) {
          return DropdownMenuItem(
            value: stringItem,
            child: Text(stringItem),
          );
        }).toList(),
        onChanged: (String newValue) { //upon click, remove item from workout, repopulate workouts list, remove dropdown
          addRemoveHelper(drink).remove(newValue);
          setState((){
            if (drink == 'Beer' && newValue == beerBrand){
              beerBrand = null;
              removeBeer = false;
            }else if (drink == 'Cocktail' && newValue == cocktail){
              cocktail = null;
              removeCocktail = false;
            }else{
              coolerCider = null;
              removeCC = false;
            }
          });
        },
      );
    }else {
      return SizedBox(height: 0);
    }
  }
  /// Helper for AddRemoveList, when you input string, returns corresponing named list
  List addRemoveHelper(String choice){
    switch (choice) {
      case 'Beer': {
        return brands;
      }
      case 'Cocktail': {
        return cocktails;
      }
      case 'Coolers': {
        return coolersCiders;
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(245, 245, 245, 1.0),
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
                          setState(() {
                            addBeer = !addBeer;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.indeterminate_check_box,
                          size: 30,
                          color: Colors.red,
                        ),
                        onPressed: (beerBrand != null) ? () {
                          setState(() {
                            removeBeer = !removeBeer;
                          });
                        } : null,
                      ),
                    ],
                  ),
                  addRemoveList(addBeer, removeBeer, 'Beer'),
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
                            items: beerTypes.map<DropdownMenuItem<String>>((stringItem) {
                              return DropdownMenuItem(
                                value: stringItem,
                                child: Text(stringItem),
                              );
                            }).toList(),
                            onChanged: (String choice) {
                              setState(() {
                                beerType = choice;
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
                              style: TextStyle(fontSize: 18),
                              onSubmitted: (String text){
                                setState(() {
                                  (text != '') ? save = true : save = false;
                                });
                              },
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
                  'HARD LIQUOR',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontFamily: 'KronaOne Regular'
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 200,
                      height: 40,
                      child: DropdownButton<String>(
                        value: this.hardType,
                        hint: Text('Beer Style'),
                        isExpanded: true,
                        items: hardTypes.map<DropdownMenuItem<String>>((stringItem) {
                          return DropdownMenuItem(
                            value: stringItem,
                            child: Text(stringItem),
                          );
                        }).toList(),
                        onChanged: (String choice) {
                          setState(() {
                            hardType = choice;
                          });
                        },
                      )
                  ),
                  Text(
                    'Shots:',
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    width: 60,
                    height: 35,
                    child: TextField(
                      controller: shotsController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 18),
                      onSubmitted: (String text){
                        setState(() {
                          (text != '') ? save = true : save = false;
                        });
                      },
                    ),
                  )
                ],
              ),
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
                            value: this.cocktail,
                            hint: Text('Cocktail'),
                            isExpanded: true,
                            items: cocktails.map<DropdownMenuItem<String>>((stringItem) {
                              return DropdownMenuItem(
                                value: stringItem,
                                child: Text(stringItem),
                              );
                            }).toList(),
                            onChanged: (String choice) {
                              setState(() {
                                cocktail = choice;
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
                          setState(() {
                            addCocktail = !addCocktail;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.indeterminate_check_box,
                          size: 30,
                          color: Colors.red,
                        ),
                        onPressed: (cocktail != null) ? () {
                          setState(() {
                            removeCocktail= !removeCocktail;
                          });
                        } : null,
                      ),
                    ],
                  ),
                  addRemoveList(addCocktail, removeCocktail, 'Cocktail'),
                  Row(
                    children: [
                      Text(
                        'Shots of Liquor in Cocktail:',
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        width: 100,
                        height: 35,
                        child: TextField(
                          controller: shotsCocktailController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 18),
                          onSubmitted: (String text){
                            setState(() {
                              (text != '') ? save = true : save = false;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(                                                          //COOLERS
              margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Center(
                child: Text(
                  'COOLERS & CIDERS',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontFamily: 'KronaOne Regular'
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 15),
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
                            value: this.coolerCider,
                            hint: Text('Cooler or Cider'),
                            isExpanded: true,
                            items: coolersCiders.map<DropdownMenuItem<String>>((stringItem) {
                              return DropdownMenuItem(
                                value: stringItem,
                                child: Text(stringItem),
                              );
                            }).toList(),
                            onChanged: (String choice) {
                              setState(() {
                                coolerCider = choice;
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
                          setState(() {
                            addCC = !addCC;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.indeterminate_check_box,
                          size: 30,
                          color: Colors.red,
                        ),
                        onPressed: (cocktail != null) ? () {
                          setState(() {
                            removeCC = !removeCC;
                          });
                        } : null,
                      ),
                    ],
                  ),
                  addRemoveList(addCC, removeCC, 'Coolers'),
                  Row(
                    children: [
                      Text(
                        'Number of Cans:',
                        style: TextStyle(
                            fontSize: 18
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        width: 100,
                        height: 35,
                        child: TextField(
                          controller: coolerCiderController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 18),
                          onSubmitted: (String text){
                            setState(() {
                              (text != '') ? save = true : save = false;
                            });
                          },
                        ),
                      )
                    ],
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
                    measurementController.text = '';
                    shotsCocktailController.text = '';
                    shotsController.text = '';
                    coolerCiderController.text = '';
                    beerBrand = null;
                    beerType = null;
                    measurement = null;
                    hardType = null;
                    cocktail = null;
                    coolerCider = null;
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
