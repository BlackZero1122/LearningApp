import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:learning_app/custom_widgets/custom_button.dart';
import 'package:learning_app/custom_widgets/default_text_input.dart';
import 'package:learning_app/custom_widgets/stateful_wrapper.dart';
import 'package:learning_app/helpers/icons_helper.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/models/message.dart';
import 'package:learning_app/services/api_service.dart';
import 'package:learning_app/services/error_reporting_service.dart';
import 'package:learning_app/services/global_service.dart';
import 'package:learning_app/services/navigation_service.dart';
import 'package:learning_app/services/schedule_service.dart';
import 'package:learning_app/view_models/home_view_model.dart';
import 'package:learning_app/view_models/user_view_model.dart';

class DialogService implements IDialogService {
  IAPIService get _apiService => locator<IAPIService>();
  IErrorReportingService get _errorReportingService =>
      locator<IErrorReportingService>();
  NavigationService get _navigationService => locator<NavigationService>();
  GlobalService get _globalService => locator<GlobalService>();
  UserViewModel get _userViewModel => locator<UserViewModel>();
  ScheduleService get _scheduleService => locator<ScheduleService>();
  HomeViewModel get _homeViewModel => locator<HomeViewModel>();

  OverlayEntry? overlayEntry;
  bool isDot = false;
  int dotCount = 0;
  final List<int> _colors = [
    0xFFFF6F00,
    0xFFBF360C,
    0xFF33691E,
    0xFF004D40,
    0xFF00B8D4,
    0xFF2962FF,
    0xFF6200EA,
    0xFFB71C1C,
    0xFFFF1744,
    0xFFFF6F00,
    0xFFBF360C,
    0xFF33691E,
    0xFF004D40,
    0xFF00B8D4,
    0xFF2962FF,
    0xFF6200EA,
    0xFFB71C1C,
    0xFFFF1744
  ];

  @override
  Future<bool> showAlert(Message message) async {
    var isLoader = EasyLoading.isShow ? true : false;
    if (isLoader) {
      await EasyLoading.dismiss();
    }
    var res = await showDialog<bool>(
            context: _navigationService.navigatorKey.currentContext!,
            barrierDismissible: false, // user must tap button!
            builder: (_) => PopScope(
                  canPop: false,
                  child: Dialog( backgroundColor: Color(0xff262835),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Builder(builder: (context) {
                        // Get available height and width of the build area of this widget. Make a choice depending on the size.
                        return Padding(
                          padding: const EdgeInsets.all(15),
                          child: SizedBox(
                            width: 600,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Text(
                                    message.title,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Color(0xffc5ced9),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Flexible(
                                  child: SingleChildScrollView(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Color(0xff363749),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Text(message.description, style: TextStyle(color: Color(0xffc5ced9)),)
                                              ])),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          CustomButton(
                                            text: message.okText,
                                            onTap: () {
                                              _navigationService.popDialog(
                                                  result: null);
                                            },
                                            backgroundcolor: Color(0xff6769e4),
                                            fontcolor: Color(0xffc5ced9),
                                          ),
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })),
                )) ??
        false;
    if (isLoader) {
      await EasyLoading.show(status: 'loading...');
    }
    return res;
  }

  @override
  Future<int> showBottomSheet(Message message) async {
    var isLoader = EasyLoading.isShow ? true : false;
    if (isLoader) {
      await EasyLoading.dismiss();
    }
    int res = -1;
    var context = _navigationService.navigatorKey.currentContext!;
    if (context.mounted) {
      res = await showModalBottomSheet<int>(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              constraints: const BoxConstraints(
                  maxWidth: double.infinity, maxHeight: 220),
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                    width: double.infinity,
                    child: Column(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: Text(message.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(message.description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 12.0)),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: message.bottomSheetItems!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: InkWell(
                                        onTap: () {
                                          _navigationService.popDialog(
                                              result: index);
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(_colors[index]),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            width: 120,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                    child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Icon(
                                                          IconsHelper.map[message
                                                              .bottomSheetItems![
                                                                  index]!
                                                              .icon!],
                                                          size: 45,
                                                          color: Colors.white,
                                                        ))),
                                                Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Container(
                                                      padding: const EdgeInsets.all(5),
                                                      height: 40,
                                                      width: double.infinity,
                                                      color: Colors.black12,
                                                      child: Center(
                                                          child: Text( maxLines: 1, overflow: TextOverflow.ellipsis,
                                                        message
                                                            .bottomSheetItems![
                                                                index]!
                                                            .text1!,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                                    ))
                                              ],
                                            ))));
                              }),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ]));
              }) ??
          -1;
    }
    if (isLoader) {
      await EasyLoading.show(status: 'loading...');
    }
    return res;
  }

  @override
  Future<int> showSelect(Message message) async {
    var isLoader = EasyLoading.isShow ? true : false;
    if (isLoader) {
      await EasyLoading.dismiss();
    }
    var res = await showDialog<int>(
            context: _navigationService.navigatorKey.currentContext!,
            barrierDismissible: true,
            builder: (_) => PopScope(
                  canPop: true,
                  child: Dialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Builder(builder: (context) {
                        // Get available height and width of the build area of this widget. Make a choice depending on the size.
                        return Padding(
                          padding: const EdgeInsets.all(25),
                          child: SizedBox(
                            width: 600,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                  child: Text(
                                    message.description,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: message.items!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ListTile(
                                            title: Text(message.items![index]!),
                                            onTap: () {
                                              _navigationService.popDialog(
                                                  result: index);
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })),
                )) ??
        -1;
    if (isLoader) {
      await EasyLoading.show(status: 'loading...');
    }
    return res;
  }

  @override
  Future<String> showSelectString(Message message) async {
    var isLoader = EasyLoading.isShow ? true : false;
    if (isLoader) {
      await EasyLoading.dismiss();
    }

    var res = await showDialog<String>(
        context: _navigationService.navigatorKey.currentContext!,
        barrierDismissible: true,
        builder: (_) => PopScope(
              canPop: true,
              child: Dialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(25),
                      child: SizedBox(
                        width: 600,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: Text(
                                message.description,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: message.items!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        title: Text(message.items![index]!),
                                        onTap: () {
                                          _navigationService.popDialog(
                                              result: message.items![index]!);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
            ));

    if (isLoader) {
      await EasyLoading.show(status: 'loading...');
    }

    return res ?? "";
  }

  @override
  Future<bool> showPrompt(Message message) async {
    var isLoader = EasyLoading.isShow ? true : false;
    if (isLoader) {
      await EasyLoading.dismiss();
    }
    var res = await showDialog<bool>(
            context: _navigationService.navigatorKey.currentContext!,
            barrierDismissible: false, // user must tap button!
            builder: (_) => PopScope(
                  canPop: false,
                  child: Dialog( backgroundColor: Color(0xff262835),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Builder(builder: (context) {
                        // Get available height and width of the build area of this widget. Make a choice depending on the size.
                        return Padding(
                          padding: const EdgeInsets.all(15),
                          child: SizedBox(
                            width: 600,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Text(
                                    message.title,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Color(0xffc5ced9),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Flexible(
                                  child: SingleChildScrollView(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Color(0xff363749),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Text(message.description, style: TextStyle(color: Color(0xffc5ced9)),)
                                              ])),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          CustomButton(
                                            text: message.cancelText,
                                            onTap: () {
                                              _navigationService.popDialog(
                                                  result: false);
                                            },
                                            backgroundcolor: Color(0xff363749),
                                            fontcolor: Color(0xffc5ced9)
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          CustomButton(
                                            text: message.okText,
                                            onTap: () {
                                              _navigationService.popDialog(
                                                  result: true);
                                            },
                                            backgroundcolor: Color(0xff6769e4),
                                            fontcolor: Color(0xffc5ced9),
                                          ),
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })),
                )) ??
        false;
    if (isLoader) {
      await EasyLoading.show(status: 'loading...');
    }
    return res;
  }

  @override
  Future<void> showToast(Message message) async {
    ScaffoldMessenger.of(_navigationService.navigatorKey.currentContext!)
        .showSnackBar(SnackBar(
            content: Text(
      message.description,
      style: const TextStyle(fontSize: 14),
    )));
  }

}

abstract class IDialogService {
  Future<bool> showAlert(Message message);
  Future<bool> showPrompt(Message message);
  Future<void> showToast(Message message);
  Future<int> showSelect(Message message);
  Future<String> showSelectString(Message message);
  Future<int?> showBottomSheet(Message message);
}
