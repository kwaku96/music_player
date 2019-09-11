import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:music_player/bloc/main/audio_player_events.dart';
import 'package:music_player/bloc/main/audio_player_states.dart';
import 'package:music_player/songs.dart';

import 'package:file_picker/file_picker.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvents,AudioPlayerStates>{

  final AudioPlayer audioPlayer;
  final List<DemoSong> songs;

  int currentSongIndex = 0;
  int currentSongTotalTime = 10;

  bool isSongPlaying = false;
  AudioPlayerState playerState;

  List<String> localSongs = [];


  AudioPlayerBloc({@required this.audioPlayer,@required this.songs}){
    _getAudioFiles();

    audioPlayer.onDurationChanged.listen((data){
      currentSongTotalTime = data.inMilliseconds;
    });

    audioPlayer.onAudioPositionChanged.listen((data){
      this.dispatch(DurationUpdated(duration: data.inMilliseconds));
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
    }else if(event is DurationUpdated){
      yield* _mapDurationUpdatedToState(event);
    }
  }

  Stream<AudioPlayerStates>
    _mapPlayButtonPressedToState(PlayButtonPressed event) async*{
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
      //_play(songs[currentSongIndex].audioUrl);
      _play(localSongs[currentSongIndex]);
    }
    //TODO yield previous song state
    yield Playing();
  }

  Stream<AudioPlayerStates>
    _mapNextButtonPressedToState(NextButtonPressed event) async*{
    if(currentSongIndex < songs.length-1){
      currentSongIndex +=1;
      //_play(songs[currentSongIndex].audioUrl);
      _play(localSongs[currentSongIndex]);
    }
    //TODO yield next song state
    yield Playing();
  }

  Stream<AudioPlayerStates>
    _mapDurationUpdatedToState(DurationUpdated event) async*{
    double progress = event.duration/(currentSongTotalTime).toDouble();
    yield UpdateProgress(progress: progress);
  }

  _play(String url) async{
    await audioPlayer.play(url,isLocal: true);
  }

  _pause() async{
    await audioPlayer.pause();
  }

  _getAudioFiles()async{
    Map<String,String> _mp3 = await FilePicker.getMultiFilePath(
      fileExtension: 'mp3',
      type: FileType.AUDIO
    );

    Map<String,String> _mp4 = await FilePicker.getMultiFilePath(
      fileExtension: 'mp4',
      type: FileType.AUDIO
    );

    _mp3.forEach((key,value){
      localSongs.add(value);
      print(value);
    });

    _mp4.forEach((key,value){
      localSongs.add(value);
      print(value);
    });
  }

}