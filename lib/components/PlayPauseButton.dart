import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/bloc/a_bloc.dart';

import '../theme.dart';


class PlayButton extends StatefulWidget {
  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300)
    );
  }

  @override
  Widget build(BuildContext context) {

    final audioPlayerBloc = BlocProvider.of<AudioPlayerBloc>(context);

    return RawMaterialButton(
      shape: CircleBorder(),
      elevation: 10.0,
      fillColor: Colors.white,
      splashColor: lightAccentColor,
      highlightColor: lightAccentColor.withOpacity(0.5),
      highlightElevation: 5.0,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: AnimatedIcon(
          progress: _controller,
          icon: AnimatedIcons.play_pause,
          color: darkAccentColor,
          size: 35.0
        ),
      ),
      onPressed: (){
        _changeIcon();
        audioPlayerBloc.dispatch(PlayButtonPressed());
      },
    );
  }

  _changeIcon(){
    setState(() {
      isPlaying = !isPlaying;
    });
    if(isPlaying){
      _controller.forward();
    }else{
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
