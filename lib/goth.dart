// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pixelarticons/pixelarticons.dart';
import 'package:audioplayers/audioplayers.dart';


class Goth extends StatefulWidget {
  @override
  _GothState createState() => _GothState();
}

class _GothState extends State<Goth> {
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
    final url = await player.load('goth.mp3');
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
              image:NetworkImage('https://i.pinimg.com/originals/5c/12/3c/5c123ce9b24d67328e8cf78cf2f2777c.jpg'),
              fit: BoxFit.cover,
              ),
          ),
        child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(

            width: 300,
            height: 360,

            child: Column(
              
              children:
            [
              wtitle(name: 'Batcave'),
              Image.network('https://pm1.narvii.com/6744/f54f63b1fcbce5754d75e4e764c488f815443bd8v2_hq.jpg'),
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