import 'package:intl/intl.dart';

String parseCurrency(int? currency) {
  var oCcy = NumberFormat("#,##0", "en_US");
  return "${oCcy.format(currency)} đ";
}

String parseCurrencyPlus(int? currency) {
  return "";
}