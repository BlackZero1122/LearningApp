import 'package:flutter/material.dart';
import 'package:learning_app/custom_widgets/app_status_bar.dart';
import 'package:learning_app/custom_widgets/app_top_bar.dart';
import 'package:learning_app/custom_widgets/custom_button.dart';
import 'package:learning_app/custom_widgets/stateful_wrapper.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/services/global_service.dart';
import 'package:learning_app/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

class ActivityPage extends StatelessWidget {
  ActivityPage({super.key});
  final scaffoldKey = GlobalKey<ScaffoldState>(); 

  @override
  Widget build(BuildContext context) {
    HomeViewModel viewModel = context.watch<HomeViewModel>();
    return StatefulWrapper(
      onDispose: (){
        //
      },
      onInit: () {
        //
      },
      child: Scaffold( key: scaffoldKey,
        backgroundColor: Color(0xff262835),
        body: Column(
            children: [
              AppTopBar(text: viewModel.subjects[viewModel.currentSubjectIndex].lessons![viewModel.currentLessonIndex].activities![viewModel.currentActivityIndex].title!,isMain: false,),
              const SizedBox(height: 1,),
              Expanded(
                    child: viewModel.listSpinner ? Center(child: CircularProgressIndicator(color: Color(0xffc5ced9),)) : 
                    Text('data')
                    )
            ],
          )),
    );
  }
}