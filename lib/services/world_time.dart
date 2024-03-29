

import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime{

  String location; // location name for the UI.
  String time ; // time in that location
  String flag; // url to an asset flag.
  String url; // location url for api endpoint.
  bool isDaytime;


  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {

    try {
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      //get properties from data.
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      print(offset);

      print(datetime);
      DateTime now = DateTime.parse(datetime);
      now.add(Duration(hours: int.parse(offset)));

      // set the time property.
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);

    }
    catch (e) {
      print(e);
      time = 'could not get time data ';
    }

  }

}

