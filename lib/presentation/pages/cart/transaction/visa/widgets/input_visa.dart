import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/utils/color_resources.dart';

class InputVisa extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final int? maxLength;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;

  const InputVisa({
    Key? key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.focusNode,
    this.keyboardType,
    this.maxLength,
    this.suffixIcon,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(children: [
            TextSpan(
              text: label,
              style: AppText.text14.copyWith(
                  color: ColorResources.COLOR_464647,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Nunito'),
            ),
            TextSpan(
              text: ' *',
              style: AppText.text14.copyWith(
                color: ColorResources.COLOR_EB0F0F,
                fontWeight: FontWeight.w700,
                fontFamily: 'Nunito',
              ),
            ),
          ]),
        ),
        const SizedBox(height: 3),
        TextFormField(
          controller: controller,
          maxLength: maxLength,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
            isDense: true,
            hintText: hintText,
            hintStyle: AppText.text12.copyWith(
              color: ColorResources.COLOR_A4A2A2,
            ),
            suffixIcon: suffixIcon,
            counterText: '',
          ),
        ),
      ],
    );
  }
}
