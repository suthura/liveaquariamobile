import 'dart:developer';
import 'dart:io';

import 'package:aquaria_mobile/providers/auth_provider.dart';
import 'package:aquaria_mobile/utils/color_constants.dart';
import 'package:aquaria_mobile/utils/size_config.dart';
import 'package:aquaria_mobile/widgets/common_back_button.dart';
import 'package:aquaria_mobile/widgets/common_button.dart';
import 'package:aquaria_mobile/widgets/common_input_field.dart';
import 'package:aquaria_mobile/widgets/custom_background_container.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = SizeConfig();
    return CustomBackGroundContainer(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Consumer<AuthProvider>(
              builder: (context, auth, child) {
                return Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    CommonBackButton(
                      title: "Add User",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.getPropotionateHeight(18),
                          ),
                          Text(
                            'Name',
                            style: TextStyle(
                              color: kTxtWhite,
                              fontSize: size.getTextSize(14),
                            ),
                          ),
                          SizedBox(
                            height: size.getPropotionateHeight(5),
                          ),
                          CommonInputField(
                            validate: true,
                            hint: 'Name',
                            controller: auth.getNameController,
                          ),
                          SizedBox(
                            height: size.getPropotionateHeight(14),
                          ),
                          Text(
                            'Email',
                            style: TextStyle(
                              color: kTxtWhite,
                              fontSize: size.getTextSize(14),
                            ),
                          ),
                          SizedBox(
                            height: size.getPropotionateHeight(5),
                          ),
                          CommonInputField(
                            validate: true,
                            hint: 'Email',
                            controller: auth.getEmailController,
                          ),
                          SizedBox(
                            height: size.getPropotionateHeight(14),
                          ),
                          Text(
                            'Phone',
                            style: TextStyle(
                              color: kTxtWhite,
                              fontSize: size.getTextSize(14),
                            ),
                          ),
                          SizedBox(
                            height: size.getPropotionateHeight(5),
                          ),
                          CommonInputField(
                            validate: true,
                            hint: 'Phone',
                            controller: auth.getPhoneController,
                          ),
                          SizedBox(
                            height: size.getPropotionateHeight(14),
                          ),
                          Text(
                            'Password',
                            style: TextStyle(
                              color: kTxtWhite,
                              fontSize: size.getTextSize(14),
                            ),
                          ),
                          SizedBox(
                            height: size.getPropotionateHeight(5),
                          ),
                          CommonInputField(
                            validate: true,
                            hint: 'Password',
                            obscureText: true,
                            controller: auth.getPasswordController,
                          ),
                          SizedBox(
                            height: size.getPropotionateHeight(14),
                          ),
                          Text(
                            'Image',
                            style: TextStyle(
                              color: kTxtWhite,
                              fontSize: size.getTextSize(14),
                            ),
                          ),
                          SizedBox(
                            height: size.getPropotionateHeight(5),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        // alignment: WrapAlignment.start,
                        // crossAxisAlignment: WrapCrossAlignment.start,
                        // runAlignment: WrapAlignment.start,
                        // spacing: size.getPropotionateWidth(10),
                        // runSpacing: 8.0,
                        children: [
                          if (auth.getuserimage != null)
                            Stack(
                              children: [
                                Container(
                                  width: size.getPropotionateWidth(92),
                                  height: size.getPropotionateWidth(80),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.white.withOpacity(0.25),
                                        Colors.white.withOpacity(0.15),
                                      ],
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.file(
                                      File(auth.getuserimage!.path),
                                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                        return const Center(child: Text('This image type is not supported'));
                                      },
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        auth.setimage(null);
                                      });
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kTxtWhite,
                                      ),
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          if (auth.getuserimage == null)
                            InkWell(
                              onTap: () async {
                                final ImagePicker picker = ImagePicker();
                                var image = await picker.pickImage(
                                  source: ImageSource.gallery,
                                );
                                log(image!.path);
                                auth.setimage(image);
                                // setState(() {});
                              },
                              child: Container(
                                width: size.getPropotionateWidth(92),
                                height: size.getPropotionateWidth(80),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.white.withOpacity(0.25),
                                      Colors.white.withOpacity(0.15),
                                    ],
                                  ),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: kTxtWhite,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.getPropotionateHeight(18),
                          ),
                          CommonButton(
                            size: size,
                            btnTxt: "Add",
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                auth.createSubUser(context);
                              }
                            },
                          ),
                          SizedBox(
                            height: size.getPropotionateHeight(18),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
