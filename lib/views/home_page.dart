import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:learning_app/custom_widgets/app_status_bar.dart';
import 'package:learning_app/custom_widgets/app_top_bar.dart';
import 'package:learning_app/custom_widgets/custom_button.dart';
import 'package:learning_app/custom_widgets/custom_linear_percent_indicator.dart';
import 'package:learning_app/custom_widgets/side_drawer.dart.dart';
import 'package:learning_app/custom_widgets/stateful_wrapper.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/models/hive_models/lesson.dart';
import 'package:learning_app/services/global_service.dart';
import 'package:learning_app/services/navigation_service.dart';
import 'package:learning_app/view_models/home_view_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    HomeViewModel viewModel = context.watch<HomeViewModel>();
    return StatefulWrapper(
      onDispose: () {
        //
      },
      onInit: () {
        WidgetsBinding.instance
            .addPostFrameCallback((_) => viewModel.getData(0));
      },
      child: Scaffold(
          key: scaffoldKey,
          drawer: const SideDrawer(),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          body: Column(
            children: [
              const AppTopBar(
                text: "Home",
              ),
              const SizedBox(
                height: 1,
              ),
              Expanded(
                child: (viewModel.spinner || viewModel.subjects.isEmpty)
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Color(0xffc5ced9),
                        ),
                      )
                    : Column(
                        children: [
                          //   Container(
                          //   width: double.infinity,
                          //   padding: EdgeInsets.all(7),
                          //   height: 50,
                          //   color: Color(0xff363749),
                          //   child: Center(
                          //     child: ListView.builder( scrollDirection: Axis.horizontal, itemCount: viewModel.subjects.length, shrinkWrap: true, itemBuilder:(context, index) {
                          //       return Card(color: viewModel.subjects[index].selected?Color(0xff6769e4):Color(0xffc5ced9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), child: InkWell(onTap: () {
                          //         viewModel.selectSubject(index);
                          //       }, child: Padding(padding: EdgeInsets.only(left: 10, right: 10), child: Center(child: Text(viewModel.subjects[index].subject!, style: TextStyle(fontSize: 14, color: viewModel.subjects[index].selected?Color(0xffc5ced9):Colors.black),)))),);
                          //     },),
                          //   ),
                          // ),
                          Expanded(
                              child: viewModel.listSpinner
                                  ? Center(
                                      child: CircularProgressIndicator(
                                      color: Color(0xffc5ced9),
                                    ))
                                  : (viewModel.getSelectedSubject?.lessons ??
                                              [])
                                          .isEmpty
                                      ? Center(
                                          child: Text(
                                          'No Lessons :/',
                                          style: TextStyle(
                                              color: Color(0xffc5ced9)),
                                        ))
                                      : Column(
                                          children: [
                                            Card(color: Color.fromARGB(255, 112, 141, 255),
                                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                              child: 
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 6, left: 2, right: 2,bottom: 6),
                                              child: Container(
                                                 margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                                                decoration: BoxDecoration(
                                                    color: Color.fromARGB(255, 255, 255, 255),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                padding: EdgeInsets.all(0),
                                                height: 230,
                                                child: Column(
                                                  
                                                  children: [
                                                    Text("Overall Progress",textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                          fontSize:
                                                              12, // Larger font size
                                                          fontWeight: FontWeight
                                                              .bold, // Bold text
                                                          color: const Color
                                                              .fromARGB(
                                                              255,
                                                              33,
                                                              33,
                                                              33), // Contrasting color
                                                        )),
                                                    Expanded(
                                                      child:
                                                          CustomLinearPercentIndicator(
                                                        percent: viewModel
                                                                .getSelectedSubject
                                                                ?.completeRatio ??
                                                            0,
                                                        centerText: (viewModel
                                                                    .getSelectedSubject
                                                                    ?.completeString ??
                                                                "") +
                                                            " Steps Completed",
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 0,
                                                    ),
                                                    Row(
                                                      
                                                      children: [
                                                        Expanded(
                                                          child:
                                                              Column(children: [
                                                            CircularPercentIndicator(
                                                              radius: 35.0,
                                                              lineWidth: 12.0,
                                                              percent: viewModel
                                                                .getSelectedSubject
                                                                ?.completeListenRatio ??
                                                            0,
                                                              center: new Icon(
                                                                Icons.earbuds,
                                                                size: 35.0,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        194,
                                                                        194,
                                                                        194),
                                                              ),
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          194,
                                                                          194,
                                                                          194),
                                                              progressColor:
                                                                  Color(
                                                                      0xffef7453),
                                                            ),
                                                            const Text(
                                                                "Listening",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12))
                                                          ]),
                                                        ),
                                                        Expanded(
                                                            child: Column(
                                                                children: [
                                                              CircularPercentIndicator(
                                                                radius: 35.0,
                                                                lineWidth: 12.0,
                                                                percent: viewModel
                                                                .getSelectedSubject
                                                                ?.completeCogniRatio ??
                                                            0,
                                                                center:
                                                                    new Icon(
                                                                  Icons
                                                                      .branding_watermark,
                                                                  size: 35.0,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          194,
                                                                          194,
                                                                          194),
                                                                ),
                                                                backgroundColor:
                                                                    Color.fromARGB(
                                                                        255,
                                                                        194,
                                                                        194,
                                                                        194),
                                                                progressColor:
                                                                    Color(
                                                                        0xffa962e5),
                                                              ),
                                                              const Text(
                                                                  "Cognitive",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12))
                                                            ])),
                                                            Expanded(
                                                            child: Column(
                                                                children: [
                                                              CircularPercentIndicator(
                                                                radius: 35.0,
                                                                lineWidth: 12.0,
                                                                percent: viewModel
                                                                .getSelectedSubject
                                                                ?.completeVocabRatio ??
                                                            0,
                                                                center:
                                                                    new Icon(
                                                                  Icons
                                                                      .abc_rounded,
                                                                  size: 35.0,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          194,
                                                                          194,
                                                                          194),
                                                                ),
                                                                backgroundColor:
                                                                    Color.fromARGB(
                                                                        255,
                                                                        194,
                                                                        194,
                                                                        194),
                                                                progressColor:
                                                                    Color.fromARGB(255, 163, 16, 23),
                                                              ),
                                                              const Text(
                                                                  "Vocabulary",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12))
                                                            ])),
                                                            Expanded(
                                                            child: Column(
                                                                children: [
                                                              CircularPercentIndicator(
                                                                radius: 35.0,
                                                                lineWidth: 12.0,
                                                                percent: viewModel
                                                                .getSelectedSubject
                                                                ?.completeSociRatio ??
                                                            0,
                                                                center:
                                                                    new Icon(
                                                                  Icons
                                                                      .social_distance,
                                                                  size: 35.0,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          194,
                                                                          194,
                                                                          194),
                                                                ),
                                                                backgroundColor:
                                                                    Color.fromARGB(
                                                                        255,
                                                                        194,
                                                                        194,
                                                                        194),
                                                                progressColor:
                                                                    Color.fromARGB(255, 27, 15, 198),
                                                              ),
                                                              const Text(
                                                                  "Social",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12))
                                                            ])),
                                                                                                              ],
                                                    )
                                                  ],
                                                )),
                                              ),
                                            ),
                                            Expanded(
                                              child: GridView.builder(
                                                primary: false,
                                                padding:
                                                    const EdgeInsets.all(15),
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 10,
                                                  mainAxisSpacing: 10,
                                                ),
                                                itemCount: viewModel
                                                    .getSelectedSubject!
                                                    .lessons!
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                    color: Color.fromARGB(255, 255, 255, 255),
                                                    child: InkWell(
                                                      onTap: () {
                                                        viewModel.selectLesson(
                                                            index, null);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(15),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                                child:
                                                                    Container(
                                                                      child: Image.network(viewModel
                                                                          .getSelectedSubject
                                                                          ?.lessons?[
                                                                              index]
                                                                          .thumbnail ??'',fit: BoxFit.cover),
                                                              decoration: BoxDecoration(
                                                                  color: Color(
                                                                      0xff41435a),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                            )),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Expanded(
                                                                    child: Text(
                                                                  viewModel
                                                                          .getSelectedSubject
                                                                          ?.lessons?[
                                                                              index]
                                                                          .title ??
                                                                      "N/A",
                                                                  maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Color.fromARGB(255, 215, 92, 4), fontSize: 20),
                                                                )),
                                                                (viewModel
                                                                            .getSelectedSubject
                                                                            ?.lessons?[index]
                                                                            .completed ??
                                                                        false)
                                                                    ? Icon(
                                                                        Icons
                                                                            .check_circle,
                                                                        color: Colors
                                                                            .greenAccent,
                                                                      )
                                                                    : SizedBox()
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        ))
                        ],
                      ),
              )
            ],
          )),
    );
  }
}
