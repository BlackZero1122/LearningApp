import 'package:flutter/material.dart';
import 'package:learning_app/custom_widgets/app_status_bar.dart';
import 'package:learning_app/custom_widgets/app_top_bar.dart';
import 'package:learning_app/custom_widgets/custom_button.dart';
import 'package:learning_app/custom_widgets/stateful_wrapper.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/services/global_service.dart';
import 'package:learning_app/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

class LessonPage extends StatelessWidget {
  LessonPage({super.key});
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
              AppTopBar(text: viewModel.subjects[viewModel.currentSubjectIndex].lessons![viewModel.currentLessonIndex].title!,isMain: false,),
              const SizedBox(height: 1,),
              Expanded(
                    child: viewModel.listSpinner ? Center(child: CircularProgressIndicator(color: Color(0xffc5ced9),)) : viewModel.subjects[viewModel.currentSubjectIndex].lessons![viewModel.currentLessonIndex].activities!.isEmpty ? Center(child: Text('No Acrtivities :/', style: TextStyle(color: Color(0xffc5ced9)),)) : GridView.builder(
                  primary: false,
                  padding: const EdgeInsets.all(15),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: viewModel.subjects[viewModel.currentSubjectIndex].lessons![viewModel.currentLessonIndex].activities!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: Color(0xff363749),
                      child: InkWell(
                      onTap: () {
                        viewModel.selectActivity(index);
                      },
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xff41435a),
                                    borderRadius: BorderRadius.circular(5)),
                              )),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Text(
                                    viewModel.subjects[viewModel.currentSubjectIndex].lessons?[viewModel.currentLessonIndex].activities?[index].title??"N/A",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Color(0xffc5ced9), fontSize: 14),
                                  )),
                                  (viewModel.subjects[viewModel.currentSubjectIndex].lessons?[viewModel.currentLessonIndex].activities?[index].completed??false) ? Icon(
                                    Icons.check_circle,
                                    color: Colors.greenAccent,
                                  ) : SizedBox()
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ))
            ],
          )),
    );
  }
}