import 'package:flutter/material.dart';
import 'package:learning_app/custom_widgets/app_status_bar.dart';
import 'package:learning_app/custom_widgets/app_top_bar.dart';
import 'package:learning_app/custom_widgets/side_drawer.dart.dart';
import 'package:learning_app/custom_widgets/stateful_wrapper.dart';
import 'package:learning_app/helpers/icons_helper.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/view_models/setting_view_model.dart';
import 'package:learning_app/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatelessWidget {
  NotificationsPage({super.key});
  final scaffoldKey = GlobalKey<ScaffoldState>(); 

  @override
  Widget build(BuildContext context) {

    final formKey = GlobalKey<FormState>();
    return StatefulWrapper(
      onDispose: (){
      },
      onInit: () {
      },
      child: Scaffold( key: scaffoldKey,
          backgroundColor: Color(0xff262835),
        drawer: const SideDrawer(),
        body: Column(
          children: [
            const AppTopBar(text: "Notifications",),
              const SizedBox(height: 1,),
            Expanded(
              child: Text(''),
          )],
        ),
      ),
    );
  }

}
