import 'package:aquaria_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';

class CommonInputField extends StatelessWidget {
  const CommonInputField({
    super.key,
    this.hint,
    this.maxLines,
    this.controller,
    this.obscureText = false,
    this.validate = false,
  });
  final String? hint;
  final int? maxLines;
  final TextEditingController? controller;
  final bool obscureText;
  final bool validate;

  @override
  Widget build(BuildContext context) {
    var size = SizeConfig();
    return SizedBox(
      height: maxLines != null
          ? null
          : validate
              ? null
              : size.getPropotionateHeight(60),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (validate) {
            if (value == null || value.isEmpty) {
              return '$hint Required';
            }
            return null;
          } else {
            return null;
          }
        },
        style: TextStyle(
          fontSize: 12,
        ),
        maxLines: obscureText ? 1 : maxLines,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: Color(0xFFBCBEC0),
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
