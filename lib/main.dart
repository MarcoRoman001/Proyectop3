import 'package:flutter/material.dart';
import 'package:proyecto_radiop3/citypop.dart';
import 'package:proyecto_radiop3/goth.dart';
import 'package:proyecto_radiop3/vapor.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  static const wcolor = Color(0xFFC1C1C1);
  static const wcolorp = Color(0xFF004CA7 );

  Expanded buildKey({required String file, required String name}) {
    return Expanded(
      child: Container(
        width: 300,
        height: 400,
        child:
        ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(wcolor),
        ),
        onPressed: () {
          switch(file){
            case "goth":
            Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Goth()));
                  break;
            case "citypop":
            Navigator.push(
                      context, MaterialPageRoute(builder: (_) => CityPop()));
            break;
            case "vaporwave":
            Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Vapor()));
            break;
          }
        },
        child: Text(name, style: TextStyle(color: Colors.black, fontFamily: 'ComputerFont', fontSize: 50),),
      ),
      )
    );
  }

  Expanded wtitle ({required String name}){
    return Expanded(
      child: Container(
        width: 300,
        height: 40,
        color: wcolorp,
        child: Text(name, style: TextStyle(color: Colors.white, fontFamily: 'ComputerFont', fontSize: 40), textAlign: TextAlign.center,),
      ),
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: 
        Container (
          decoration: const BoxDecoration(
            image: DecorationImage(
              image:NetworkImage('https://wallpapercave.com/wp/wp4846344.jpg'),
              fit: BoxFit.cover,
              ),
          ),
        child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(

            width: 300,
            height: 300,

            child: Column(
              
              children:
            [
              wtitle(name: 'Selecciona una radio'),
              buildKey(file:'goth',name: 'Batcave'),
              buildKey(file:'citypop',name: '80s Nissan'),
              buildKey(file:'vaporwave',name: 'n o s t a l g i a'),
            ],
          ),
        ),
      )
        )
        ),
    );
  }
}