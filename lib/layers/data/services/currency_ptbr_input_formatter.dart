import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);
    final formatter = NumberFormat("#,##0.00", "pt_BR");
    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

class TextFormatter {
  static String priceFormat(double value) {
    final formatter = NumberFormat("#,##0.00", "pt_BR");
    String newText = formatter.format(value);
    return newText;
  }

  static String quantityFormat(double value) {
    final formatter = NumberFormat("#,##0.##", "pt_BR");
    String newText = formatter.format(value);
    return newText;
  }

  static double cleanText(String text) {
    String cleanedText = text.replaceAll('.', '').replaceAll(',', '.');
    return double.parse(cleanedText);
  }
}
