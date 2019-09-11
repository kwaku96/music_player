import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class UiStates extends Equatable{
  UiStates([List props = const []]):super(props);
}

class UpdateDuration extends UiStates{
  final double duration;

  UpdateDuration({@required this.duration});

  @override
  String toString() {
    return 'updating duration';
  }
}

class UninitialisedState  extends UiStates{
  @override
  String toString()=>"ui uninitialised";
}