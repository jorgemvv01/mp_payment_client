import 'package:intl/intl.dart';

class Utils {
  static String getCurrencyFormat(double value){
    return NumberFormat.simpleCurrency(
      decimalDigits: 2,
    ).format(value);
  }
}