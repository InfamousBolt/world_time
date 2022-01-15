import 'package:flutter/material.dart';
import 'package:world_time/services/world_time_setup.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void worldTimeSetup() async{
    WorldTime worldTime = WorldTime(location: "Berlin", flag: "berlin.jpg", url: "Europe/Berlin");
    await worldTime.getTime();
    await Future.delayed(Duration(seconds: 1));
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location':worldTime.location,
      'flag':worldTime.flag,
      'time':worldTime.time,
      'isDayTime':worldTime.isDayTime
    });
  }

  @override
  void initState() {
    worldTimeSetup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: SpinKitPouringHourGlassRefined(
        color: Colors.white,
        size: 90.0,
      ),
    );
  }
}
