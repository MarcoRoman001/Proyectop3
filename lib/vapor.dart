// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pixelarticons/pixelarticons.dart';
import 'package:audioplayers/audioplayers.dart';


class Vapor extends StatefulWidget {
  @override
  _VaporState createState() => _VaporState();
}

class _VaporState extends State<Vapor> {
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
    final url = await player.load('vapor.mp3');
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
              image:NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/%22Evolution%22_and_life_in_vaporwave_flavours._%2848475685782%29.png/640px-%22Evolution%22_and_life_in_vaporwave_flavours._%2848475685782%29.png'),
              fit: BoxFit.cover,
              ),
          ),
        child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(

            width: 300,
            height: 320,

            child: Column(
              
              children:
            [
              wtitle(name: 'n o s t a l g i a'),
              Image.network('https://cdn.cloudflare.steamstatic.com/steam/apps/1376800/capsule_616x353.jpg?t=1602634296'),
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
              color: Colors.white,
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