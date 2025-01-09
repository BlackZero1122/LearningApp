import 'package:flutter/material.dart';
import 'package:learning_app/custom_widgets/app_status_bar.dart';
import 'package:learning_app/custom_widgets/app_top_bar.dart';
import 'package:learning_app/custom_widgets/custom_button.dart';
import 'package:learning_app/custom_widgets/stateful_wrapper.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/services/global_service.dart';
import 'package:learning_app/view_models/home_view_model.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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
              AppTopBar(text: viewModel.getSelectedLesson!.title!,isMain: false,),
              const SizedBox(height: 1,),
              Expanded(
                    child: viewModel.listSpinner ? Center(child: CircularProgressIndicator(color: Color(0xffc5ced9),)) : (viewModel.getSelectedLesson?.activities??[]).isEmpty ? Center(child: Text('No Acrtivities :/', style: TextStyle(color: Color(0xffc5ced9)),)) : 
                    Column(
                      children: [
                        Padding( padding: EdgeInsets.only(top:20,left: 20,right: 20),
                        child: Container( decoration: BoxDecoration(color: Color(0xff41435a), borderRadius: BorderRadius.circular(5)), padding: EdgeInsets.all(15), height: 55,
                        child: LinearPercentIndicator(
                                        animation: true,
                                        animationDuration: 1000,
                                        lineHeight: 25.0, padding: EdgeInsets.all(0),
                                        percent: viewModel.getSelectedLesson?.completeRatio??0,
                                        center: Text(viewModel.getSelectedLesson?.completeString??""), barRadius: Radius.circular(5),
                                        progressColor: Color(0xff6769e4),
                                      ),
                        ),
                      ),
                        Expanded(
                          child: GridView.builder(
                                            primary: false,
                                            padding: const EdgeInsets.all(15),
                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                                            ),
                                            itemCount: viewModel.getSelectedLesson?.activities!.length,
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
                                          viewModel.getSelectedLesson?.activities?[index].title??"N/A",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Color(0xffc5ced9), fontSize: 14),
                                        )),
                                        (viewModel.getSelectedLesson?.activities?[index].completed??false) ? Icon(
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
                                          ),
                        ),
                      ],
                    ))
            ],
          )),
    );
  }
}