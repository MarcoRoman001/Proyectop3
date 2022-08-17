// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pixelarticons/pixelarticons.dart';
import 'package:audioplayers/audioplayers.dart';


class CityPop extends StatefulWidget {
  @override
  _CitypopState createState() => _CitypopState();
}

class _CitypopState extends State<CityPop> {
  final audioPlayer = AudioPlayer();

  bool isPlaying=false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  
  @override
  void initState () {
    super.initState();

    setAudio();
    
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
     });

    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }
  
  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.LOOP);

    final player = AudioCache(prefix: 'assets/audio/');
    final url = await player.load('citypop.mp3');
    audioPlayer.setUrl(url.path, isLocal: true);
  }

  @override 
  void dispose(){
    audioPlayer.dispose();
    super.dispose();
  }



  static const wcolor = Color(0xFFC1C1C1);
  static const wcolorp = Color(0xFF004CA7 );

  Expanded wtitle ({required String name}){
    return Expanded(
      child: Container(
        width: 300,
        height: 40,
        color: wcolorp,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: TextStyle(color: Colors.white, fontFamily: 'ComputerFont', fontSize: 40), textAlign: TextAlign.center,),
            IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            ),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
            ) 
          ],
        )
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
              image:NetworkImage('https://i.pinimg.com/originals/3f/f5/08/3ff5087d17f6d05a7348cba186041688.jpg'),
              fit: BoxFit.cover,
              ),
          ),
        child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(

            width: 300,
            height: 370,

            child: Column(
              
              children:
            [
              wtitle(name: '80s Nissan'),
              Image.network('https://lh4.googleusercontent.com/3fvmHoP5GbXG-OUv9Lv_nAPSXmeC3olGVhQV_2_gjjj0TjaykJ7A2ymLPPK8q7Of3An7ov58XElJ95HTlnC3H3sM3ltwUfaN1XmKsGYyI6pSnJadCmsAxuXbPsFXvTnZ0IYb-6X3'),
              Slider(
                min: 0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: (value) async {
                  final position = Duration(seconds: value.toInt());
                  await audioPlayer.seek(position);

                  await audioPlayer.resume();
                },
              ),
              IconButton(icon: Icon(
                isPlaying? Icons.pause : Icons.play_arrow,
              ),
              iconSize: 40,
              color: Colors.black,
              onPressed: () async{
                if(isPlaying){
                  await audioPlayer.pause();
                }else{
                  await audioPlayer.resume();
                }
              } 
              )

            ],
          ),
        ),
      )
        )
        ),
    );
  }
}