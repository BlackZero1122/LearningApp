import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_app/custom_widgets/custom_button.dart';
import 'package:learning_app/custom_widgets/default_text_input.dart';
import 'package:learning_app/custom_widgets/stateful_wrapper.dart';
import 'package:learning_app/helpers/app_localizations.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/helpers/validations.dart';
import 'package:learning_app/services/navigation_service.dart';
import 'package:learning_app/view_models/authentication_view_model.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final formKey =  GlobalKey<FormState>();
  final emailController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  final confirmPasswordController = TextEditingController(text: '');
  final nameController = TextEditingController(text: '');
  final scaffoldKey = GlobalKey<ScaffoldState>(); 

  @override
  Widget build(BuildContext context) {
    AuthenticationViewModel viewModel = context.watch<AuthenticationViewModel>();
    String gender="Male";
    return StatefulWrapper(
      onDispose: (){
        emailController.dispose();
        passwordController.dispose();
        nameController.dispose();
        confirmPasswordController.dispose();
      },
      onInit: () {
        //
      },
      child: Scaffold(backgroundColor: Color(0xff262835), key: scaffoldKey, resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Expanded(child: SizedBox()),
            SizedBox( height: 670,
              child: Container( height: double.infinity,
                  decoration: const BoxDecoration(color: Color(0xff262835),),
                  child: SingleChildScrollView(
              child: Padding( padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      child: Form( key: formKey,
                        child: Column(
                          children: [
                            StatefulBuilder( builder: (context, setState) {
                              return Card(color: Color(0xff363749), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), margin: EdgeInsetsDirectional.only(top: 20, end: 20, start: 20), elevation: 1, child: Padding( padding: EdgeInsets.all(30),
                                child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Full Name', style: TextStyle(color: Color(0xffc5ced9)),),
                                    DefaultTextInput( validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return "Please enter your name.";
                                                  }
                                                  return null;
                                                },controller: nameController, fillColor: Color(0xffc5ced9), hintText: "Full Name..."),
                                    SizedBox(height: 10,),
                                    Text('Gender', style: TextStyle(color: Color(0xffc5ced9)),),
                                    Row(children: [
                                      Expanded(
                                        child: ListTile(
                                                  title: const Text('Male', style: TextStyle(color: Colors.grey),),
                                                  leading: SizedBox( width: 10,
                                                    child: Radio<String>(fillColor: WidgetStatePropertyAll(Colors.grey),
                                                      value: "Male",
                                                      groupValue: gender,
                                                      onChanged: (String? value) {
                                                        setState(() {
                                                          gender = value!;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                      ),
                                      Expanded(
                                        child: ListTile(
                                                  title: const Text('Female', style: TextStyle(color: Colors.grey),),
                                                  leading: SizedBox( width: 10,
                                                    child: Radio<String>(fillColor: WidgetStatePropertyAll(Colors.grey),
                                                      value: "Female",
                                                      groupValue: gender,
                                                      onChanged: (String? value) {
                                                        setState(() {
                                                          gender = value!;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                      )
                                    ],),
                                    SizedBox(height: 5,),
                                    Text('Email', style: TextStyle(color: Color(0xffc5ced9)),),
                                    DefaultTextInput(validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return "Please enter your email.";
                                                  }
                                                  if(!isValidEmail(value)){
                                    return AppLocalizations.of(context)!.translate('validEmail');
                                    
                                  }
                                                  return null;
                                                },controller: emailController, fillColor: Color(0xffc5ced9), hintText: "Email...",),
                                    SizedBox(height: 20,),
                                    Text('Password', style: TextStyle(color: Color(0xffc5ced9)),),
                                    DefaultTextInput(validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return "Please enter password.";
                                                  }
                                                  if (!isPasswordValid(value)) {
                                                      return "Please enter valid password.";
                                                    }
                                                  return null;
                                                },controller: passwordController, fillColor: Color(0xffc5ced9), hintText: "Password...", isPassword: true,),
                                    SizedBox(height: 20,),
                                    Text('Confirm Password', style: TextStyle(color: Color(0xffc5ced9)),),
                                    DefaultTextInput(validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return "Please enter confirm password";
                                                  }
                                                  if (!doPasswordsMatch(passwordController.text,value)) {
                                                      return "Password not match.";
                                                    }
                                                  return null;
                                                },controller: confirmPasswordController, fillColor: Color(0xffc5ced9), hintText: "Confirm Password...", isPassword: true,),
                                    SizedBox(height: 20,),
                                    SizedBox( width: double.infinity,
                                      child: CustomButton(onTap: () {
                                        if (formKey.currentState!.validate()) {
                                                    viewModel.signup(nameController.text, emailController.text, passwordController.text, gender);
                                                  }
                                                            }, text: 'Sign Up', fontcolor: Color(0xffc5ced9), backgroundcolor: Color(0xff6769e4), height: 40,),
                                    )
                                  ],
                                ),
                              ),);
                            },
                            ),
                            Align( alignment: Alignment.bottomCenter,
                              child: SizedBox(height: 60, width: 250, child: InkWell(onTap: () {
                                locator<NavigationService>().pushNamedAndRemoveUntil(
                        Routes.login,
                        args: TransitionType.fade,
                                            );
                              }, child: Card(margin: EdgeInsets.only(top: 0), color: Color.fromARGB(204, 51, 52, 70),
                                child: Center(child: Text('Log In', style: TextStyle(color: Color(0xffc5ced9)),)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))),))),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                    ),
                ),
            ),
            Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
  
}