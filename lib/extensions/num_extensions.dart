import 'dart:math';

extension NumExtension on num {
  String formatToDollarValue(){
    String returnedValue="";
    if(isNegative){
        returnedValue='(\$${(this*-1).toStringAsFixed(2)})';
      }else{
        returnedValue='\$${toStringAsFixed(2)}';
      }
    return returnedValue;
  }

  String formatPriceValue(){
    String returnedValue="";
    if(isNegative){
        returnedValue='(${(this*-1).toStringAsFixed(2)})';
      }else{
        returnedValue=toStringAsFixed(2);
      }
    return returnedValue;
  }

  String formatQuantityValue(){
    return toStringAsFixed(0);
  }

  double toRound({int decimalPlaces = 2}) {
    num mod = pow(10.0, decimalPlaces.toDouble());
    return (this * mod).round() / mod;
  }

  double toNotRound({int decimalPlaces = 2}) {
    num mod = pow(10.0, decimalPlaces.toDouble());
    return ((this * mod).truncateToDouble() / mod);
  }

}


