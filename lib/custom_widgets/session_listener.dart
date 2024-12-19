import 'dart:async';

import 'package:flutter/material.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/services/pref_service.dart';

class SessionListener extends StatefulWidget{
  final Widget child;
  final VoidCallback onTimeOut;
  const SessionListener({super.key, required this.child, required this.onTimeOut});

  @override
  State<SessionListener> createState() => _SessionListenerState();
}

class _SessionListenerState extends State<SessionListener>{
  Timer? _timer;

  startTimer() async {
    if(_timer!=null){
      _timer?.cancel();
      _timer=null;
    }
    var duration = await locator<PrefService>().getInt(PrefKey.idleScreenTimeout, defaultValue: 0);
    if(duration>0 && await locator<PrefService>().getBool(PrefKey.isLoggedIn)){
      _timer=Timer(Duration(minutes: duration), () async {
        widget.onTimeOut();
      });
    }
  }

  @override
  void initState(){
    startTimer();
    super.initState();
  }

  @override
  void dispose(){
    if(_timer!=null){
      _timer?.cancel();
      _timer=null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Listener(behavior: HitTestBehavior.translucent, onPointerDown: (event) {
      startTimer();
    }, child: widget.child);
  }
}