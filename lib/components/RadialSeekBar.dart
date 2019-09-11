import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttery/gestures.dart';
import 'package:music_player/bloc/main/a_bloc.dart';

import 'RadialProgressBar.dart';
import '../songs.dart';
import '../theme.dart';

class RadialSeekBar extends StatefulWidget {

  final double seekPercent;
  final double progress;
  final Function(double) onSeekRequested;

  RadialSeekBar({this.seekPercent = 0.0,this.onSeekRequested,this.progress=0.0});

  @override
  _RadialSeekBarState createState() => _RadialSeekBarState();
}

class _RadialSeekBarState extends State<RadialSeekBar> {

  double _progress = 0.25;
  PolarCoord _startDragCoord;
  double _startDragPercent;
  double _currentDragPercent;
  AudioPlayerBloc audioPlayerBloc;

  @override
  void initState() {
    super.initState();
    _progress = widget.progress;
  }

  @override
  void didUpdateWidget(RadialSeekBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _progress = widget.progress;
  }

  @override
  Widget build(BuildContext context) {
    double thumbPosition = _progress;
    audioPlayerBloc = BlocProvider.of<AudioPlayerBloc>(context);

    if(_currentDragPercent != null){
      thumbPosition = _currentDragPercent;
    }else if(widget.seekPercent != null){
      thumbPosition = widget.seekPercent;
    }

    return RadialDragGestureDetector(
      onRadialDragStart: _onRadialDragStart,
      onRadialDragUpdate: _onRadialDragUpdate,
      onRadialDragEnd: _onRadialDragEnd,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        child: Center(
            child: Container(
              height: 140.0,
              width: 140.0,
              child: RadialProgressBar(
                innerPadding: EdgeInsets.all(10.0),
                progressColor: accentColor,
                thumbColor: lightAccentColor,
                trackColor: Color(0xFFDDDDDD),
                progressPercent: _progress,
                thumbPosition: thumbPosition,
                child: ClipOval(
                  clipper: CircleClipper(),
                  child: Image.network(
                    demoPlaylist.songs[0].albumArtUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
        ),
      ),
    );
  }

  _onRadialDragStart(PolarCoord startCoord) {
    _startDragCoord = startCoord;
    _startDragPercent = _progress;
    audioPlayerBloc.dispatch(SeekingThumbDragStart(seekPercent: _progress));
  }

  _onRadialDragUpdate(PolarCoord updateCoord) {
    final dragAngle = updateCoord.angle - _startDragCoord.angle;
    final dragPercent = dragAngle/(2*pi);
    setState(() {
      _currentDragPercent = (_startDragPercent + dragPercent)% 1.0;
    });
  }

  _onRadialDragEnd() {

//    if(widget.onSeekRequested != null){
//      widget.onSeekRequested(_currentDragPercent);
//    }

    audioPlayerBloc.dispatch(SeekingThumbDragEnd(
      seekPercent: _currentDragPercent
    ));

    setState(() {

      _currentDragPercent = null;
      _startDragCoord = null;
      _startDragPercent = 0.0;
    });
  }
}



class CircleClipper extends CustomClipper<Rect>{
  @override
  getClip(Size size) {
    return Rect.fromCircle(
        center: Offset(size.width/2,size.height/2),
        radius: min(size.width, size.height)/2
    );
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }

}