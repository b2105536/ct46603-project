import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final NumberFormat _currencyFormatter =
      NumberFormat.currency(locale: 'vi_VN', symbol: 'VND');

  static String format(int amount) {
    return _currencyFormatter.format(amount);
  }
}
