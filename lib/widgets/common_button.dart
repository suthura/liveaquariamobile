import 'package:aquaria_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.size,
    required this.btnTxt,
    this.width,
    this.onTap,
    this.bgColor,
    this.txtColor,
    this.height,
  });

  final SizeConfig size;
  final String btnTxt;
  final void Function()? onTap;
  final double? width;
  final Color? bgColor;
  final Color? txtColor;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? size.getPropotionateHeight(50),
        // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: bgColor ?? Color(0xFF0199FE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              btnTxt,
              style: TextStyle(
                color: txtColor ?? Colors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
