// import 'dart:async';
// import 'package:animations/animations.dart';
// import 'package:flutter/material.dart';

// class MyCustomWidget extends StatefulWidget {
//   const MyCustomWidget({super.key});

//   @override
//   State<MyCustomWidget> createState() => _MyCustomWidgetState();
// }

// class _MyCustomWidgetState extends State<MyCustomWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             const Text(
//               'Suppose this is an app in your Phone\'s Screen page.',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 17,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             OpenContainer(
//               closedBuilder: (_, openContainer) {
//                 return const SizedBox(
//                   height: 80,
//                   width: 80,
//                   child: Center(
//                     child: Text(
//                       'App Logo',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               openColor: Colors.white,
//               closedElevation: 20,
//               closedShape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20)),
//               transitionDuration: const Duration(milliseconds: 700),
//               openBuilder: (_, closeContainer) {
//                 return const SecondClass();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SecondClass extends StatefulWidget {
//   const SecondClass({super.key});

//   @override
//   State<SecondClass> createState() => _SecondClassState();
// }

// class _SecondClassState extends State<SecondClass>
//     with TickerProviderStateMixin {
//   late AnimationController scaleController;
//   late Animation<double> scaleAnimation;

//   double _opacity = 0;
//   bool _value = true;

//   @override
//   void initState() {
//     super.initState();

//     scaleController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     )..addStatusListener(
//         (status) {
//           if (status == AnimationStatus.completed) {
//             Navigator.of(context).pushReplacement(
//               ThisIsFadeRoute(
//                 route: const ThirdPage(),
//               ),
//             );
//             Timer(
//               const Duration(milliseconds: 300),
//               () {
//                 scaleController.reset();
//               },
//             );
//           }
//         },
//       );

//     scaleAnimation =
//         Tween<double>(begin: 0.0, end: 12).animate(scaleController);

//     Timer(const Duration(milliseconds: 600), () {
//       setState(() {
//         _opacity = 1.0;
//         _value = false;
//       });
//     });
//     Timer(const Duration(milliseconds: 2000), () {
//       setState(() {
//         scaleController.forward();
//       });
//     });
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     scaleController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           const Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(top: 80),
//                 child: Text(
//                   'Here will be your app\'s logo',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Center(
//             child: AnimatedOpacity(
//               curve: Curves.fastLinearToSlowEaseIn,
//               duration: const Duration(seconds: 6),
//               opacity: _opacity,
//               child: AnimatedContainer(
//                 curve: Curves.fastLinearToSlowEaseIn,
//                 duration: const Duration(seconds: 2),
//                 height: _value ? 50 : 200,
//                 width: _value ? 50 : 200,
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.deepPurpleAccent.withOpacity(.2),
//                       blurRadius: 100,
//                       spreadRadius: 10,
//                     ),
//                   ],
//                   color: Colors.deepPurpleAccent,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Center(
//                   child: Container(
//                     width: 100,
//                     height: 100,
//                     decoration: const BoxDecoration(
//                         color: Colors.deepPurpleAccent, shape: BoxShape.circle),
//                     child: AnimatedBuilder(
//                       animation: scaleAnimation,
//                       builder: (c, child) => Transform.scale(
//                         scale: scaleAnimation.value,
//                         child: Container(
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.deepPurpleAccent,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ThisIsFadeRoute extends PageRouteBuilder {
//   final Widget page;
//   final Widget route;

//   ThisIsFadeRoute({required this.page, required this.route})
//       : super(
//           pageBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//           ) =>
//               page,
//           transitionsBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//             Widget child,
//           ) =>
//               FadeTransition(
//             opacity: animation,
//             child: route,
//           ),
//         );
// }

// class ThirdPage extends StatelessWidget {
//   const ThirdPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Go Back'),
//         centerTitle: true,
//         backgroundColor: Colors.deepPurpleAccent,
//       ),
//     );
//   }
// }