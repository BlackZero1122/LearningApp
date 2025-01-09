import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/models/hive_models/activity.dart';
import 'package:learning_app/services/global_service.dart';
import 'package:learning_app/view_models/activity_view_model.dart';
import 'package:provider/provider.dart';

class PDFView extends StatefulWidget {
  final Activity currentActivity;
  const PDFView({super.key, required this.currentActivity});


  @override
  State<PDFView> createState() => _PDFView();
}

class _PDFView extends State<PDFView> {
  late Activity currentActivity;
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
      StreamController<String>();

  @override
  void initState() {
    super.initState();
    try {
      currentActivity=widget.currentActivity;

    } catch (e,s) {
      locator<GlobalService>().logError("Error Occured!", e.toString(), s);
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ActivityViewModel viewModel = context.watch<ActivityViewModel>();
    return Align(
                alignment: Alignment.center, child: Stack(
                  children: [PDF( enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: true,
                    onPageChanged: (int? current, int? total) =>
            _pageCountController.add('${current! + 1} - $total'),
                    onViewCreated: (PDFViewController pdfViewController) async {
                            _pdfViewController.complete(pdfViewController);
                            final int currentPage = await pdfViewController.getCurrentPage() ?? 0;
                            final int? pageCount = await pdfViewController.getPageCount();
                            _pageCountController.add('${currentPage + 1} - $pageCount');
                          }).cachedFromUrl(
                               viewModel.currentActivity!.content!,
                               placeholder: (progress) => Center(child: Text('$progress %')),
                               errorWidget: (error) => Center(child: Text(error.toString())),
                               
                               whenDone: (filePath) {
                                if(!viewModel.pdfcomplete){
                  viewModel.pdfcomplete=true;
                  markPdfCompleted(viewModel.currentActivity);
                                }
                               },
                             ),
                             FutureBuilder<PDFViewController>(
                               future: _pdfViewController.future,
        builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
          if(snapshot.hasData && snapshot.data != null){
            return  Align( alignment: Alignment.bottomRight,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                IconButton(onPressed: () async {
                                    final PDFViewController pdfController = snapshot.data!;
                      final int currentPage =
                          (await pdfController.getCurrentPage())! - 1;
                      if (currentPage >= 0) {
                        await pdfController.setPage(currentPage);
                      }
                                 }, icon: const Icon(Icons.arrow_back)),
                                 
                                 StreamBuilder<String>(
              stream: _pageCountController.stream,
              builder: (_, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!);
                }
                return const SizedBox();
              }),
               IconButton(onPressed: () async {
                                    final PDFViewController pdfController = snapshot.data!;
                                    final int currentPage =
                          (await pdfController.getCurrentPage())! + 1;
                          final int numberOfPages =
                          await pdfController.getPageCount() ?? 0;
                          if (numberOfPages > currentPage) {
                        await pdfController.setPage(currentPage);}
                                 }, icon: const Icon(Icons.arrow_forward))
                                   
                                 ],),
            );
          }
          return const SizedBox();
           }
                             )
                             ]
                ));
  }

    Future<void> markPdfCompleted(Activity? act) async {
    try {
      await Future.delayed(const Duration(seconds: 1), () {
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
}