import 'package:flutter/material.dart';
import 'package:mvvm_demo/core/utils/color_manager.dart';
import 'package:mvvm_demo/core/utils/font_manager.dart';
import 'package:mvvm_demo/core/utils/styles_manager.dart';
import 'package:mvvm_demo/core/utils/value_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      // main colors of the app
      primaryColor: ColorManager.primary,
      primaryColorLight: ColorManager.primaryOpacity70,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.gray1,
      splashColor: ColorManager.primaryOpacity70,
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: ColorManager.gray),
      // card view theme
      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.gray,
          elevation: AppSize.s4),
      // appbar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.white,
          // elevation: AppSize.s4,
          elevation: 0,
          shadowColor: ColorManager.white,
          titleTextStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSizeManager.s16)),
      // button theme
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorManager.gray1,
          buttonColor: ColorManager.primary,
          splashColor: ColorManager.primaryOpacity70),
      // text button theme
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(ColorManager.primary))),
      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(
                  fontSize: FontSizeManager.s16, color: ColorManager.white),
              backgroundColor: ColorManager.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12)))),
      // text theme
      textTheme: TextTheme(
          headline1: getSemiBoldStyle(
              color: ColorManager.darkGray, fontSize: FontSizeManager.s16),
          subtitle1: getMediumStyle(
              color: ColorManager.lightGray, fontSize: FontSizeManager.s14),
          caption: getRegularStyle(color: ColorManager.gray1),
          bodyText1: getRegularStyle(color: ColorManager.gray)),
      // input theme
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        hintStyle: getRegularStyle(color: ColorManager.gray1),
        labelStyle: getMediumStyle(color: ColorManager.darkGray),
        errorStyle: getRegularStyle(color: ColorManager.error),
        //disable
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.gray, width: AppSize.s1),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        //enable
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorManager.gray, width: AppSize.s1),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        //focused
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        //error
        errorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.error, width: AppSize.s1),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        //focused error
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
      ));
}
