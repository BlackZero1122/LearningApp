import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_app/extensions/duration_extensions.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/models/hive_models/activity.dart';
import 'package:learning_app/models/message.dart';
import 'package:learning_app/services/dialog_service.dart';
import 'package:learning_app/services/global_service.dart';
import 'package:learning_app/view_models/activity_view_model.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final Activity currentActivity;
  const VideoPlayerWidget({super.key, required this.currentActivity});


  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _videoPlaying = false;
  bool _showOverlay = false;
  bool _initVideo = false;
  bool _videoBuffering = true;
  bool videocomplete=false;
  bool _isLoading = true;
  late Activity currentActivity;

  @override
  void initState() {
    try {
      currentActivity=widget.currentActivity;
      if(currentActivity.activityType==2){
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      }
      locator<GlobalService>().log("Init Video ${currentActivity.content??"N/A"}");
      videocomplete=false;
      setVideoPlaying(false);
      setVideoBuffering(true);

      _controller = VideoPlayerController.networkUrl(
        Uri.parse(currentActivity.content!))
        ..initialize().then((_) {
        setState(() {
          _isLoading = false;
          _controller.play();
          setVideoPlaying(true);
          setShowOverlay(false);
        });
      });
      _controller.addListener(() {
        if(_controller.value.isBuffering){
            setVideoBuffering(true);
          }
          else{
            setVideoBuffering(false);
          }
          if(_controller.value.isInitialized){
            if(_controller.value.position == Duration.zero) {
              videocomplete=false;
            }
            if(_controller.value.position == _controller.value.duration) {
              locator<GlobalService>().log("Video Completed)");
              _controller.seekTo(Duration.zero);
              setVideoPlaying(false);
              setShowOverlay(true);
              if((currentActivity.rules?.trackActivityProgress??true)){
                if(!videocomplete){
                  videocomplete=true;
                  locator<ActivityViewModel>().markAsComplete(false, currentActivity, null);
                }
              }
            }
          }
           if(_controller.value.hasError){
            locator<GlobalService>().logWarning(_controller.value.errorDescription??"Error while playing video!");
          }
        setState(() {});
      });
      _controller.setVolume(1.0);
      _controller.setLooping(false);
      _controller.initialize();
      setShowOverlay(true);
      _initVideo=true;
      
    } catch (e,s) {
      locator<GlobalService>().logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ActivityViewModel viewModel = context.watch<ActivityViewModel>();
    return Center(
            child :(_controller.value.hasError || !locator<GlobalService>().connectedToInternet)
                ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Text('There is an issue Playing this video.'),const SizedBox(height: 10,), 
                Row(children: [
                  IconButton(
                                    onPressed: () {
                                       viewModel.init(viewModel.currentActivity);
                                    },
                                    icon: const Row( mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min,
                                      children: [ Text(
                                        'Reload Video!',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ), SizedBox(width: 5,), Icon(Icons.replay, color: Colors.white,) ]
                                    ),
                                    style: IconButton.styleFrom(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        backgroundColor: Colors.orangeAccent,
                                        shape: const RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.white, width: 3),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))))),
                  IconButton(
                                    onPressed: () {
                                       locator<IDialogService>().showAlert(Message(description: _controller.value.errorDescription??"Error while playing video!"));
                                    },
                                    icon: const Row( mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min,
                                      children: [ Text(
                                        'See Error!',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ), SizedBox(width: 5,), Icon(Icons.replay, color: Colors.white,) ]
                                    ),
                                    style: IconButton.styleFrom(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        backgroundColor: Colors.grey,
                                        shape: const RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.black, width: 3),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)))))
                ],),]) : 
                (_isLoading) ? 
                CircularProgressIndicator(
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xff8D20DE)),
                  backgroundColor: Colors.grey.shade300,
                )
                : 
                Center(
                  child:AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: Stack(children: [GestureDetector(onTap: () async {
                              setState(() {
                                showOrHideOverlay();
                              });
                            }, child: Stack(children: [VideoPlayer(_controller), _videoBuffering ? const Center(child: CircularProgressIndicator(),) : const SizedBox()])),
                              Align( alignment: Alignment.bottomCenter,
                                child: SizedBox( height: 15,
                                  child: VideoProgressIndicator(
                                  _controller,
                                  allowScrubbing: false,
                                  colors: const VideoProgressColors(
                                      backgroundColor: Colors.blueGrey,
                                      bufferedColor: Color.fromARGB(255, 192, 216, 228),
                                      playedColor: Colors.blueAccent),
                                                                  ),
                                ),
                              ),
                              Align( alignment: Alignment.bottomRight,
                                child: ValueListenableBuilder(
                                  valueListenable: _controller,
                                  builder: (context, VideoPlayerValue value, child) {
                                    //Do Something with the value.
                                    return Padding(padding: const EdgeInsets.all(10), child: Text( "${value.position.formatVideoDuration()} / ${value.duration.formatVideoDuration()}", style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),));
                                  },
                                )
                              ),
                              Visibility( visible: _showOverlay,
                                child: GestureDetector( onTap: () {
                                  if(_videoPlaying){
                                    setState(() {
                                      showOrHideOverlay();
                                    }); 
                                  }
                                },
                                  child: Center(child: Container(width: double.infinity, height: double.infinity, color: Colors.black45,
                                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      IconButton(iconSize: 35, onPressed: (){ (currentActivity.rules?.allowBackwardSeek??false) ? setState(() {
                                        rewindVideo();
                                      })  : null; }, icon: Icon(Icons.fast_rewind, color: (currentActivity.rules?.allowBackwardSeek??false) ? Colors.white : Colors.grey,)),
                                      const SizedBox(width: 10,),
                                      IconButton(iconSize: 35,style: IconButton.styleFrom(backgroundColor: Colors.white), onPressed: (){ setState(() { replayVideo(); }); }, icon: const Icon(Icons.replay)),
                                      const SizedBox(width: 10,),
                                      IconButton(iconSize: 55, style: IconButton.styleFrom(foregroundColor: Colors.white, backgroundColor: const Color(0xff8D20DE)), onPressed:  _videoPlaying ? (){ setState(() { pauseVideo(); }); } : (){ setState(() { playVideo(); }); }, icon: _videoPlaying ? const Icon(Icons.pause) : const Icon(Icons.play_arrow)),
                                      const SizedBox(width: 10,),
                                      IconButton(iconSize: 35,style: IconButton.styleFrom(backgroundColor: Colors.white), onPressed: (){ setState(() { stopVideo(); }); }, icon: const Icon(Icons.stop)),
                                      const SizedBox(width: 10,),
                                      IconButton(iconSize: 35, onPressed: (){ (currentActivity.rules?.allowForwardSeek??false) ? setState(() { forwardVideo(); }) : null; }, icon: Icon(Icons.fast_forward, color: (currentActivity.rules?.allowForwardSeek??false) ? Colors.white : Colors.grey,)),
                                    ]),
                                  )),
                                ),
                              )
                            ])),
                )
    );
  }


  void replayVideo() {
    try {
      locator<GlobalService>().log("Replay Video");
      _controller.seekTo(Duration.zero);
      if(!_videoPlaying){
        _controller.play();
        setVideoPlaying(true);
      }
      setShowOverlay(false);
    } catch (e,s) {
      locator<GlobalService>().logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
  }

  void stopVideo() {
    try {
      if(!_initVideo){
        return;
      }
      locator<GlobalService>().log("Stop Video");
      _controller.seekTo(Duration.zero);
      if(_videoPlaying){
        _controller.pause();
        setVideoPlaying(false);
      }
      setShowOverlay(true);
    } catch (e,s) {
      locator<GlobalService>().logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
  }

  void playVideo() {
    try {
      locator<GlobalService>().log("Play Video");
      if(!_videoPlaying){
        _controller.play();
        setVideoPlaying(true);
      }
      setShowOverlay(false);
    } catch (e,s) {
      locator<GlobalService>().logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
  }

  void pauseVideo() {
    try {
      locator<GlobalService>().log("Pause Video");
      if(_videoPlaying){
        _controller.pause();
        setVideoPlaying(false);
      }
      setShowOverlay(true);
    } catch (e,s) {
      locator<GlobalService>().logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
  }

  void rewindVideo() {
    try {
      locator<GlobalService>().log("Rewing Video");
      _controller.seekTo(_controller.value.position - const Duration(seconds: 10));
    } catch (e,s) {
      locator<GlobalService>().logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
  }

  void forwardVideo() {
    try {
      locator<GlobalService>().log("Forward Video");
      _controller.seekTo(_controller.value.position + const Duration(seconds: 10));
    } catch (e,s) {
      locator<GlobalService>().logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
  }

  setVideoPlaying(bool videoPlaying) async {
    _videoPlaying = videoPlaying;
  }

  setVideoBuffering(bool value) async {
    _videoBuffering = value;
  }

  setShowOverlay(bool showOverlay) async {
    _showOverlay = showOverlay;
  }

  showOrHideOverlay() {
    try {
      setShowOverlay(!_showOverlay);
    } catch (e,s) {
      locator<GlobalService>().logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
  }

}