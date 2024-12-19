import 'package:flutter/material.dart';
import 'package:learning_app/helpers/locator.dart';
import 'package:learning_app/view_models/side_drawer_view_model.dart';

class AppTopBar extends StatelessWidget {
  final String text;
  final bool isMain;
  const AppTopBar({super.key, required this.text, this.isMain=true});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      child: Container(
          color: Color(0xff363749),
          height: 65,
          padding: const EdgeInsets.all(7),
          child: Row(
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Builder(builder: (context) {
                    return SizedBox(
                      width: 55,
                      height: 55,
                      child: TextButton(
                        style: const ButtonStyle( padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
                            foregroundColor:
                                WidgetStatePropertyAll(Colors.black),
                            alignment: Alignment.center),
                        child: isMain ? const Icon(Icons.menu, color: Color(0xffc5ced9), size: 35,) : const Icon(Icons.arrow_back, color: Color(0xffc5ced9), size: 35,),
                        onPressed: () async {
                          if(isMain){
                            Scaffold.of(context).openDrawer();
                          } else{
                            if(context.mounted){
                              Navigator.pop(context);
                            }
                          }
                        },
                      ),
                    );
                  })),

              //TextField Design
              Expanded(
                  child: Center(
                    child: Text(text,
                                    style: const TextStyle(fontSize: 24, color: Color(0xffc5ced9), fontWeight: FontWeight.w500),
                                  ),
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Builder(builder: (context) {
                    return (isMain && text.toLowerCase() == "home") ? SizedBox(
                      width: 55,
                      height: 55,
                      child: TextButton(
                        style: const ButtonStyle( padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
                            foregroundColor:
                                WidgetStatePropertyAll(Colors.black),
                            alignment: Alignment.center),
                        child: const Icon(Icons.notifications, color: Color(0xffc5ced9), size: 35,),
                        onPressed: () async {
                          locator<SideDrawerViewModel>().selectTab(1);
                        },
                      ),
                    ) : SizedBox( width: 55,
                      height: 55,);
                  })),
            ],
          )),
    );
  }
}
