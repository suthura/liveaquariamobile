import 'dart:developer';

import 'package:aquaria_mobile/providers/auth_provider.dart';
import 'package:aquaria_mobile/screens/auth/register_screen.dart';
import 'package:aquaria_mobile/utils/color_constants.dart';
import 'package:aquaria_mobile/utils/size_config.dart';
import 'package:aquaria_mobile/widgets/common_button.dart';
import 'package:aquaria_mobile/widgets/common_input_field.dart';
import 'package:aquaria_mobile/widgets/custom_background_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var size = SizeConfig();

  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).loadCommonData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBackGroundContainer(
      backgroundColor: kTxtWhite,
      customDecoration: BoxDecoration(),
      child: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.getPropotionateWidth(20)),
            child: Consumer<AuthProvider>(
              builder: (context, auth, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.getPropotionateHeight(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: 'logo',
                          child: Image.asset(
                            'assets/images/logo2.jpeg',
                            width: size.getPropotionateWidth(200),
                            height: size.getPropotionateWidth(200),
                          ),
                        )
                      ],
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                        // color: kTxtWhite,
                        fontSize: size.getTextSize(28),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: size.getPropotionateHeight(30),
                    ),
                    Text(
                      'Email',
                      style: TextStyle(
                        // color: kTxtWhite,
                        fontSize: size.getTextSize(16),
                      ),
                    ),
                    SizedBox(
                      height: size.getPropotionateHeight(7),
                    ),
                    CommonInputField(
                      hint: 'username@gmail.com',
                      controller: auth.getUsernameController,
                    ),
                    SizedBox(
                      height: size.getPropotionateHeight(25),
                    ),
                    Text(
                      'Password',
                      style: TextStyle(
                        // color: kTxtWhite,
                        fontSize: size.getTextSize(16),
                      ),
                    ),
                    SizedBox(
                      height: size.getPropotionateHeight(7),
                    ),
                    CommonInputField(
                      hint: 'Password',
                      controller: auth.getPasswordController,
                      obscureText: true,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: const Text('Customer'),
                            value: 'Customer',
                            groupValue: auth.getselectedRole,
                            onChanged: (value) {
                              auth.setselectedRole(value);
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: const Text('Vendor'),
                            value: 'Vendor',
                            groupValue: auth.getselectedRole,
                            onChanged: (value) {
                              auth.setselectedRole(value);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.getPropotionateHeight(5),
                    ),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Don't have an account ?   ",
                            style: TextStyle(
                              // color: Colors.white,
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text: "Sign Up",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) => const RegisterScreen(),
                                      ),
                                    );
                                  },
                                style: TextStyle(
                                  // color: Colors.white,
                                  fontSize: 12,
                                  color: Color(0xFF0199FE),
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.getPropotionateHeight(41),
                    ),
                    auth.getIsLogginIn
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CupertinoActivityIndicator(
                                color: Color(0xFF0E52A8),
                              ),
                            ],
                          )
                        : CommonButton(
                            size: size,
                            btnTxt: "Login",
                            onTap: () {
                              auth.performMainLogin(context);
                            },
                          )
                  ],
                );
              },
            )),
      ),
    );
  }
}
