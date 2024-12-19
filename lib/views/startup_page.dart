import 'package:flutter/material.dart';
import 'package:learning_app/custom_widgets/stateful_wrapper.dart';
import 'package:learning_app/view_models/startup_viewmodel.dart';
import 'package:provider/provider.dart';

class StartupPage extends StatelessWidget {
  StartupPage({super.key});
  final scaffoldKey = GlobalKey<ScaffoldState>(); 

  @override
  Widget build(BuildContext context) {
    StartupViewModel viewModel = context.watch<StartupViewModel>();
    return StatefulWrapper(
      onDispose: (){
        //
      },
      onInit: () {
        viewModel.doStartupLogic(context);
      },
     child: Scaffold( key: scaffoldKey,
        backgroundColor: Color(0xff262835),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: const Column(
            children: [
              Expanded(child: SizedBox()),
              Align(alignment: Alignment.center, child: SizedBox( width: 400, child: Text(''))),
              Expanded(child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}