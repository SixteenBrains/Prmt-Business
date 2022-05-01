// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:prmt_admin/constants/constants.dart';

// import 'stats_chart.dart';

// class UserSection extends StatefulWidget {
//   const UserSection({Key? key}) : super(key: key);

//   @override
//   State<UserSection> createState() => _UserSectionState();
// }

// class _UserSectionState extends State<UserSection> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: secondaryColor,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(defaultPadding * 0.75),
//                 height: 40,
//                 width: 40,
//                 decoration: BoxDecoration(
//                   color: Colors.yellow.withOpacity(0.1),
//                   borderRadius: const BorderRadius.all(Radius.circular(10)),
//                 ),
//                 child: SvgPicture.asset(
//                   'assets/icons/folder.svg',
//                   color: Colors.yellow,
//                 ),
//               ),
//               const SizedBox(width: 10.0),
//               const Text(
//                 'Total Ads Posted',
//                 style: TextStyle(
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.w600,
//                   letterSpacing: 1.2,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 25.0),
//           // const Text(
//           //   '350',
//           //   style: TextStyle(
//           //     fontSize: 32.0,
//           //     fontWeight: FontWeight.w700,
//           //     color: Colors.white,
//           //     letterSpacing: 1.2,
//           //   ),
//           // ),
//            StatsChart(value: 200),
//         ],
//       ),
//     );
//   }
// }
