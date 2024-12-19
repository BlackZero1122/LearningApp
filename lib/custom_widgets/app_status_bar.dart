import 'package:flutter/material.dart';
import 'package:learning_app/custom_widgets/clock.dart';
import 'package:learning_app/view_models/app_status_bar_view_model.dart';
import 'package:provider/provider.dart';
class AppStatusBar extends StatelessWidget {
  const AppStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    AppStatusBarViewModel viewModel = context.watch<AppStatusBarViewModel>();
    
    return Container(
      color: viewModel.isProduction ? const Color(0xFF3C4A55) : Colors.orangeAccent ,
      height: 25,
      child: Row(
        children: [
          Expanded(child: Row(children: [
            const SizedBox(width: 10,), 
            Text('Learning App', style: const TextStyle(color: Colors.white, fontSize: 12),),
          ],),),
          const ClockWidget(),
          Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Icon(viewModel.connectedToInternet ? Icons.wifi : Icons.wifi_off, color: Colors.white, size: 16, ),
            // const SizedBox(width: 5,), 
            // const Text('98%', style: TextStyle(color: Colors.white, fontSize: 12),),
            // const Icon(Icons.battery_full, color: Colors.white, size: 16, ),
            const SizedBox(width: 10,), 
          ],)),
        ],
      ),
    );
  }
}