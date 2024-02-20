import 'package:aquaria_mobile/utils/color_constants.dart';
import 'package:flutter/material.dart';

class CommonBackButton extends StatelessWidget {
  const CommonBackButton({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 66,
              width: 83,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.25),
                    Colors.white.withOpacity(0.15),
                  ],
                ),
              ),
              child: Row(
                children: [
                  Spacer(),
                  Icon(
                    Icons.arrow_back_ios,
                    color: kTxtWhite,
                  ),
                  SizedBox(
                    width: 27,
                  )
                ],
              ),
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
