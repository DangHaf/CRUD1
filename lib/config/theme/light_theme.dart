import 'package:flutter/material.dart';
import 'package:template/core/helper/izi_size_util.dart';
import 'package:template/core/utils/color_resources.dart';

ThemeData lightTheme = ThemeData(
  visualDensity: const VisualDensity(vertical: VisualDensity.minimumDensity, horizontal: VisualDensity.minimumDensity),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
  ),
  scaffoldBackgroundColor: ColorResources.BACK_GROUND,
  fontFamily: 'Nunito',
  primaryColor: ColorResources.PRIMARY_1, // Màu chủ đạo
  brightness: Brightness.light,
  hintColor: ColorResources.GREY,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.fuchsia: CupertinoPageTransitionsBuilder(),
    },
  ),
  dividerTheme: DividerThemeData(color: ColorResources.WHITE.withOpacity(.2)),
  radioTheme: _radioThemeData(),
  bottomSheetTheme: _bottomSheetThemeData(),
  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(
        secondary: ColorResources.COLOR_3B71CA,
      )
      .copyWith(
        background: ColorResources.BACK_GROUND,
      ),
  filledButtonTheme: _filledButtonThemeData(),
  iconButtonTheme: _iconButtonThemeData(),
  elevatedButtonTheme: _elevatedButtonThemeData(),
  textButtonTheme: _textButtonThemeData(),
  outlinedButtonTheme: _outlineButtonThemData(),

  textTheme: TextTheme(
    //
    // Set for big title.
    displayLarge: TextStyle(
      fontSize: IZISizeUtil.DISPLAY_LARGE_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
      color: ColorResources.WHITE,
    ),
    displayMedium: TextStyle(
      fontSize: IZISizeUtil.DISPLAY_MEDIUM_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
      color: ColorResources.WHITE,
    ),
    displaySmall: TextStyle(
      fontSize: IZISizeUtil.DISPLAY_SMALL_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
      color: ColorResources.WHITE,
    ),

    // Set for labels.
    labelLarge: TextStyle(
      fontSize: IZISizeUtil.LABEL_LARGE_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      color: ColorResources.WHITE,
      letterSpacing: 0,
      wordSpacing: 0,
    ),
    labelMedium: TextStyle(
      fontSize: IZISizeUtil.LABEL_MEDIUM_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      color: ColorResources.WHITE,
      letterSpacing: 0,
      wordSpacing: 0,
    ),
    labelSmall: TextStyle(
      fontSize: IZISizeUtil.LABEL_SMALL_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      color: ColorResources.WHITE,
      letterSpacing: 0,
      wordSpacing: 0,
    ),

    // Set for content.
    bodyLarge: TextStyle(
      fontSize: IZISizeUtil.BODY_LARGE_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      color: ColorResources.WHITE,
    ),
    bodyMedium: TextStyle(
      fontSize: IZISizeUtil.BODY_MEDIUM_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      color: ColorResources.WHITE,
    ),
    bodySmall: TextStyle(
      fontSize: IZISizeUtil.BODY_SMALL_FONT_SIZE,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      color: ColorResources.WHITE,
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
      return ColorResources.PRIMARY_4;
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
