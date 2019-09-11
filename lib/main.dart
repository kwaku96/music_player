
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/bloc/main/a_bloc.dart';
import 'package:music_player/components/RadialSeekBar.dart';
import 'package:music_player/songs.dart';


import 'components/BottomControls.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_delegate.dart';

void main(){
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      debugShowCheckedModeBanner: false,
      home: BlocProvider<AudioPlayerBloc>(
        builder: (context)=>AudioPlayerBloc(
          audioPlayer: AudioPlayer(),
          songs: demoPlaylist.songs
        ),
        child: HomePage()
      ),
    );
  }
}




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _progress = 0;
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,color: Colors.grey,),
            onPressed: (){},
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.menu,color: Colors.grey,),
              onPressed: (){},
            ),
          ],
        ),
        body: Column(
          children: <Widget>[

            Expanded(
              child: StreamBuilder(
                builder: (context,snapshot){
                  return RadialSeekBar(

                  );
                },
              )
            ),

            //visualizer
            Container(
              width: double.infinity,
              height: 125,
            ),

            //text and controls
            new BottomControls(),
          ],
        ),

    );
  }
}

