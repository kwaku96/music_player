
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/bloc/a_bloc.dart';
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
      home: HomePage(),
    );
  }
}



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AudioPlayer _audioPlayer ;
  AudioPlayerBloc _audioPlayerBloc;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayerBloc = AudioPlayerBloc(
      audioPlayer: _audioPlayer,
      songs: demoPlaylist.songs
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AudioPlayerBloc>(
      builder: (context)=> _audioPlayerBloc,
      child:
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
                  child: RadialSeekBar(
                    progress: 0,
                    seekPercent: 0.0,
                  ),
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
        ),
    );
  }


  @override
  void dispose() {
    super.dispose();
    _audioPlayerBloc.dispose();
    _audioPlayer.dispose();
  }

}

