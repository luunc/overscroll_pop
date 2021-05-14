// import 'package:flutter/material.dart';
// import 'package:animations/animations.dart';
// import 'package:overscroll_pop/overscroll_pop.dart';
//
// class WithAnimations extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return OpenContainer(
//
//       transitionDuration: const Duration(seconds: 6),
//       closedColor: Colors.grey,
//       closedElevation: 8.0,
//       closedShape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(32.0),
//       ),
//       closedBuilder: (_, open) => FloatingActionButton.extended(
//         elevation: 0.0,
//         onPressed: open,
//         backgroundColor: Colors.grey,
//         label: Text("With animations package"),
//       ),
//       middleColor: Colors.transparent,
//       openColor: Colors.transparent,
//       openShape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(32.0),
//       ),
//       openElevation: 0.0,
//       openBuilder: (_, __) => OverscrollPop(
//         scrollToPopOption: ScrollToPopOption.both,
//         dragToPopDirection: DragToPopDirection.horizontal,
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           appBar: AppBar(title: Text("With Animations")),
//         ),
//       ),
//     );
//   }
// }
