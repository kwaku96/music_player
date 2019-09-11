import 'u_bloc.dart';
import 'package:bloc/bloc.dart';

class UiBloc extends Bloc<UiEvents,UiStates>{
  @override
  UiStates get initialState => UninitialisedState();

  @override
  Stream<UiStates> mapEventToState(UiEvents event) {
    // TODO: implement mapEventToState
    return null;
  }


}
