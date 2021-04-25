import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location;// name for the UI
  String time; //time in that location
  String flag;// url to asset flag icon
  String url; //location url for api endpoints
  bool isDaytime; // true or false if daytime or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async{

    try{
      //make the request
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/Europe/London'));
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      //print(datetime);
      //print(offset);

      //create a DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true: false;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print('Caught error $e');
      time = 'Could not get time data';
    }


  }

}

