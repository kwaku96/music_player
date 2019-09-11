import 'dart:async';

class MyBloc {

  StreamController _controller = new StreamController();
  get sink => _controller.sink;
  get stream => _controller.stream;

  void dispose(){
    _controller.close();
  }
}