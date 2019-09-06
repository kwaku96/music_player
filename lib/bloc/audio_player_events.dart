import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AudioPlayerEvents extends Equatable{
  AudioPlayerEvents([List props = const []]) : super(props);
}

class PlayButtonPressed extends AudioPlayerEvents{
  @override
  String toString() {
    return 'play button pressed';
  }
}

class PauseButtonPressed extends AudioPlayerEvents{
  @override
  String toString() {
    return 'pause song';
  }
}

class PreviousButtonPressed extends AudioPlayerEvents{
  @override
  String toString() {
    return 'previous button pressed';
  }
}


class NextButtonPressed extends AudioPlayerEvents{
  @override
  String toString() {
    return 'next button pressed';
  }
}


class SeekingThumbDragStart extends AudioPlayerEvents{
  final double seekPercent;

  SeekingThumbDragStart({@required this.seekPercent});

  @override
  String toString() {
    return 'seeking started';
  }
}

class SeekingThumbDragEnd extends AudioPlayerEvents{
  final double seekPercent;

  SeekingThumbDragEnd({@required this.seekPercent});

  @override
  String toString() {
    return 'seeking ended';
  }
}

class DurationChanged extends AudioPlayerEvents{
  final int duration;
  DurationChanged({this.duration});
  @override
  String toString() => "duration changed";
}