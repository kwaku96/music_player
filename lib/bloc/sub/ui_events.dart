import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class UiEvents extends Equatable{
  UiEvents([List props = const []]):super(props);
}

class DurationChange extends UiEvents{
  final int duration;

  DurationChange({@required this.duration});

  @override
  String toString() => "duration changed";
}