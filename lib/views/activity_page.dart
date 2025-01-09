import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_app/custom_widgets/app_status_bar.dart';
import 'package:learning_app/custom_widgets/app_top_bar.dart';
import 'package:learning_app/custom_widgets/custom_button.dart';
import 'package:learning_app/custom_widgets/custom_text_field.dart';
import 'package:learning_app/custom_widgets/math_text_field.dart';
import 'package:learning_app/custom_widgets/pdf_view.dart';
import 'package:learning_app/custom_widgets/stateful_wrapper.dart';
import 'package:learning_app/custom_widgets/video_player.dart';
import 'package:learning_app/custom_widgets/youtube_player.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/models/hive_models/activity.dart';
import 'package:learning_app/models/hive_models/result.dart';
import 'package:learning_app/models/hive_models/score.dart';
import 'package:learning_app/models/hive_models/student_answer.dart';
import 'package:learning_app/services/dialog_service.dart';
import 'package:learning_app/services/global_service.dart';
import 'package:learning_app/services/tts_service.dart';
import 'package:learning_app/view_models/activity_view_model.dart';
import 'package:learning_app/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityWidgetState();
}

class _ActivityWidgetState extends State<ActivityPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>(); 

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ActivityViewModel viewModel = context.watch<ActivityViewModel>();
    return Scaffold( key: scaffoldKey,
      backgroundColor: Color(0xff262835),
      body: Column(
          children: [
            AppTopBar(text: viewModel.currentActivity!.title!,isMain: false,),
            const SizedBox(height: 1,),
            Expanded(
                  child: viewModel.listSpinner ? Center(child: CircularProgressIndicator(color: Color(0xffc5ced9),)) : 
                  Stack(
            children: [
              getActivity(viewModel),
              SizedBox(
                  height: 60,
                  child: Align(
                      alignment: Alignment.topRight,
                      child: viewModel.currentActivity!.completed
                          ? Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(5),
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.greenAccent,
                              ),
                              child: const Icon(
                                Icons.check,
                                size: 20,
                              ))
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(5, 2, 5, 5),
                              child: IconButton(
                                  onPressed: () {
                                    viewModel.markAsComplete(true,
                                        viewModel.currentActivity!, null);
                                  },
                                  icon: Text(
                                    'Mark as Complete ${viewModel.currentActivity!.getCompleteString}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
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
                            ))),
            ],
          )
                  )
          ],
        ));
  }

    getActivity(ActivityViewModel viewModel) {
    switch (viewModel.currentActivity!.activityTypeString
        .toString()
        .toLowerCase()) {
      case "quiz":
        {
          return Align(
            alignment: Alignment.center,
            child: viewModel.quizLoading ? const CircularProgressIndicator() : getQuiz(viewModel),
          );
        }
      case "video":
        {
          if (kIsWeb) {
            return Align(
                alignment: Alignment.center, child: VideoPlayerWidget(currentActivity: viewModel.currentActivity!));
          } else if (defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.android) {
            return Align(
                alignment: Alignment.center, child: VideoPlayerWidget(currentActivity: viewModel.currentActivity!));
          } else {
            return const Align(
                alignment: Alignment.center,
                child: Text("no implementation for windows and macos!"));
          }
        }
      case "youtubevideo":
        {
          if (kIsWeb) {
            return Align(
                alignment: Alignment.center, child: YouTubePlayerWidget(currentActivity: viewModel.currentActivity!));
          } else if (defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.android) {
            return Align(
                alignment: Alignment.center, child: YouTubePlayerWidget(currentActivity: viewModel.currentActivity!));
          } else {
            return const Align(
                alignment: Alignment.center,
                child: Text("no implementation for windows and macos!"));
          }
        }
      case "image":
        {
          return Align(
              alignment: Alignment.center,
              child: Image.network(viewModel.currentActivity!.content!,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                if (frame == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return child;
              }, loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  if(!viewModel.imagecomplete){
                    viewModel.imagecomplete=true;
                    markImageCompleted(viewModel.currentActivity);
                  }
                  return child;
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }));
        }
        case "pdf":
        {
          if (defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.android) {
            return PDFView(currentActivity: viewModel.currentActivity!);
          } else {
            return const Align(
                alignment: Alignment.center,
                child: Text("no implementation for windows and macos!"));
          }
        }
      default:
        return const Center(child: Text("no implementation!"));
    }
  }

  getQuiz(ActivityViewModel viewModel) {
    final TextEditingController answerController =
        TextEditingController(text: "");
    if (viewModel.currentAssessment.quizzes != null &&
        viewModel.currentAssessment.quizzes!.isNotEmpty) {
      if (viewModel.showResult) {
        return StatefulWrapper(
          onInit: (){
            //
          },
          onDispose: (){
            answerController.dispose();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              viewModel.currentAssessment.isPass ?
              const Text("Great Job!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.green),) : const Text("Keep Trying!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.red),),
              Text(viewModel.currentAssessment.isPass ?"You passed the assessment!":"You'll succeed next time!", style: TextStyle(color: Color(0xffc5ced9)),),
              Image.asset(viewModel.currentAssessment.isPass ?"assets/images/pass.png":"assets/images/fail.png", height: 230,),
              Wrap( alignment: WrapAlignment.center, children: [
              Text("You have answered ${viewModel.currentAssessment.quizzes!.where((x)=>x.correctAnswered).length} out 0f ${viewModel.currentAssessment.quizzes!.length} questions correctly.", textAlign: TextAlign.center, style: TextStyle(color: Color(0xffc5ced9)),),
              // TextButton(onPressed: () async {
              //   List<StudentAnswer> stdAnswers = [];
              //   for (var item in viewModel.currentAssessment.quizzes!) {
              //     stdAnswers.add(StudentAnswer(question_id: item.id, question: item.questionFull, answer: item.answer, correct_answer: item.correctAnswer, is_correct: item.correctAnswered ));
              //   }
              //   await locator<IDialogService>().showDetailResult(Result(student_answers: stdAnswers, completion: true, duration: "", response: "", success: viewModel.currentAssessment.isPass, score: Score(max: viewModel.currentAssessment.quizzes!.length, min: 0, raw: viewModel.currentAssessment.quizzes!.where((x)=>x.correctAnswered).length, scaled: 0)));
              // }, child: const Text('See Details...', style: TextStyle(color: Colors.blue),))
              ]),
              SizedBox(height: 20,),
              Row( mainAxisAlignment: MainAxisAlignment.center, children: [
                 IconButton(
                                    onPressed: () async {
                                      await viewModel.init(viewModel.currentActivity);
                                    },
                                    icon: const Row(
                                      children: [
                                        Icon(Icons.replay, color: Colors.white,),
                                        SizedBox(width: 5,),
                                        Text(
                                          'Retry',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
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
                                                viewModel.currentAssessment.isPass?const SizedBox(width: 10,):const SizedBox(),
                                    viewModel.currentAssessment.isPass?IconButton(
                                    onPressed: () {
                                      viewModel.nextActivity();
                                    },
                                    icon: const Row(
                                      children: [
                                        Text(
                                          'Go to Next Activity',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                         SizedBox(width: 5,),
                                         Icon(Icons.play_arrow, color: Colors.white,),
                                      ],
                                    ),
                                    style: IconButton.styleFrom(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        backgroundColor: Colors.green,
                                        shape: const RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.white, width: 3),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))))):const SizedBox(),
              ],)
          
            ],
          ),
        );
      } else {
        var currentQuiz =
            viewModel.currentAssessment.quizzes?[viewModel.quizIndex];
        answerController.text = currentQuiz!.answer ?? "";
        switch (currentQuiz.quizType?.toLowerCase() ?? "") {
          case "multiplechoice":
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: SizedBox( width: double.infinity, height: MediaQuery.of(context).size.height - 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          currentQuiz.image == null ||
                                  currentQuiz.image!.isNotEmpty
                              ? Image.network(height: 200, currentQuiz.image!,
                                  frameBuilder: (context, child, frame,
                                      wasSynchronouslyLoaded) {
                                  if (frame == null) {
                                    return Container( decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xff8D20DE),
                                              width: 2)),
                                      width: 200,
                                      height: 200,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                  return Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xff8D20DE),
                                              width: 2)),
                                      child: child);
                                }, loadingBuilder:
                                      (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xff8D20DE),
                                                width: 2)),
                                        child: child);
                                  } else {
                                    return Container( decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xff8D20DE),
                                              width: 2)),
                                      width: 200,
                                      height: 200,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                })
                              : const Text(''),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(children: [
                            Text(
                              style: const TextStyle(fontSize: 26, color: Color(0xffc5ced9)),
                              currentQuiz.question!),
                            (currentQuiz.tts_description??"").isNotEmpty ? IconButton(onPressed: () async {
                              await locator<TTSService>().speak(currentQuiz.tts_description!);
                            }, icon: Icon(Icons.speaker),) : SizedBox()
                          ],),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  children: _buildMultipleChoiceOrTrueFalseAnswer(
                                      viewModel),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(alignment: Alignment.topLeft, child: Container(margin: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xff46A0F2),borderRadius: BorderRadius.circular(5)) , padding: const EdgeInsets.fromLTRB(15,5,15,5), child: Text('${viewModel.quizIndex+1}/${viewModel.currentAssessment.quizzes!.length}', style: const TextStyle(color: Colors.white),),),),
                Align( alignment: Alignment.bottomRight,
                  child: Container( height: 60,
                    padding: const EdgeInsets.all(10),
                    child: Row( mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        viewModel.quizIndex > 0
                            ? Container(
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Color(0xffc5ced9), width: 3)),
                                child: IconButton(
                                  padding: const EdgeInsets.all(0),
                                  icon: const Icon(
                                    Icons.arrow_back, color: Color(0xffc5ced9),
                                    size: 25,
                                  ),
                                  onPressed: () async {
                                    await viewModel.setPreQuiz();
                                  },
                                ),
                              )
                            : const Text(""),
                        currentQuiz.answerList!.any(
                          (element) => element.selected == true,
                        )
                            ? viewModel.quizIndex <
                                    viewModel.currentAssessment.quizzes!.length -
                                        1
                                ? Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Color(0xffc5ced9), width: 3)),
                                    child: IconButton(
                                      padding: const EdgeInsets.all(0),
                                      icon: const Icon(
                                        Icons.arrow_forward, color: Color(0xffc5ced9),
                                        size: 25,
                                      ),
                                      onPressed: () async {
                                              await viewModel.setNextQuiz();
                                            },
                                    ),
                                  )
                                : Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Color(0xffc5ced9), width: 3)),
                                    child: TextButton(
                                      child: const Text(
                                        'Submit',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,color: Color(0xffc5ced9)),
                                      ),
                                      onPressed: () {
                                        viewModel.submitQuiz();
                                      },
                                    ),
                                  )
                            : const Text(''),
                      ],
                    ),
                  ),
                )
              ],
            );
          case "truefalse":
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                  child: SizedBox( width: double.infinity, height: MediaQuery.of(context).size.height - 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          currentQuiz.image == null ||
                                  currentQuiz.image!.isNotEmpty
                              ? Image.network(height: 200, currentQuiz.image!,
                                  frameBuilder: (context, child, frame,
                                      wasSynchronouslyLoaded) {
                                  if (frame == null) {
                                    return Container( decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xff8D20DE),
                                              width: 2)),
                                      width: 200,
                                      height: 200,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                  return Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xff8D20DE),
                                              width: 2)),
                                      child: child);
                                }, loadingBuilder:
                                      (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xff8D20DE),
                                                width: 2)),
                                        child: child);
                                  } else {
                                    return Container( decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xff8D20DE),
                                              width: 2)),
                                      width: 200,
                                      height: 200,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                })
                              : const Text(''),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(children: [
                            Text(
                              style: const TextStyle(fontSize: 26, color: Color(0xffc5ced9)),
                              currentQuiz.question!),
                            (currentQuiz.tts_description??"").isNotEmpty ? IconButton(onPressed: () async {
                              await locator<TTSService>().speak(currentQuiz.tts_description!);
                            }, icon: Icon(Icons.speaker),) : SizedBox()
                          ],),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 100,
                            child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:
                                          _buildMultipleChoiceOrTrueFalseAnswer(
                                              viewModel),
                                    ))),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Align(alignment: Alignment.topLeft, child: Container(margin: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xff46A0F2),borderRadius: BorderRadius.circular(5)) , padding: const EdgeInsets.fromLTRB(15,5,15,5), child: Text('${viewModel.quizIndex+1}/${viewModel.currentAssessment.quizzes!.length}', style: const TextStyle(color: Colors.white),),),),
                Align( alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        viewModel.quizIndex > 0
                            ? Container(
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Color(0xffc5ced9), width: 3)),
                                child: IconButton(
                                  padding: const EdgeInsets.all(0),
                                  icon: const Icon(
                                    Icons.arrow_back, color: Color(0xffc5ced9),
                                    size: 25,
                                  ),
                                  onPressed: () async {
                                    await viewModel.setPreQuiz();
                                  },
                                ),
                              )
                            : const Text(""),
                        currentQuiz.answerList!.any(
                          (element) => element.selected == true,
                        )
                            ? viewModel.quizIndex <
                                    viewModel.currentAssessment.quizzes!.length -
                                        1
                                ? Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Color(0xffc5ced9), width: 3)),
                                    child: IconButton(
                                      padding: const EdgeInsets.all(0),
                                      icon: const Icon(
                                        Icons.arrow_forward, color: Color(0xffc5ced9),
                                        size: 25,
                                      ),
                                      onPressed: () async {
                                              await viewModel.setNextQuiz();
                                            },
                                    ),
                                  )
                                : Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Color(0xffc5ced9), width: 3)),
                                    child: TextButton(
                                      child: const Text(
                                        'Submit',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,color: Color(0xffc5ced9)),
                                      ),
                                      onPressed: () {
                                        viewModel.submitQuiz();
                                      },
                                    ),
                                  )
                            : const Text(''),
                      ],
                    ),
                  ),
                )
              ],
            );
          case "fillinblank":
            return Stack(
              children: [
                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: SingleChildScrollView(
                  child: SizedBox( width: double.infinity, height: MediaQuery.of(context).size.height - 100,
                                      child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        currentQuiz.image == null ||
                                                                  currentQuiz.image!.isNotEmpty
                                                              ? Image.network(height: 200, currentQuiz.image!,
                                                                  frameBuilder: (context, child, frame,
                                                                      wasSynchronouslyLoaded) {
                                                                  if (frame == null) {
                                                                    return Container( decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xff8D20DE),
                                            width: 2)),
                                                                      width: 200,
                                                                      height: 200,
                                                                      child: const Center(
                                      child: CircularProgressIndicator(),
                                                                      ),
                                                                    );
                                                                  }
                                                                  return Container(
                                                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xff8D20DE),
                                            width: 2)),
                                                                      child: child);
                                                                }, loadingBuilder:
                                                                      (context, child, loadingProgress) {
                                                                  if (loadingProgress == null) {
                                                                    return Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xff8D20DE),
                                              width: 2)),
                                      child: child);
                                                                  } else {
                                                                    return Container( decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xff8D20DE),
                                            width: 2)),
                                                                      width: 200,
                                                                      height: 200,
                                                                      child: const Center(
                                      child: CircularProgressIndicator(),
                                                                      ),
                                                                    );
                                                                  }
                                                                })
                                                              : const Text(''),
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                        Row(children: [
                            Text(
                              style: const TextStyle(fontSize: 26, color: Color(0xffc5ced9)),
                              currentQuiz.question!),
                            (currentQuiz.tts_description??"").isNotEmpty ? IconButton(onPressed: () async {
                              await locator<TTSService>().speak(currentQuiz.tts_description!);
                            }, icon: Icon(Icons.speaker),) : SizedBox()
                          ],),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        SizedBox(
                                                            width: 350,
                                                            child: CustomTextField(controller: answerController, focusNode: FocusNode(), textAlign: TextAlign.center,maxLines: 1,),
                                                            ),
                                                      ],
                                      ),
                                    ),
                                  ),
                                ),
                Align(alignment: Alignment.topLeft, child: Container(margin: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xff46A0F2),borderRadius: BorderRadius.circular(5)) , padding: const EdgeInsets.fromLTRB(15,5,15,5), child: Text('${viewModel.quizIndex+1}/${viewModel.currentAssessment.quizzes!.length}', style: const TextStyle(color: Colors.white),),),),
                Align( alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        viewModel.quizIndex > 0
                            ? Container(
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Color(0xffc5ced9), width: 3)),
                                child: IconButton(
                                  padding: const EdgeInsets.all(0),
                                  icon: const Icon(
                                    Icons.arrow_back, color: Color(0xffc5ced9),
                                    size: 25,
                                  ),
                                   onPressed: () async {
                                    await viewModel.setPreQuiz();
                                  },
                                ),
                              )
                            : const Text(""),
                        ValueListenableBuilder(
                            valueListenable: answerController,
                            builder: (context, TextEditingValue value, _) {
                              return value.text.isNotEmpty
                                  ? viewModel.quizIndex <
                                          viewModel.currentAssessment.quizzes!
                                                  .length -
                                              1
                                      ? Container(
                                          margin: const EdgeInsets.only(left: 10),
                                          padding:
                                              const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Color(0xffc5ced9), width: 3)),
                                          child: IconButton(
                                            padding: const EdgeInsets.all(0),
                                            icon: const Icon(
                                              Icons.arrow_forward, color: Color(0xffc5ced9),
                                              size: 25,
                                            ),
                                            onPressed: () async {
                                               currentQuiz.answer =
                                                            answerController.text;
                                                        await viewModel.setNextQuiz();
                                            },
                                          ),
                                        )
                                      : Container(
                                          margin: const EdgeInsets.only(left: 10),
                                          padding:
                                              const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Color(0xffc5ced9), width: 3)),
                                          child: TextButton(
                                            child: const Text(
                                              'Submit',
                                              style: TextStyle( color: Color(0xffc5ced9),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onPressed: () {
                                              currentQuiz.answer =
                                                  answerController.text;
                                              viewModel.submitQuiz();
                                            },
                                          ),
                                        )
                                  : const Text('');
                            }),
                      ],
                    ),
                  ),
                )
              ],
            );
          case "crossmatch":
            return const Text('Quiz - Cross Match');
          case "shortanswer":
            return Stack(
              children: [
                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: SingleChildScrollView(
                  child: SizedBox( width: double.infinity, height: MediaQuery.of(context).size.height - 100,
                                      child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        SizedBox(
                                                            width: 350,
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    const SizedBox(
                                                                      width: 40,
                                                                      child: Text('Q :', style: const TextStyle(fontSize: 18, color: Color(0xffc5ced9)),),
                                                                    ),
                                                                    Expanded(
                                                                      child: Row(children: [
                            Text(
                              style: const TextStyle(fontSize: 26, color: Color(0xffc5ced9)),
                              currentQuiz.question!),
                            (currentQuiz.tts_description??"").isNotEmpty ? IconButton(onPressed: () async {
                              await locator<TTSService>().speak(currentQuiz.tts_description!);
                            }, icon: Icon(Icons.speaker),) : SizedBox()
                          ],),
                                                                    )
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    const SizedBox(
                                                                      width: 40,
                                                                      child: Text('A :', style: const TextStyle(fontSize: 18, color: Color(0xffc5ced9)),),
                                                                    ),
                                                                    Expanded(
                                                                      child: CustomTextField(controller: answerController, focusNode: FocusNode(), textAlign: TextAlign.left, maxLines:3),)
                                                                  ],
                                                                )
                                                              ],
                                                            )),
                                                      ],
                                      ),
                                    ),
                                  ),
                                ),
                Align(alignment: Alignment.topLeft, child: Container(margin: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xff46A0F2),borderRadius: BorderRadius.circular(5)) , padding: const EdgeInsets.fromLTRB(15,5,15,5), child: Text('${viewModel.quizIndex+1}/${viewModel.currentAssessment.quizzes!.length}', style: const TextStyle(color: Colors.white),),),),
                Align( alignment: Alignment.bottomRight,
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          viewModel.quizIndex > 0
                              ? Container(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Color(0xffc5ced9), width: 3)),
                                  child: IconButton(
                                    padding: const EdgeInsets.all(0),
                                    icon: const Icon(
                                      Icons.arrow_back, color: Color(0xffc5ced9),
                                      size: 25,
                                    ),
                                     onPressed: () async {
                                    await viewModel.setPreQuiz();
                                  },
                                  ),
                                )
                              : const Text(""),
                          ValueListenableBuilder(
                              valueListenable: answerController,
                              builder: (context, TextEditingValue value, _) {
                                return value.text.isNotEmpty
                                    ? viewModel.quizIndex <
                                            viewModel.currentAssessment.quizzes!
                                                    .length -
                                                1
                                        ? Container(
                                            margin: const EdgeInsets.only(left: 10),
                                            padding:
                                                const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Color(0xffc5ced9),
                                                    width: 3)),
                                            child: IconButton(
                                              padding: const EdgeInsets.all(0),
                                              icon: const Icon(
                                                Icons.arrow_forward, color: Color(0xffc5ced9),
                                                size: 25,
                                              ),
                                             onPressed: () async {
                                              currentQuiz.answer =
                                                            answerController.text;
                                                        await viewModel.setNextQuiz();
                                            },
                                            ),
                                          )
                                        : Container(
                                            margin: const EdgeInsets.only(left: 10),
                                            padding:
                                                const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Color(0xffc5ced9),
                                                    width: 3)),
                                            child: TextButton(
                                              child: const Text(
                                                'Submit',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,color: Color(0xffc5ced9)),
                                              ),
                                              onPressed: () {
                                                currentQuiz.answer =
                                                    answerController.text;
                                                viewModel.submitQuiz();
                                              },
                                            ),
                                          )
                                    : const Text('');
                              }),
                        ],
                      )),
                )
              ],
            );
          case "mathquestion":
          var focusNode = FocusNode( canRequestFocus: true,
                            onKeyEvent: (node, event) {
                              if (event.runtimeType.toString() ==
                                  'KeyDownEvent') {
                                if (event.logicalKey ==
                                    LogicalKeyboardKey.backspace) {
                                  var str = answerController.text;
                                    if (str.isNotEmpty) {
                                      str = str.substring(1);
                                    }
                                    answerController.text = str;
                                    answerController.selection =
                                        TextSelection.fromPosition(
                                            const TextPosition(offset: 0));
                                  return KeyEventResult.handled;
                                }
                              }
                              return KeyEventResult.ignored;
                            },
                          );
            return Stack(
              children: [
                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: SingleChildScrollView(
                  child: SizedBox( width: double.infinity, height: MediaQuery.of(context).size.height - 100,
                                      child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: _buildMathQColumns(currentQuiz.questionList![0].question!, null),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: _buildMathQColumns(currentQuiz.questionList![1].question!, currentQuiz.question),
                                                        ),
                                                        SizedBox(width: (currentQuiz.answerList![0].answer!.length+1)*30 + 100, child: const Divider()),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                            SizedBox(
                                                                width: (currentQuiz.answerList![0].answer!.length+1)*30 + 30,
                                                                child: MathTextField(
                                                                    focusNode: focusNode,
                                                                    onChanged: (value) async {
                                                                      answerController.selection =
                                          TextSelection.fromPosition(
                                              const TextPosition(offset: 0));
                                                                    },
                                                                    controller: answerController,))
                                                      ],
                                      ),
                                    ),
                                  ),
                                ),
                Align(alignment: Alignment.topLeft, child: Container(margin: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xff46A0F2),borderRadius: BorderRadius.circular(5)) , padding: const EdgeInsets.fromLTRB(15,5,15,5), child: Text('${viewModel.quizIndex+1}/${viewModel.currentAssessment.quizzes!.length}', style: const TextStyle(color: Colors.white),),),),
                Align( alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        viewModel.quizIndex > 0
                            ? Container(
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Color(0xffc5ced9), width: 3)),
                                child: IconButton(
                                  padding: const EdgeInsets.all(0),
                                  icon: const Icon(
                                    Icons.arrow_back, color: Color(0xffc5ced9),
                                    size: 25,
                                  ),
                                   onPressed: () async {
                                    await viewModel.setPreQuiz();
                                  },
                                ),
                              )
                            : const Text(""),
                        ValueListenableBuilder(
                            valueListenable: answerController,
                            builder: (context, TextEditingValue value, _) {
                              return value.text.isNotEmpty
                                  ? viewModel.quizIndex <
                                          viewModel.currentAssessment.quizzes!
                                                  .length -
                                              1
                                      ? Container(
                                          margin: const EdgeInsets.only(left: 10),
                                          padding:
                                              const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Color(0xffc5ced9), width: 3)),
                                          child: IconButton(
                                            padding: const EdgeInsets.all(0),
                                            icon: const Icon(
                                              Icons.arrow_forward, color: Color(0xffc5ced9),
                                              size: 25,
                                            ),
                                             onPressed: () async {
                                              currentQuiz.answer =
                                                            answerController.text;
                                                        await viewModel.setNextQuiz();
                                            },
                                          ),
                                        )
                                      : Container(
                                          margin: const EdgeInsets.only(left: 10),
                                          padding:
                                              const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Color(0xffc5ced9), width: 3)),
                                          child: TextButton(
                                            child: const Text(
                                              'Submit',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold, color: Color(0xffc5ced9)),
                                            ),
                                            onPressed: () {
                                              currentQuiz.answer =
                                                  answerController.text;
                                              viewModel.submitQuiz();
                                            },
                                          ),
                                        )
                                  : const Text('');
                            }),
                      ],
                    ),
                  ),
                )
              ],
            );
          default:
            return const Text('Invalid Quiz Type!');
        }
      }
    } else {
      return const Text('No Quiz to Show!');
    }
  }

  Future<void> markImageCompleted(Activity? act) async {
    try {
      await Future.delayed(const Duration(seconds: 5), () {
        var cActivity = locator<ActivityViewModel>().currentActivity;
        if (act != null && cActivity != null) {
          if (act.activityId == cActivity.activityId && !act.completed) {
            locator<ActivityViewModel>().markAsComplete(false, act, null);
          }
        }
      });
    } catch (e, s) {
      locator<GlobalService>().logError("Error Occured!", e.toString(), s);
    }
  }

  List<Widget> _buildMultipleChoiceOrTrueFalseAnswer(
      ActivityViewModel viewModel) {
    List<Widget> items = [];
    for (var item in viewModel.currentQuiz.answerList!) {
      items.add(FittedBox(
          child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff8D20DE), width: 2),
            color: item.selected
                ? const Color(0xff8D20DE)
                : const Color.fromARGB(255, 240, 240, 240),
            borderRadius: BorderRadius.circular(5)),
        margin: const EdgeInsets.all(10),
        child: InkWell(
            onTap: () {
              viewModel.setQuizAnswer(item);
            },
            child: Padding(
                padding: (item.image==null || item.image!.isEmpty ) ? const EdgeInsets.fromLTRB(40,15,40,15) : const EdgeInsets.all(10),
                child: Center(
                    child: (item.image==null || item.image!.isEmpty ) ? Text(
                  item.answer!,
                  style: TextStyle(
                      fontSize: 20,
                      color: item.selected ? Colors.white : Colors.black),
                ):
                Image.network(height: 50, item.image!,
                                frameBuilder: (context, child, frame,
                                    wasSynchronouslyLoaded) {
                                if (frame == null) {
                                  return const SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                return Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.transparent,
                                            width: 3)),
                                    child: child);
                              }, loadingBuilder:
                                    (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.transparent,
                                              width: 3)),
                                      child: child);
                                } else {
                                  return const SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                              })
                ))),
      )));
    }
    return items;
  }



  List<Widget> _buildMathQColumns(String question, String? operator) {
    List<Widget> items = [];
    if (operator == null) {
      items.add(Container( padding: const EdgeInsets.fromLTRB(11,0,11,0),
        width: 30,
        height: 30,
        child: const Text('', style: TextStyle(fontSize: 20)),
      ));
    } else {
      items.add(Container( padding: const EdgeInsets.fromLTRB(11,0,11,0),
        width: 30,
        height: 30,
        child: Text(operator, style: const TextStyle(fontSize: 20),),
      ));
    }
    for (var rune in question.runes) {
      items.add(Container( padding: const EdgeInsets.fromLTRB(11,0,11,0),
        width: 30,
        height: 30,
        child: Text(String.fromCharCode(rune), style: const TextStyle(fontSize: 20)),
      ));
    }
    return items;
  }
}