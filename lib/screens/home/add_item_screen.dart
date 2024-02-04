import 'dart:io';

import 'package:aquaria_mobile/utils/color_constants.dart';
import 'package:aquaria_mobile/utils/size_config.dart';
import 'package:aquaria_mobile/widgets/common_back_button.dart';
import 'package:aquaria_mobile/widgets/common_button.dart';
import 'package:aquaria_mobile/widgets/common_input_field.dart';
import 'package:aquaria_mobile/widgets/custom_background_container.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  List<XFile> images = [];

  @override
  Widget build(BuildContext context) {
    var size = SizeConfig();
    return CustomBackGroundContainer(
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          CommonBackButton(
            title: "Add Item",
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
                  'Item Name',
                  style: TextStyle(
                    color: kTxtWhite,
                    fontSize: size.getTextSize(14),
                  ),
                ),
                SizedBox(
                  height: size.getPropotionateHeight(5),
                ),
                CommonInputField(
                  hint: 'Item Name',
                ),
                SizedBox(
                  height: size.getPropotionateHeight(14),
                ),
                Text(
                  'Item Number',
                  style: TextStyle(
                    color: kTxtWhite,
                    fontSize: size.getTextSize(14),
                  ),
                ),
                SizedBox(
                  height: size.getPropotionateHeight(5),
                ),
                CommonInputField(
                  hint: 'Item Number',
                ),
                SizedBox(
                  height: size.getPropotionateHeight(14),
                ),
                Text(
                  'Description',
                  style: TextStyle(
                    color: kTxtWhite,
                    fontSize: size.getTextSize(14),
                  ),
                ),
                SizedBox(
                  height: size.getPropotionateHeight(5),
                ),
                CommonInputField(
                  hint: 'Description',
                ),
                SizedBox(
                  height: size.getPropotionateHeight(14),
                ),
                Text(
                  'Images',
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runAlignment: WrapAlignment.spaceEvenly,
                    spacing: size.getPropotionateWidth(10),
                    runSpacing: 8.0,
                    children: [
                      for (int i = 0; i < images.length; i++)
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
                                  File(images[i].path),
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
                                  images.removeAt(i);
                                  setState(() {});
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
                      InkWell(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          images = await picker.pickMultiImage();
                          setState(() {});
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
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: size.getPropotionateHeight(18),
                ),
                CommonButton(size: size, btnTxt: "Add"),
                SizedBox(
                  height: size.getPropotionateHeight(18),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
