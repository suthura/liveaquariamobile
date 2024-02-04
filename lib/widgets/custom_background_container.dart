import 'package:flutter/material.dart';

class CustomBackGroundContainer extends StatelessWidget {
  final Widget child;
  final Widget? bottomNavigationBar;

  const CustomBackGroundContainer({
    super.key,
    required this.child,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
            opacity: .9,
            alignment: Alignment.topCenter,
          ),
        ),
        child: child,
      ),
    ));
  }
}
