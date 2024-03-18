// ignore_for_file: must_be_immutable, invalid_use_of_protected_member, avoid_positional_boolean_parameters

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template/config/export/config_export.dart';
import 'package:template/core/export/core_export.dart';

class IZIInput extends StatefulWidget {
  IZIInput({
    Key? key,
    this.label,
    this.placeHolder,
    this.allowEdit = true,
    this.maxLine = 1,
    this.isRequired = false,
    required this.type,
    this.width,
    this.fontSize,
    this.height,
    this.suffixIcon,
    this.errorText,
    this.textInputAction,
    this.onChanged,
    this.isValidate,
    this.focusNode,
    this.onSubmitted,
    this.borderRadius,
    this.hintStyle,
    this.borderSide,
    this.isBorder = false,
    this.fillColor,
    this.prefixIcon,
    this.validate,
    this.isLegend = false,
    this.borderSize,
    this.disableError = false,
    this.miniSize = false,
    this.colorDisibleBorder = ColorResources.GREY,
    this.colorBorder = ColorResources.GREEN,
    this.min = 1,
    this.max = 10,
    this.widthIncrement,
    this.iziPickerDate = IZIPickerDate.MATERIAL,
    this.obscureText,
    this.contentPaddingIncrement,
    this.onTap,
    this.isNotShadown = true,
    this.labelStyle,
    this.isTimePicker = false,
    this.maximumDate,
    this.minimumDate,
    this.initDate,
    this.style,
    this.cursorColor,
    this.controller,
    this.inputFormatters,
    this.autofocus,
    this.cupertinoDatePickerMode,
    this.textCapitalization,
    this.isReadOnly = false,
    this.textAlign,
    this.format,
    this.maxLength,
    this.maxLengthInput,
  }) : super(key: key);
  final String? label;
  final int? maxLength;
  final String? placeHolder;
  final bool? allowEdit;
  final int? maxLine;
  final IZIInputType type;
  final bool? isRequired;
  final double? width;
  final double? fontSize;
  final double? height;
  final Widget? suffixIcon;
  final String? errorText;
  final TextInputAction? textInputAction;
  final Function(String value)? onChanged;
  final Function(bool value)? isValidate;
  bool? boldHinText;
  final FocusNode? focusNode;
  final Function(dynamic)? onSubmitted;
  final double? borderRadius;
  final TextStyle? hintStyle;
  final BorderSide? borderSide;
  final bool? isBorder;
  final Color? fillColor;
  final Widget Function(FocusNode? focusNode)? prefixIcon;
  final String? Function(String)? validate;
  final bool? isLegend;
  final double? borderSize;
  final bool disableError;
  final bool miniSize;
  final Color? colorDisibleBorder;
  final Color? colorBorder;
  final double? min;
  final double? max;
  final double? widthIncrement;
  final bool? isTimePicker;
  final IZIPickerDate? iziPickerDate;
  final bool? obscureText;
  final EdgeInsets? contentPaddingIncrement;
  final Function? onTap;
  final bool? isNotShadown;
  final TextStyle? labelStyle;
  final DateTime? maximumDate;
  final DateTime? minimumDate;
  final DateTime? initDate;
  final TextStyle? style;
  final Color? cursorColor;
  final bool? autofocus;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final CupertinoDatePickerMode? cupertinoDatePickerMode;
  final TextCapitalization? textCapitalization;
  final bool? isReadOnly;
  final TextAlign? textAlign;
  final String? format;
  final int? maxLengthInput;

  _IZIInputState iziState = _IZIInputState();
  @override
  // ignore: no_logic_in_create_state
  _IZIInputState createState() => iziState = _IZIInputState();
}

class _IZIInputState extends State<IZIInput> {
  FocusNode? focusNode;
  TextEditingController? textEditingController;

  bool isShowedError = false;
  bool isVisible = true;
  bool isDisibleIncrement = false;
  bool isDisibleReduction = false;
  String? _errorText = "";

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: '');

    focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    Future.delayed(Duration.zero, () {
      focusNode?.removeListener(() {});
      focusNode?.dispose();
      focusNode = null;
    });
    textEditingController?.dispose();
    super.dispose();
  }

  TextInputType getType(IZIInputType type) {
    if (type == IZIInputType.NUMBER) {
      return TextInputType.number;
    } else if (type == IZIInputType.PASSWORD) {
      return TextInputType.visiblePassword;
    } else if (type == IZIInputType.PRICE) {
      return TextInputType.number;
    } else if (type == IZIInputType.TEXT) {
      return TextInputType.text;
    } else if (type == IZIInputType.EMAIL) {
      return TextInputType.emailAddress;
    } else if (type == IZIInputType.PHONE) {
      return TextInputType.phone;
    } else if (type == IZIInputType.DOUBLE) {
      return const TextInputType.numberWithOptions();
    } else if (type == IZIInputType.INCREMENT) {
      return TextInputType.number;
    } else if (type == IZIInputType.MULTILINE) {
      return TextInputType.multiline;
    } else if (type == IZIInputType.DATE) {
      return TextInputType.datetime;
    }
    return TextInputType.text;
  }

  TextEditingController getController(IZIInputType type) {
    return widget.controller ?? textEditingController!;
  }

  String? Function(String)? checkValidate(
    IZIInputType type,
  ) {
    if (widget.validate != null) {
      return widget.validate;
    }
    if (type == IZIInputType.NUMBER) {
      return null;
    } else if (type == IZIInputType.PASSWORD) {
      return IZIValidate.password;
    } else if (type == IZIInputType.PRICE) {
      return null;
    } else if (type == IZIInputType.TEXT) {
      return null;
    } else if (type == IZIInputType.EMAIL) {
      return null;
    } else if (type == IZIInputType.PHONE) {
      return null;
    } else {
      return null;
    }
  }

  ///
  /// Validate.
  ///
  void validator(IZIInputType type, String val) {
    if (checkValidate(widget.type) != null && isShowedError) {
      setState(() {
        _errorText = checkValidate(widget.type)!(val.toString());
        print("error: $_errorText");
      });
      if (widget.isValidate != null) {
        widget.isValidate!(IZIValidate.nullOrEmpty(_errorText));
      }
    }
  }

  ///
  /// Date picker.
  ///
  void datePicker(IZIPickerDate pickerType) {
    if (pickerType == IZIPickerDate.CUPERTINO) {
      FocusScope.of(context).unfocus();
      _showDatePickerOfCupertino();
    } else {
      _showDatePickerOfMaterial().then(
        (value) {
          if (!IZIValidate.nullOrEmpty(value)) {
            final String date = IZIDate.formatDate(value!, format: widget.format ?? 'dd/MM/yyyy');

            getController(widget.type).text = date;

            if (!IZIValidate.nullOrEmpty(widget.onChanged)) {
              // Data trả về hàm onChange.
              widget.onChanged!(date);
            }
          }
        },
      );
    }
  }

  Future<dynamic> _showDatePickerOfCupertino() {
    return showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          color: ColorResources.WHITE,
        ),
        height: IZISizeUtil.setSize(percent: .45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                width: IZISizeUtil.getMaxWidth(),
                height: IZISizeUtil.setSize(percent: .4),
                child: CupertinoDatePicker(
                  mode: widget.isTimePicker!
                      ? widget.cupertinoDatePickerMode ?? CupertinoDatePickerMode.time
                      : widget.cupertinoDatePickerMode ?? CupertinoDatePickerMode.date,
                  use24hFormat: true,
                  initialDateTime: widget.initDate ?? widget.minimumDate ?? IZITimeZone.dateTimeNow(),
                  maximumDate: widget.maximumDate ?? IZITimeZone.dateTimeNow().add(const Duration(days: 18250)),
                  minimumDate: widget.minimumDate ?? IZITimeZone.dateTimeNow().subtract(const Duration(days: 18250)),
                  onDateTimeChanged: (value) {
                    onChangeDateTime(value);
                  },
                ),
              ),
            ),
            Padding(
              padding: IZISizeUtil.setEdgeInsetsOnly(bottom: IZISizeUtil.SPACE_3X),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      getController(widget.type).text = '';
                      Get.back();
                    },
                    child: Container(
                      padding: IZISizeUtil.setEdgeInsetsSymmetric(vertical: 10),
                      width: IZISizeUtil.getMaxWidth() * .35,
                      decoration: BoxDecoration(
                        color: ColorResources.GREY,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          'Xóa',
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(color: ColorResources.WHITE),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final now = IZITimeZone.dateTimeNow();
                      // Lấy data ở controller.
                      final value = getController(widget.type).text;

                      if (IZIValidate.nullOrEmpty(value)) {
                        if (widget.isTimePicker!) {
                          onChangeDateTime(now);

                          CommonHelper.primaryFocus();
                        } else {
                          onChangeDateTime(now);
                        }
                      } else {
                        try {
                          if (widget.isTimePicker!) {
                            final date = IZIDate.formatDate(now, format: widget.format ?? 'dd/MM/yyyy');
                            onChangeDateTime(
                              IZIDate.parseDateTime('$date $value', format: widget.format ?? 'dd/MM/yyyy hh:mm'),
                            );
                          } else {
                            onChangeDateTime(
                              IZIDate.parseDateTime(value, format: widget.format ?? 'dd/MM/yyyy'),
                            );
                          }
                        } catch (e) {
                          onChangeDateTime(now);
                        }
                      }

                      Get.back();
                    },
                    child: Container(
                      padding: IZISizeUtil.setEdgeInsetsSymmetric(vertical: 10),
                      width: IZISizeUtil.getMaxWidth() * .35,
                      decoration: BoxDecoration(
                        color: ColorResources.PRIMARY_2,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          'Chọn',
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(color: ColorResources.WHITE),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void onChangeDateTime(DateTime value) {
    // Nếu là chọn giờ
    if (widget.isTimePicker!) {
      if (widget.cupertinoDatePickerMode == CupertinoDatePickerMode.dateAndTime) {
        final String date = IZIDate.formatDate(value, format: widget.format ?? 'HH:mm dd/MM/yyyy');

        // Set data cho controller
        getController(widget.type).text = date;

        // Nếu onChange ! null
        if (!IZIValidate.nullOrEmpty(widget.onChanged)) {
          widget.onChanged!(date);
        }
      } else {
        getController(widget.type).text = IZIDate.formatDate(value, format: widget.format ?? 'HH:mm'); //date;

        // Nếu hàm onChange != null
        if (!IZIValidate.nullOrEmpty(widget.onChanged)) {
          widget.onChanged!(IZIDate.formatDate(value, format: widget.format ?? 'HH:mm dd/MM/yyyy'));
        }
      }
      CommonHelper.primaryFocus();
    } else {
      final String date = IZIDate.formatDate(value);

      // Set data và controller.
      getController(widget.type).text = date;

      // Nếu onChange ! null
      if (!IZIValidate.nullOrEmpty(widget.onChanged)) {
        widget.onChanged!(date);
      }
    }
  }

  ///
  /// Date picker material.
  ///
  Future<DateTime?> _showDatePickerOfMaterial() {
    return showDatePicker(
      context: context,
      initialDate: widget.initDate ?? widget.minimumDate ?? IZITimeZone.dateTimeNow(),
      firstDate: widget.minimumDate ?? IZITimeZone.dateTimeNow().subtract(const Duration(days: 18250)),
      lastDate: widget.maximumDate ?? IZITimeZone.dateTimeNow().add(const Duration(days: 18250)),
      builder: (context, child) {
        return Theme(
          data: AppTheme.light.copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorResources.PRIMARY_2,
            ),
          ),
          child: child!,
        );
      },
    );
  }

  Widget? getSuffixIcon() {
    if (widget.type == IZIInputType.DATE && IZIValidate.nullOrEmpty(widget.suffixIcon)) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_month)
          // IZIImage(
          //   ImagesPath.pickDateIcon,
          //   width: IZIDimensions.ONE_UNIT_SIZE * 30,
          // ),
        ],
      );
      // return const Icon(
      //   Icons.calendar_today,
      //   color: ColorResources.NEUTRALS_4,
      // );
    }
    if (widget.type == IZIInputType.PASSWORD) {
      return GestureDetector(
        onTap: () {
          setState(() {
            isVisible = !isVisible;
          });
        },
        child: Icon(
          isVisible ? Icons.visibility_off : Icons.visibility,
          color: ColorResources.TEXT_BOLD.withOpacity(0.37),
        ),
      );
    }
    if (!IZIValidate.nullOrEmpty(widget.suffixIcon)) {
      return widget.suffixIcon!;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (!focusNode!.hasListeners) {
      focusNode!.addListener(() {
        setState(() {});
      });
    }
    if (!IZIValidate.nullOrEmpty(widget.errorText) && IZIValidate.nullOrEmpty(_errorText)) {
      _errorText = widget.errorText.toString();
    }

    return SizedBox(
      width: widget.width ?? IZISizeUtil.getMaxWidth(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.isLegend == false && widget.label != null) _labelInput(), // Label của input
          Row(
            children: [
              _formInput(), // Input
            ],
          ),

          if (!IZIValidate.nullOrEmpty(_errorText) && !widget.disableError) _errorTextWidget(), // Lỗi ở input
        ],
      ),
    );
  }

  Container _labelInput() {
    return Container(
      padding: IZISizeUtil.setEdgeInsetsOnly(bottom: 5),
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: widget.label,
          style: widget.labelStyle ??
              Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: ColorResources.WHITE,
                    fontSize: 16.sp,
                  ),
          children: [
            if (widget.isRequired!)
              TextSpan(
                text: ' *',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: ColorResources.RED,
                    ),
              )
            else
              const TextSpan(),
          ],
        ),
      ),
    );
  }

  Container _errorTextWidget() {
    return Container(
      margin: IZISizeUtil.setEdgeInsetsOnly(top: 5),
      alignment: Alignment.topLeft,
      child: Text(
        IZIValidate.nullOrEmpty(_errorText.toString()) ? "" : _errorText.toString(),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(
          color: ColorResources.RED,
        ),
      ),
    );
  }

  Widget _formInput() {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          if (widget.type == IZIInputType.DATE && widget.allowEdit!) {
            datePicker(widget.iziPickerDate!);
          }
        },
        child: Container(
          decoration: BoxDecoration(
              boxShadow: widget.isNotShadown! ? null : CommonHelper.boxShadow,
              color: widget.fillColor ?? ColorResources.WHITE.withOpacity(.1),
              borderRadius: IZISizeUtil.setBorderRadiusAll(
                radius: widget.borderRadius ?? IZISizeUtil.RADIUS_2X,
              )),
          width: IZIInputType.INCREMENT == widget.type ? widget.width ?? IZISizeUtil.setSize(percent: 0.1) : null,
          height: widget.miniSize ? 50 : widget.height,
          child: TextFormField(
            readOnly: widget.isReadOnly!,
            autofocus: widget.autofocus ?? false,
            onTap: () {
              if (!IZIValidate.nullOrEmpty(widget.onTap)) {
                widget.onTap!();
              }
            },
            textAlign: IZIInputType.INCREMENT == widget.type ? TextAlign.center : widget.textAlign ?? TextAlign.start,
            onFieldSubmitted: (val) {
              // Gọi hàm submit
              if (!IZIValidate.nullOrEmpty(widget.onSubmitted)) {
                widget.onSubmitted!(val);
              }
              if (!IZIValidate.nullOrEmpty(val) && IZIInputType.INCREMENT == widget.type) {
                if (IZINumber.parseInt(val) < widget.min!) {
                  getController(widget.type).text = IZINumber.parseInt(widget.min.toString()).toString();
                }
              }
            },
            onChanged: (val) {
              isShowedError = true;
              if (widget.onChanged != null) {
                widget.onChanged!(val);
                // onIncrement(widget.type, increment: true);
              }
              validator(widget.type, val.toString());
            },
            maxLength: widget.maxLengthInput,
            textInputAction: widget.textInputAction,
            keyboardType: getType(widget.type),
            maxLines: widget.maxLine,
            textAlignVertical: TextAlignVertical.center,
            enabled: widget.type == IZIInputType.DATE ? false : widget.allowEdit,
            controller: getController(widget.type),
            obscureText: widget.obscureText ?? widget.type == IZIInputType.PASSWORD && isVisible,
            focusNode: focusNode,
            inputFormatters: _getInputFormatters(widget.type),
            style: widget.style ??
                Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.normal,
                      color: ColorResources.WHITE,
                    ),
            cursorColor: widget.cursorColor ?? ColorResources.PRIMARY_1,
            textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
            decoration: InputDecoration(
              counterStyle: widget.maxLengthInput != null
                  ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: ColorResources.WHITE.withOpacity(.5),
                      )
                  : null,
              hintStyle: widget.hintStyle ??
                  Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorResources.NEUTRALS_5,
                        fontWeight: FontWeight.normal,
                      ),
              contentPadding: widget.miniSize
                  ? const EdgeInsets.all(20)
                  : widget.contentPaddingIncrement ??
                      IZISizeUtil.setEdgeInsetsSymmetric(
                        vertical: IZISizeUtil.SPACE_4X,
                        horizontal: IZISizeUtil.SPACE_3X,
                      ),
              isDense: true,
              labelText: widget.isLegend == true ? widget.label : null,
              labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: focusNode!.hasFocus ? FontWeight.w600 : FontWeight.normal,
                  ),
              prefixIcon: IZIValidate.nullOrEmpty(widget.prefixIcon) ? null : widget.prefixIcon!(focusNode),
              border: getOutlineInputBorder(),
              focusedBorder: getOutlineInputBorder(),
              enabledBorder: getOutlineInputBorder(),
              disabledBorder: getOutlineInputBorder(),
              filled: true,
              hintText: widget.placeHolder,
              fillColor: (widget.allowEdit == false)
                  ? widget.fillColor ?? ColorResources.LIGHT_GREY.withOpacity(0.4)
                  : widget.fillColor ?? Colors.transparent,
              suffixIcon: getSuffixIcon(),
            ),
          ),
        ),
      ),
    );
  }

  ///
  /// Get outlineInputBorder
  ///
  OutlineInputBorder getOutlineInputBorder() {
    BorderSide borderSide = BorderSide.none;
    if (widget.isBorder == true || widget.isLegend == true) {
      borderSide = widget.borderSide ??
          BorderSide(
            width: widget.borderSize ?? 1,
            color: (widget.allowEdit == false) ? ColorResources.LIGHT_GREY : ColorResources.LIGHT_GREY,
          );
    }

    return OutlineInputBorder(
      borderSide: borderSide,
      borderRadius: IZISizeUtil.setBorderRadiusAll(
        radius: widget.borderRadius ?? IZISizeUtil.RADIUS_2X,
      ),
    );
  }

  ///
  /// Get input formatters.
  ///
  List<TextInputFormatter> _getInputFormatters(IZIInputType type) {
    List<TextInputFormatter> resultFormat = [];

    if (widget.type == IZIInputType.NUMBER) {
      resultFormat = [FilteringTextInputFormatter.digitsOnly];
    }
    if (widget.type == IZIInputType.PRICE) {
      final locale = sl<SharedPreferenceHelper>().getLocale;
      resultFormat = [
        CurrencyTextInputFormatter(
          symbol: '',
          decimalDigits: 0,
          locale: locale.isEmpty ? 'vi' : locale,
        ),
      ];
    }
    if (widget.type == IZIInputType.DOUBLE) {
      final locale = sl<SharedPreferenceHelper>().getLocale;

      final currentLocale = locale.isEmpty ? 'vi' : locale.toString();
      resultFormat = [
        ThousandsSeparatorDecimalInputFormatter(
          locale: currentLocale,
          separator: locale == 'vi' ? '.' : ',',
          decimalSeparator: locale == 'vi' ? ',' : '.',
        ),
      ];
    }
    return widget.inputFormatters ??
        [
          ...resultFormat,
          if (!IZIValidate.nullOrEmpty(widget.maxLength)) LengthLimitingTextInputFormatter(widget.maxLength),
        ];
  }
}

class ThousandsSeparatorDecimalInputFormatter extends TextInputFormatter {
  ThousandsSeparatorDecimalInputFormatter({
    this.locale = 'vi',
    required this.decimalSeparator,
    required this.separator,
  });
  String? locale;
  String separator;
  String decimalSeparator;
  static const int decimalDigits = 2;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String newText = newValue.text.replaceAll(separator, '');
    final List<String> parts = newText.split(decimalSeparator);

    String integerPart = parts[0];
    if (integerPart.isNotEmpty) {
      final regEx = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
      integerPart = integerPart.replaceAllMapped(regEx, (Match m) => '${m[1]}$separator');
    }

    newText = integerPart;
    if (parts.length > 1) {
      String decimalPart = parts[1];
      if (decimalPart.length > decimalDigits) {
        decimalPart = decimalPart.substring(0, decimalDigits);
      }
      newText += '$decimalSeparator$decimalPart';
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
