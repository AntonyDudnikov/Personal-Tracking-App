import 'package:flutter/material.dart';


class MediaTracking extends StatefulWidget {
  static String route = 'mediaTracking';
  @override
  _MediaTrackingState createState() => _MediaTrackingState();
}

class _MediaTrackingState extends State<MediaTracking> {
  String tvShow;
  String movie;
  String documentary;
  List shows = ['Vikings', 'The Rookie'];
  List movies;
  List documentaries;

  bool addShow = false;
  bool removeShow = false;
  bool addMovie = false;
  bool removeMovie = false;
  bool addDoc = false;
  bool removeDoc = false;
  bool save = false;

  final tvSeasonController = TextEditingController();
  final tvEpisodeController = TextEditingController();
  final tvLengthController = TextEditingController();

  Widget addRemoveList(bool add, bool remove, String media) {
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
                addRemoveHelper(media).add(str);
                if (media == 'shows'){
                  addShow = false;
                }else if (media == 'movies'){
                  addMovie = false;
                }else{
                  addDoc = false;
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
        items: addRemoveHelper(media).map<DropdownMenuItem<String>>((stringItem) {
          return DropdownMenuItem(
            value: stringItem,
            child: Text(stringItem),
          );
        }).toList(),
        onChanged: (String newValue) { //upon click, remove item from workout, repopulate workouts list, remove dropdown
          addRemoveHelper(media).remove(newValue);
          setState((){
            if (media == 'shows'){
              (newValue == tvShow) ? tvShow = null : null;
              removeShow = false;
            }else if (media == 'movies'){
              (newValue == documentary) ? movie = null : null;
              removeMovie = false;
            }else{
              (newValue == documentary) ? documentary = null : null;
              removeDoc = false;
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
      case 'shows': {
        return shows;
      }
      case 'movies': {
        return movies;
      }
      case 'documentaries': {
        return documentaries;
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
                    color: Color.fromRGBO(0, 255, 0, 0.5),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Text(
                      'MEDIA',
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
            Container(                                                          //COCKTAILS
              margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: Center(
                child: Text(
                  'TV SHOWS',
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
                            value: this.tvShow,
                            hint: Text('TV shows'),
                            isExpanded: true,
                            items: shows.map<DropdownMenuItem<String>>((stringItem) {
                              return DropdownMenuItem(
                                value: stringItem,
                                child: Text(stringItem),
                              );
                            }).toList(),
                            onChanged: (String choice) {
                              setState(() {
                                tvShow = choice;
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
                            addShow = !addShow;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.indeterminate_check_box,
                          size: 30,
                          color: Colors.red,
                        ),
                        onPressed: (tvShow != null) ? () {
                          setState(() {
                            removeShow = !removeShow;
                          });
                        } : null,
                      ),
                    ],
                  ),
                  addRemoveList(addShow, removeShow, 'shows'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Season:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      Container(
                        width: 75,
                        child: TextField(
                          controller: tvSeasonController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                          onSubmitted: (String text){
                            setState(() {
                              (text != '') ? save = true : save = false;
                            });
                          },
                        ),
                      ),
                      Text(
                        'Episode:',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      Container(
                        width: 75,
                        child: TextField(
                          controller: tvEpisodeController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                          onSubmitted: (String text){
                            setState(() {
                              (text != '') ? save = true : save = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Length:',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400
                        ),
                      ),
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
                    tvSeasonController.text = '';
                    tvEpisodeController.text = '';
                    tvShow = null;
                    movie = null;
                    documentary = null;
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
