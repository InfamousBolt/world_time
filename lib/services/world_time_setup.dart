import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  late String location;
  late String time;
  late String flag;
  late String url;
  late bool isDayTime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async{
    try{
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map map = jsonDecode(response.body);
      String dateTime = map['datetime'];
      String offset = map['utc_offset'];
      String offsetHours = map['utc_offset'].substring(1,3);
      String offsetMinutes = map['utc_offset'].substring(4);
      DateTime now = DateTime.parse(dateTime);
      if(offset[0]=='+'){
        now = now.add(Duration(hours: int.parse(offsetHours), minutes: int.parse(offsetMinutes)));
      }
      else if(offset[0]=='-'){
        now = now.subtract(Duration(hours: int.parse(offsetHours), minutes: int.parse(offsetMinutes)));
      }
      isDayTime = now.hour >= 6 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print("Caught Error: $e");
      time = "Err! Could not get time :(";
    }

  }
}