// // base theme
// import 'package:flutter/material.dart';

// final baseTheme = ThemeData.light();

// // base border
// final outlineInputBorderBase = OutlineInputBorder(
//   borderRadius: BorderRadius.circular(12),
//   borderSide: BorderSide(
//     color: appColors.black4F4F4F.withOpacity(.3),
//   ),
// );

// final ThemeData appTheme = baseTheme.copyWith(
//   primaryColor: appColors.primary,
//   floatingActionButtonTheme: baseTheme.floatingActionButtonTheme.copyWith(
//     foregroundColor: appColors.white,
//     backgroundColor: appColors.darkPrimary,
//   ),
//   appBarTheme: AppBarTheme(
//     backgroundColor: appColors.white,
//     elevation: 0,
//     foregroundColor: appColors.black282828,
//   ),
//   colorScheme: baseTheme.colorScheme.copyWith(
//     background: appColors.white,
//     secondary: appColors.primary,
//   ),
//   dividerColor: appColors.primary.withOpacity(.5),
//   brightness: Brightness.light,
//   buttonTheme: baseTheme.buttonTheme.copyWith(
//     height: 55,
//     minWidth: double.infinity,
//     buttonColor: appColors.primary,
//     textTheme: ButtonTextTheme.normal,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(12),
//     ),
//     disabledColor: appColors.primary.withOpacity(.3),
//   ),
//   tabBarTheme: baseTheme.tabBarTheme.copyWith(
//     dividerColor: appColors.transparent,
//     labelStyle: baseTheme.textTheme.bodySmall!.copyWith(
//       color: appColors.primary,
//       fontWeight: FontWeight.w600,
//     ),
//     unselectedLabelStyle: baseTheme.textTheme.bodySmall!.copyWith(
//       color: appColors.grey,
//     ),
//     indicatorSize: TabBarIndicatorSize.tab,
//     indicatorColor: appColors.primary,
//     labelColor: appColors.primary,
//     unselectedLabelColor: appColors.grey,
//   ),
//   inputDecorationTheme: baseTheme.inputDecorationTheme.copyWith(
//     floatingLabelBehavior: FloatingLabelBehavior.auto,
//     border: outlineInputBorderBase,
//     enabledBorder: outlineInputBorderBase,
//     focusedBorder: outlineInputBorderBase.copyWith(
//       borderSide: BorderSide(
//         color: appColors.primary,
//       ),
//     ),
//     hintStyle: TextStyle(
//       fontSize: 14,
//       color: appColors.black7A7A7A,
//       fontWeight: FontWeight.w400,
//     ),
//   ),
//   textTheme: baseTheme.copyWith().textTheme.apply(
//         fontFamily: 'Montserrat',
//         bodyColor: appColors.black282828,
//       ),
// );
