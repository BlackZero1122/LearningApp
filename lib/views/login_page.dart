import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learning_app/custom_widgets/custom_button.dart';
import 'package:learning_app/custom_widgets/default_text_input.dart';
import 'package:learning_app/custom_widgets/stateful_wrapper.dart';
import 'package:learning_app/helpers/app_localizations.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/helpers/validations.dart';
import 'package:learning_app/services/auth_service.dart';
import 'package:learning_app/services/navigation_service.dart';
import 'package:learning_app/view_models/authentication_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final formKey =  GlobalKey<FormState>();
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  final scaffoldKey = GlobalKey<ScaffoldState>(); 

  @override
  Widget build(BuildContext context) {
    AuthenticationViewModel viewModel = context.watch<AuthenticationViewModel>();
    return StatefulWrapper(
      onDispose: (){
        emailController.dispose();
        passwordController.dispose();
      },
      onInit: () {
        //
      },
      child: Scaffold( backgroundColor: Color(0xff262835), key: scaffoldKey, resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Expanded(child: SizedBox()),
            SizedBox( height: 470,
              child: Container( height: double.infinity,
                  decoration: const BoxDecoration(color: Color(0xff262835),),
                  child: SingleChildScrollView(
              child: Padding( padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Form( key: formKey,
                      child: Column(
                        children: [
                          Card(color: Color(0xff363749), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), margin: EdgeInsetsDirectional.only(top: 20, end: 20, start: 20), elevation: 1, child: Padding( padding: EdgeInsets.all(30),
                            child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                      Text('Email', style: TextStyle(color: Color(0xffc5ced9)),),
                                      DefaultTextInput(validator:(value) {
                                  if (value == null || value.isEmpty) {
                                    return AppLocalizations.of(context)!.translate('enterEmail');
                                  }
                                  if(!isValidEmail(value)){
                                    return AppLocalizations.of(context)!.translate('validEmail');
                                    
                                  }
                                  return null;
                                },
                                formatters:  <TextInputFormatter>[
                                                FilteringTextInputFormatter.allow(RegExp("[0-9@a-zA-Z.]")),
                                              ],controller: emailController, fillColor: Color(0xffc5ced9), hintText: "Email...",),
                                      SizedBox(height: 20,),
                                      Text('Password', style: TextStyle(color: Color(0xffc5ced9)),),
                                      DefaultTextInput(secureText: !viewModel.getShowPassword, isPassword: true, onEyePressed: () {
                                        viewModel.setShowPassword(!viewModel.getShowPassword);
                                      }, showPassword: viewModel.getShowPassword, validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return "Please enter password.";
                                                    }
                                                    return null;
                                                  },controller: passwordController, fillColor: Color(0xffc5ced9), hintText: "Password...",),
                                      SizedBox(height: 20,),
                                Row(children: [
                                  // Expanded(child: Row(
                                  //   children: [
                                  //     Checkbox( side: BorderSide(color: Color(0xffc5ced9), width: 2), value: viewModel.rememberMe, onChanged: (value){
                                  //       viewModel.setRememberMe(value!);
                                  //     }),
                                  //     GestureDetector(onTap: () {
                                  //       viewModel.setRememberMe(!viewModel.rememberMe);
                                  //     }, child: Text('Remember me', style: TextStyle(color: Color(0xffc5ced9), fontSize: 14),))
                                  //   ],
                                  // )),
                                  Expanded(
                                    child: CustomButton(onTap: () {
                                       if (formKey.currentState!.validate()) {
                                                      viewModel.login(emailController.text, passwordController.text);
                                                    }
                                    
                                                        }, text: 'Login', fontcolor: Color(0xffc5ced9), backgroundcolor: Color(0xff6769e4), height: 40,),
                                  )
                                ],),
                                SizedBox(height: 20,),
                                Row(children: [
                                  Expanded(child: SizedBox(height: 45, child: Card(color: Color(0xff41435a), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), child: InkWell(onTap: () async {
                                    viewModel.loginViaGoogle(context);
                                  }, child: Center(child: FaIcon(FontAwesomeIcons.google, color: Color(0xffc5ced9), size: 20,))),))),
                                  Expanded(child: SizedBox(height: 45, child: Card(color: Platform.isIOS ? Color(0xff41435a) : const Color.fromARGB(88, 158, 158, 158), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), child: InkWell(onTap: Platform.isIOS ? () async {
                                    viewModel.loginViaApple();
                                  } : null, child: Center(child: Icon(Icons.apple, color: Color(0xffc5ced9), size: 25,))),))),
                                ],)
                              ],
                            ),
                          ),),
                          Align( alignment: Alignment.bottomCenter,
                            child: SizedBox(height: 60, width: 250, child: InkWell(onTap: () {
                              locator<NavigationService>().pushNamedAndRemoveUntil(
                      Routes.signup,
                      args: TransitionType.fade,
                                          );
                            }, child: Card(margin: EdgeInsets.only(top: 0), color: Color.fromARGB(204, 51, 52, 70),
                              child: Center(child: Text('Sign Up', style: TextStyle(color: Color(0xffc5ced9)),)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))),))),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
                    ),
                ),
            ),
            Expanded(child: Padding(padding: EdgeInsets.only(top: 20), child: Text('Forgot Password?', style: TextStyle(color: Color(0xffc5ced9)),)))
          ],
        ),
      ),
    );
  }

}