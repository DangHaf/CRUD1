import 'package:flutter/services.dart';
import 'package:template/core/helper/izi_number.dart';
import 'package:template/core/helper/izi_validate.dart';

class FilterInput extends TextInputFormatter {
  FilterInput({
    required this.maxValue,
    required this.minValue,
  });

  final int maxValue;
  final int minValue;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Handle "deletion" of separator character
    final String oldValueText = oldValue.text;
    String newValueText = newValue.text;

    if (IZINumber.parseInt(!IZIValidate.nullOrEmpty(oldValue.text) ? oldValue.text : 0) > maxValue && oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    } else if (!IZIValidate.nullOrEmpty(newValueText) && IZINumber.parseInt(newValueText) > maxValue) {
      return oldValue;
    } else if (IZINumber.parseInt(newValueText) < minValue) {
      return oldValue;
    }

    // Only process if the old value and new value are different
    else if (IZINumber.parseInt(newValue.text) < maxValue) {
      if (oldValueText != newValueText) {
        final int selectionIndex = newValue.text.length - newValue.selection.extentOffset;
        return TextEditingValue(
          text: newValueText.toString(),
          selection: TextSelection.collapsed(
            offset: newValueText.length - selectionIndex,
          ),
        );
      }
    } else {
      return oldValue;
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}
