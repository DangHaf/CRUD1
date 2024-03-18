import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/core/helper/app_text.dart';
import 'package:template/core/utils/color_resources.dart';

class AuthInput extends StatefulWidget {
  final String? label;
  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final Color fillColor;
  final bool isRequired;
  final bool isBorder;
  final String? subLabel;
  final bool isPassword;
  final bool isSelect;
  final Function()? onTap;
  final Function(String)? onChange;
  final bool readOnly;
  final Function()? onNext;
  final int? maxLine;
  final bool isShowCounter;

  const AuthInput({
    Key? key,
    this.label,
    required this.controller,
    required this.hintText,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.suffixIcon,
    this.prefixIcon,
    this.inputFormatters,
    this.fillColor = Colors.white,
    this.isRequired = true,
    this.isBorder = false,
    this.subLabel,
    this.isPassword = false,
    this.onTap,
    this.isSelect = false,
    this.readOnly = false,
    this.onChange,
    this.onNext,
    this.maxLine,
    this.textInputAction,
    this.isShowCounter = false,
  }) : super(key: key);

  @override
  State<AuthInput> createState() => _AuthInputState();
}

class _AuthInputState extends State<AuthInput> {
  bool obscureText = false;

  @override
  void initState() {
    if (widget.isPassword) {
      obscureText = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: widget.label,
                    style: AppText.text14.copyWith(
                      color: ColorResources.COLOR_464647,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (widget.subLabel != null)
                    TextSpan(
                      text: widget.subLabel,
                      style: AppText.text12.copyWith(
                        color: ColorResources.COLOR_464647,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  if (widget.isRequired)
                    TextSpan(
                      text: ' *',
                      style: AppText.text14.copyWith(
                        color: ColorResources.COLOR_DE0000,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ]),
              ),
              const SizedBox(height: 6),
            ],
          ),
        TextFormField(
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          focusNode: widget.focusNode,
          obscureText: obscureText,
          controller: widget.controller,
          maxLength: widget.isPassword ? null : widget.maxLength,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          textInputAction: widget.onNext != null
              ? TextInputAction.next
              : widget.textInputAction,
          maxLines: widget.isPassword ? 1 : widget.maxLine,
          onFieldSubmitted: (value) {
            if (widget.onNext != null) {
              widget.onNext!();
            }
          },
          onChanged: widget.onChange,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: !widget.isBorder
                  ? BorderSide.none
                  : BorderSide(
                      color: ColorResources.COLOR_A4A2A2.withOpacity(0.8),
                      width: 0.25,
                    ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: !widget.isBorder
                  ? BorderSide.none
                  : BorderSide(
                      color: ColorResources.COLOR_A4A2A2.withOpacity(0.8),
                      width: 0.25,
                    ),
            ),
            fillColor: widget.fillColor,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 22,
            ),
            isDense: true,
            hintText: widget.hintText,
            hintStyle: AppText.text14.copyWith(
              color: ColorResources.COLOR_B1B1B1,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                  )
                : widget.isSelect
                    ? Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: ColorResources.COLOR_464647,
                        size: 18.sp,
                      )
                    : widget.suffixIcon,
            counterText: !widget.isShowCounter ? '' : null,
            prefixIcon: widget.prefixIcon,
          ),
        ),
      ],
    );
  }
}
