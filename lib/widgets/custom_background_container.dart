import 'package:flutter/material.dart';

class CustomBackGroundContainer extends StatelessWidget {
  final Widget child;
  final Widget? bottomNavigationBar;
  final Decoration? customDecoration;
  final Color? backgroundColor;

  const CustomBackGroundContainer({
    super.key,
    required this.child,
    this.bottomNavigationBar,
    this.customDecoration,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: customDecoration ??
            const BoxDecoration(
              // color: Color(0xFF0E52A8),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0E52A8),
                  // Color.fromARGB(255, 14, 191, 197),
                  Color(0xFF4987DA),
                ],
              ),
              // image: DecorationImage(
              //   image: AssetImage('assets/images/background.png'),
              //   fit: BoxFit.cover,
              //   opacity: .9,
              //   alignment: Alignment.topCenter,
              // ),
            ),
        child: child,
      ),
    ));
  }
}
