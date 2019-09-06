import 'package:equatable/equatable.dart';

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

