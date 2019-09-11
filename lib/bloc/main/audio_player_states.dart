import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AudioPlayerStates extends Equatable{
  AudioPlayerStates([List props = const []]) : super(props);
}


class Uninitialised extends AudioPlayerStates{
  @override
  String toString() =>'uninitialised';
}

class Playing extends AudioPlayerStates{
  @override
  String toString() => "playing";
}

class Paused extends AudioPlayerStates{
  @override
  String toString() => 'paused';
}

class UpdateProgress extends AudioPlayerStates{
  final double progress;
  UpdateProgress({@required this.progress});
  @override
  String toString() => "update progress";
}