// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:overlay_support/overlay_support.dart';

// class Notifications {
//   // for info messages
//   static void showInfo(
//     String message, {
//     String? subtitle,
//   }) {
//     _showNotification(
//       message,
//       title: 'Info',
//       color: appColors.black,
//     );
//   }

// // for error messages
//   static void showError(
//     String message, {
//     String? subtitle,
//   }) {
//     _showNotification(
//       message,
//       title: 'Error',
//       color: appColors.danger,
//     );
//   }

// // for success messages
//   static void showSuccess(
//     String message, {
//     Function()? onTap,
//     bool? barrierDismissible,
//   }) {
//     _showNotification(
//       message,
//       title: 'Success',
//       color: appColors.primary,
//       onTap: onTap,
//       barrierDismissible: barrierDismissible,
//     );
//   }

// // generic notification method
//   static void _showNotification(
//     String message, {
//     String? title,
//     required Color color,
//     Function()? onTap,
//     bool? barrierDismissible,
//   }) {
//     HapticFeedback.mediumImpact();

//     showSimpleNotification(
//       Row(
//         children: [
//           Icon(
//             Icons.error,
//             color: appColors.white,
//             size: 26,
//           ),
//           XBox(15.dx),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title ?? '',
//                   style: TextStyle(
//                     fontSize: 18.sp,
//                     color: appColors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 YBox(5.dy),
//                 Text(
//                   message,
//                   style: TextStyle(
//                     fontSize: 16.sp,
//                     color: appColors.white,
//                   ),
//                 ),
//                 YBox(10.dy),
//               ],
//             ),
//           ),
//         ],
//       ),
//       background: color,
//       duration: const Duration(seconds: 3),
//       elevation: 0,
//     );
//   }
// }
