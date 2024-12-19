import 'package:flutter/material.dart';
import 'package:learning_app/custom_widgets/app_status_bar.dart';
import 'package:learning_app/custom_widgets/custom_button.dart';
import 'package:learning_app/custom_widgets/stateful_wrapper.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/services/global_service.dart';
import 'package:learning_app/services/navigation_service.dart';
import 'package:learning_app/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

class WalkthroughPage extends StatelessWidget {
  WalkthroughPage({super.key});
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
                  Expanded(flex: 3, child: Container(height: 60,color: Color(0xff363749),)),
                  Expanded(flex: 2, child: Container(height: 60,color: Color(0xff262835),)),
                  Container(padding: EdgeInsets.all(15), height: 60,color: Color(0xff363749),
                    child: Row(
                      children: [
                        CustomButton(onTap: () {
                            
                        }, text: 'Pre', fontcolor: Color(0xffc5ced9), backgroundcolor: Color(0xff6769e4), height: 40,),
                        Expanded(child: SizedBox()),
                        CustomButton(onTap: () {
                            locator<NavigationService>().pushNamedAndRemoveUntil(
                Routes.login,
                args: TransitionType.fade,
              );
                        }, text: 'Next', fontcolor: Color(0xffc5ced9), backgroundcolor: Color(0xff6769e4), height: 40,)
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}