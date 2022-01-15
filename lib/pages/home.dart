import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;
    print(data);

    String bgImage = data['isDayTime'] ? 'daye.png' : 'nighte.png';
    Color? bgColor = data['isDayTime'] ? Colors.lightBlueAccent : Colors.indigo[700];
    Color? textColor = data['isDayTime'] ? Colors.green[800] : Colors.white;



    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,180,0,0),
            child: Column(
              children: [
                TextButton.icon(
                    onPressed: () async{
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'location': result['location'],
                          'flag':result['flag'],
                          'time':result['time'],
                          'isDayTime':result['isDayTime']
                        };
                      });

                    },
                    icon: Icon(Icons.edit_location, color: Colors.blueAccent),
                    label: Text("Edit location", style: TextStyle(color: textColor))
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 30.0,
                        letterSpacing: 2.0,
                        color: textColor
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.0),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 60.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                    color: textColor
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
