import 'package:flutter/material.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: ColorResources.BACK_GROUND,
  fontFamily: 'Roboto',
  primaryColor: ColorResources.PRIMARY_1, // Màu chủ đạo
  brightness: Brightness.light,
  hintColor: ColorResources.GREY,
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
  radioTheme: _radioThemeData(),
  bottomSheetTheme: _bottomSheetThemeData(),
  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(
        secondary: ColorResources.RED,
      )
      .copyWith(
        background: ColorResources.BACK_GROUND,
      ),
  filledButtonTheme: _filledButtonThemeData(),
  // Kiểu văn bản cho nút RaisedButton
  iconButtonTheme: _iconButtonThemeData(),
  // Kiểu văn bản cho nút RaisedButton
  elevatedButtonTheme: _elevatedButtonThemeData(),
  // Kiểu văn bản cho nút FlatButton
  textButtonTheme: _textButtonThemeData(),
  // Kiểu văn bản cho nút OutlinedButton
  outlinedButtonTheme: _outlineButtonThemData(),
  textTheme: TextTheme(
    // Các các tiêu đề rất lớn.
    displayLarge: TextStyle(
      fontSize: IZISizeUtil.DISPLAY_LARGE_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      fontSize: IZISizeUtil.DISPLAY_MEDIUM_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      fontSize: IZISizeUtil.DISPLAY_SMALL_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
    ),

    // Cho các label của button. label của input
    labelLarge: TextStyle(
      fontSize: IZISizeUtil.LABEL_LARGE_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
    ),
    labelMedium: TextStyle(
      fontSize: IZISizeUtil.LABEL_MEDIUM_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
    ),
    labelSmall: TextStyle(
      fontSize: IZISizeUtil.LABEL_SMALL_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
    ),

    // Phần nội dung.
    bodyLarge: TextStyle(
      fontSize: IZISizeUtil.BODY_LARGE_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
    ),

    // Cho nội dung bình thường và mặc định.
    bodyMedium: TextStyle(
      fontSize: IZISizeUtil.BODY_MEDIUM_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
    ),
    bodySmall: TextStyle(
      fontSize: IZISizeUtil.BODY_SMALL_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
    ),
  ),
);

///
/// Filled button theme data.
///
FilledButtonThemeData _filledButtonThemeData() {
  return FilledButtonThemeData(
    style: _buttonStyle(
      backgroundColor: ColorResources.PRIMARY_1,
    ),
  );
}

///
/// Icon button them data.
///
IconButtonThemeData _iconButtonThemeData() {
  return IconButtonThemeData(
    style: _buttonStyle(),
  );
}

///
/// Radio theme data.
///
RadioThemeData _radioThemeData() {
  return RadioThemeData(
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
      return ColorResources.PRIMARY_1;
    }),
    visualDensity: VisualDensity.comfortable,
  );
}

///
/// Bottom sheet theme data.
///
BottomSheetThemeData _bottomSheetThemeData() {
  return const BottomSheetThemeData(
    backgroundColor: Colors.transparent,
    modalBackgroundColor: Colors.transparent,
    elevation: 0,
  );
}

///
/// Elevated button theme data.
///
ElevatedButtonThemeData _elevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: _buttonStyle(
      elevation: 0,
      backgroundColor: ColorResources.PRIMARY_1,
      textColor: ColorResources.OUTER_SPACE,
    ),
  );
}

///
/// Text button theme data.
///
TextButtonThemeData _textButtonThemeData() {
  return TextButtonThemeData(
    style: _buttonStyle(
      textColor: ColorResources.PRIMARY_1,
    ),
  );
}

///
/// Out line button theme data.
///
OutlinedButtonThemeData _outlineButtonThemData() {
  return OutlinedButtonThemeData(
    style: _buttonStyle(
      borderSide: const BorderSide(
        color: ColorResources.PRIMARY_1,
        width: 2,
      ),
      textColor: ColorResources.PRIMARY_1,
    ),
  );
}

/// ButtonStyle.
ButtonStyle _buttonStyle({
  BorderSide? borderSide,
  double? elevation,
  Color? backgroundColor,
  Color? textColor,
}) {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all(backgroundColor),
    foregroundColor: MaterialStateProperty.all(textColor),
    elevation: MaterialStateProperty.all(elevation ?? 0.0),
    overlayColor: MaterialStateProperty.all(Colors.transparent),
    textStyle: MaterialStatePropertyAll(TextStyle(
      fontSize: IZISizeUtil.LABEL_MEDIUM_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
    )),
    padding: const MaterialStatePropertyAll(
      EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 24,
      ),
    ),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
    side: MaterialStatePropertyAll(borderSide),
  );
}
