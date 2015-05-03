// Copyright (c) 2012, The Madhouse13.  Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:convert';


class PlayerData {
  //variables to stash player info
  Map playerInfo;
  String curBody;
  String curLegs;
  String curBoots;
  ImageElement playerBody;
  ImageElement playerLegs;
  ImageElement playerBoots;

  PlayerData () {
    try {
      GetPlayerInfo();
    } catch(arrr) {
      print('Error getting playerInfo: $arrr');
    }
    
    //stash the image elements
    playerBody = querySelector('#player_body');
    playerBody.onClick.listen(ClickMe);
    playerLegs = querySelector('#player_legs');
    playerLegs.onClick.listen(ClickMe);
    playerBoots = querySelector('#player_boots');
    playerBoots.onClick.listen(ClickMe);
  }

  //getter and setter for the body section
  String get PlayerBody => curBody;
  void   set PlayerBody(String body) {
    curBody = body;
  }

  //getter and setter for the legs section
  String get PlayerLegs => curLegs;
  void   set PlayerLegs(String legs) {
    curLegs = legs;
  }

  //getter and setter for the boots section
  String get PlayerBoots => curBoots;
  void   set PlayerBoots(String boots) {
    curBoots = boots;
  }
  
  //get the player info from the db
  GetPlayerInfo() async {
    //get the current data for this player from the couchdb
    String path = 'http://192.168.1.50:5984/medieval_player/Darren';
    String jsonString = await HttpRequest.getString(path);
    playerInfo = JSON.decode(jsonString);
    //draw the player on the screen
    DrawCurrentPlayer();
  }
  
  //draw the body, legs and boots of the current player based on the playerinfo map
  void DrawCurrentPlayer() {
    List<String> bodyParts = ['body','legs','boots'];
    //loop through the body parts above, selet the element and set it to the current value
    for (String part in bodyParts) {
      ImageElement t = querySelector('#player_' + part);
      t.src = 'images/char_' + part + '_' + playerInfo[part] + '.png';
    }
  }
  
  void ClickMe(Event e) {
    //get the id of the control
    String id = (e.target as ImageElement).id;
    //select the correct element
    ImageElement t = querySelector('#' + id);
    //split the string to know which body part
    List<String> parts = id.split("_"); 
    //update the image source to the current value for the part
    t.src = 'images/char_' + parts[1] + '_' + playerInfo[parts[1]] + '.png';
  }
 
  
}