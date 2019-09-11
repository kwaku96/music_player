import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/bloc/main/a_bloc.dart';

import 'PlayPauseButton.dart';
import '../theme.dart';

class BottomControls extends StatelessWidget {

  const BottomControls({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      child: Material(
        color: accentColor,
        shadowColor: Color(0x44000000),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            children: <Widget>[
              RichText(
                text: TextSpan(
                    text: '',
                    children: [
                      TextSpan(
                          text: 'Song Title\n',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4.0,
                              height: 1.5
                          )
                      ),
                      TextSpan(
                          text: 'Artist Name',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.75),
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3.0,
                              height: 1.5
                          )
                      )
                    ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new PreviousButton(),
                    new PlayButton(),
                    new NextButton()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



class NextButton extends StatelessWidget {
  const NextButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioBloc = BlocProvider.of<AudioPlayerBloc>(context);
    return IconButton(
      splashColor: lightAccentColor,
      highlightColor: Colors.transparent,
      icon: Icon(Icons.skip_next,color: Colors.white,size: 35.0,),
      onPressed: (){
        audioBloc.dispatch(NextButtonPressed());
      },
    );
  }
}

class PreviousButton extends StatelessWidget {
  const PreviousButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioBloc = BlocProvider.of<AudioPlayerBloc>(context);
    return IconButton(
      splashColor: lightAccentColor,
      highlightColor: Colors.transparent,
      icon: Icon(Icons.skip_previous,color: Colors.white,size: 35.0,),
      onPressed: (){
        audioBloc.dispatch(PreviousButtonPressed());
      },
    );
  }
}