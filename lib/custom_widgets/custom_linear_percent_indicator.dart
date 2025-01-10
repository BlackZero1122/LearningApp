import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CustomLinearPercentIndicator extends StatelessWidget {
  final double percent;
  final String centerText;

  CustomLinearPercentIndicator({required this.percent, required this.centerText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Add margin for spacing
      child: Column(
        children: [
           Text(
              centerText,textAlign: TextAlign.left,
              style: TextStyle( 
                fontSize: 16, // Larger font size
                fontWeight: FontWeight.bold, // Bold text
                color: const Color.fromARGB(255, 33, 33, 33), // Contrasting color
              ),
            ),
          LinearPercentIndicator(
            animation: true,
            animationDuration: 1000,
            lineHeight: 60.0, // Increased height for prominence
            padding: EdgeInsets.all(0),
            percent: percent,
           
            barRadius: Radius.circular(10), // More rounded corners
            
            backgroundColor: Colors.grey[300], // Background color
            linearStrokeCap: LinearStrokeCap.roundAll, // Rounded ends
            // Add a gradient effect
            linearGradient: LinearGradient(
              colors: [Color(0xff6769e4), Color(0xff4a54e1)], // Gradient colors
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ],
      ),
    );
  }
}
