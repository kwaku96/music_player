import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:music_player/bloc/audio_player_events.dart';
import 'package:music_player/bloc/audio_player_states.dart';
import 'package:music_player/songs.dart';

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvents,AudioPlayerStates>{

  final AudioPlayer audioPlayer;
  final List<DemoSong> songs;
  int currentSongIndex = 0;
  bool isSongPlaying = false;
  List<String> localSongs = [];
  AudioPlayerState playerState;

  AudioPlayerBloc({@required this.audioPlayer,@required this.songs}){
    _getMp3Files();

    audioPlayer.onDurationChanged.listen((data){
      this.dispatch(DurationChanged(duration: data.inMilliseconds));
    });

    audioPlayer.onPlayerStateChanged.listen((data){
      playerState = data;
      if(data == AudioPlayerState.COMPLETED){
        this.dispatch(NextButtonPressed());
      }
    });

  }

  @override
  AudioPlayerStates get initialState => Uninitialised();

  @override
  Stream<AudioPlayerStates> mapEventToState(AudioPlayerEvents event) async*{
    if(event is PlayButtonPressed){
      yield* _mapPlayButtonPressedToState(event);
    }else if(event is PreviousButtonPressed){
      yield* _mapPreviousButtonPressedToState(event);
    }else if(event is NextButtonPressed){
      yield* _mapNextButtonPressedToState(event);
    }
  }

  Stream<AudioPlayerStates>
    _mapPlayButtonPressedToState(PlayButtonPressed e) async*{
    if(playerState == AudioPlayerState.PLAYING){
      _pause();
    }else{
      _play(localSongs[currentSongIndex]);
    }
    yield Playing();
  }

  Stream<AudioPlayerStates>
    _mapPreviousButtonPressedToState(PreviousButtonPressed event) async*{
    if(currentSongIndex > 0){
      currentSongIndex -= 1;
      _play(localSongs[currentSongIndex]);
    }
    //TODO yield previous song state
    yield Playing();
  }

  Stream<AudioPlayerStates>
    _mapNextButtonPressedToState(NextButtonPressed event) async*{
    if(currentSongIndex < songs.length-1){
      currentSongIndex +=1;
      _play(localSongs[currentSongIndex]);
    }
    //TODO yield next song state
    yield Playing();
  }

  _play(String url) async{
    await audioPlayer.play(url,isLocal: true);
  }

  _pause() async{
    await audioPlayer.pause();
  }

  _getMp3Files() async{
    try{
      Map<String,String>_paths = await FilePicker.getMultiFilePath(
        type: FileType.AUDIO,
        fileExtension: 'mp3'
      );
      _getMp4Files();

      _paths.forEach((key,value){
        localSongs.add(value);
      });
    }catch(e){
      print(e);
    }
  }

  _getMp4Files() async{
    try{
      Map<String,String>_paths = await FilePicker.getMultiFilePath(
          type: FileType.AUDIO,
          fileExtension: 'mp4'
      );

      _paths.forEach((key,value){
        localSongs.add(value);
      });
    }catch(e){
      print(e);
    }
  }
}