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
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerWidget extends StatefulWidget {
  final Activity currentActivity;
  const YouTubePlayerWidget({super.key, required this.currentActivity});


  @override
  State<YouTubePlayerWidget> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<YouTubePlayerWidget> {
  late YoutubePlayerController _controller;
  bool _videoPlaying = false;
  bool _initVideo = false;
  bool _videoBuffering = true;
  bool videocomplete=false;
  bool _isLoading = true;
  late Activity currentActivity;
  bool _isPlayerReady = false;

  @override
  void initState() {
    try {
      currentActivity=widget.currentActivity;
      if(currentActivity.activityType==8){
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      }
      locator<GlobalService>().log("Init Video ${currentActivity.content??"N/A"}");
      videocomplete=false;
      setVideoPlaying(false);
      setVideoBuffering(true);

      _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(currentActivity.content!)??"",
        flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ))..addListener(() {
        if(_isPlayerReady && mounted && !_controller.value.isFullScreen){
          if(_controller.value.playerState== PlayerState.buffering){
            setVideoBuffering(true);
          }
          else{
            setVideoBuffering(false);
          }
          if(_isPlayerReady){
            if(_controller.value.position == Duration.zero) {
              videocomplete=false;
            }
            // if(_controller.value.position == _controller.metadata.duration) {
            //   locator<GlobalService>().log("Video Completed)");
            //   _controller.seekTo(Duration.zero);
            //   setVideoPlaying(false);
            //   if((currentActivity.rules?.trackActivityProgress??true)){
            //     if(!videocomplete){
            //       videocomplete=true;
            //       locator<ActivityViewModel>().markAsComplete(false, currentActivity, null);
            //     }
            //   }
            // }
          }
           if(_controller.value.hasError){
            locator<GlobalService>().logWarning(_controller.value.errorCode.toString()+" | Error while playing video!");
          }
        }
        setState(() {});
      });
      setState(() {
          _isLoading = false;
          _controller.play();
          setVideoPlaying(true);
        });
      _controller.setVolume(1);
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
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
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
                                       locator<IDialogService>().showAlert(Message(description: _controller.value.errorCode.toString()+ " | Error while playing video!"));
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
                  child:Stack(children: [YoutubePlayer(controller: _controller, onReady: () {
                    _isPlayerReady=true;
                  }, onEnded: (metaData) {
                    locator<GlobalService>().log("Video Completed)");
                    _controller.seekTo(Duration.zero);
                    setVideoPlaying(false);
                    if((currentActivity.rules?.trackActivityProgress??true)){
                      if(!videocomplete){
                        videocomplete=true;
                        locator<ActivityViewModel>().markAsComplete(false, currentActivity, null);
                      }
                    }
                  },), _videoBuffering ? const Center(child: CircularProgressIndicator(),) : const SizedBox()]),
                )
    );
  }

  setVideoPlaying(bool videoPlaying) async {
    _videoPlaying = videoPlaying;
  }

  setVideoBuffering(bool value) async {
    _videoBuffering = value;
  }

}