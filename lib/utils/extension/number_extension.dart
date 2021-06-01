import 'package:intl/intl.dart';

String parseCurrency(int? currency) {
  var oCcy = NumberFormat("#,##0", "en_US");
  return "${oCcy.format(currency)} đ";
}

String parseCurrencyProfitPercentPlus(int? currency, double profitPercent) {
  return "${currency! >= 0 ? "+" : ""}${parseCurrency(currency)} (${currency >= 0 ? "+" : ""}$profitPercent%)";
}

double toPrecision(double raw ,{int n = 1}) => double.parse(raw.toStringAsFixed(1));