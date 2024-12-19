import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/helpers/icons_helper.dart';
import 'package:learning_app/view_models/side_drawer_view_model.dart';
import 'package:provider/provider.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    SideDrawerViewModel viewModel = context.watch<SideDrawerViewModel>();
    return Drawer(backgroundColor: Color(0xff363749), shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))), child: 
      Column(
        children: [
          Container(color: Color(0xff41435a), height: 160,child: Row(children: [
            SizedBox(width: 20,),
            SizedBox( height: 80, width: 80, child: CircleAvatar(backgroundImage: ((FirebaseAuth.instance.currentUser?.photoURL)==null) ? null : NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!), backgroundColor: Color(0xff2e303f),)),
            SizedBox(width: 20,),
            Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(FirebaseAuth.instance.currentUser?.displayName??'Student Name', style: TextStyle(color: Color(0xffc5ced9)),),
              Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Color(0xff6769e4)), padding: EdgeInsets.fromLTRB(5,0,5,0), child: Text('Grade 1', style: TextStyle(fontSize: 14, color: Color(0xffc5ced9)),))
            ],)
          ],),),
          Expanded(child: ListView.builder(
          itemCount: viewModel.getTabs?.length,
          itemBuilder: (context, index) {
            return Material(type: MaterialType.transparency, child: ListTile(onTap: () => { viewModel.selectTab(viewModel.getTabs![index].index!) }, selected: viewModel.getTabs![index].selectedTab, selectedTileColor: Colors.black12, leading: Icon(IconsHelper.map[viewModel.getTabs![index].icon!], color: Color(0xffc5ced9), size: 25,),title: Text(viewModel.getTabs![index].text!, style: const TextStyle(fontSize: 18, color: Color(0xffc5ced9))),));
          }
                    ))
        ],
      )
    );
  }
}