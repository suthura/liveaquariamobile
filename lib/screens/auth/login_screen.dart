import 'package:aquaria_mobile/providers/auth_provider.dart';
import 'package:aquaria_mobile/utils/color_constants.dart';
import 'package:aquaria_mobile/utils/size_config.dart';
import 'package:aquaria_mobile/widgets/common_button.dart';
import 'package:aquaria_mobile/widgets/common_input_field.dart';
import 'package:aquaria_mobile/widgets/custom_background_container.dart';
import 'package:flutter/cupertino.dart';
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
  Widget build(BuildContext context) {
    return CustomBackGroundContainer(
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
                        Image.asset(
                          'assets/images/logo.png',
                          width: size.getPropotionateWidth(200),
                          height: size.getPropotionateWidth(200),
                        )
                      ],
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                        color: kTxtWhite,
                        fontSize: size.getTextSize(28),
                      ),
                    ),
                    SizedBox(
                      height: size.getPropotionateHeight(23),
                    ),
                    Text(
                      'Email',
                      style: TextStyle(
                        color: kTxtWhite,
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
                      height: size.getPropotionateHeight(30),
                    ),
                    Text(
                      'Password',
                      style: TextStyle(
                        color: kTxtWhite,
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
                    SizedBox(
                      height: size.getPropotionateHeight(17),
                    ),
                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(
                      height: size.getPropotionateHeight(41),
                    ),
                    auth.getIsLogginIn
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CupertinoActivityIndicator(
                                color: kTxtWhite,
                              ),
                            ],
                          )
                        : CommonButton(
                            size: size,
                            btnTxt: "Login",
                            onTap: () {
                              auth.performMainLogin(context);
                              //   Navigator.push(
                              //   context,
                              //   MaterialPageRoute<void>(
                              //     builder: (BuildContext context) => const HomeScreen(),
                              //   ),
                              // )
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
