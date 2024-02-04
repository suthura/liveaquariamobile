import 'dart:io';

import 'package:aquaria_mobile/models/advertisement_model.dart';
import 'package:aquaria_mobile/providers/item_order_provider.dart';
import 'package:aquaria_mobile/utils/color_constants.dart';
import 'package:aquaria_mobile/utils/size_config.dart';
import 'package:aquaria_mobile/widgets/common_back_button.dart';
import 'package:aquaria_mobile/widgets/common_button.dart';
import 'package:aquaria_mobile/widgets/common_input_field.dart';
import 'package:aquaria_mobile/widgets/custom_background_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserAddRequest extends StatefulWidget {
  const UserAddRequest({super.key, required this.item});

  final SingleAvertisement item;

  @override
  State<UserAddRequest> createState() => _UserAddRequestState();
}

class _UserAddRequestState extends State<UserAddRequest> {
  @override
  Widget build(BuildContext context) {
    var size = SizeConfig();
    return CustomBackGroundContainer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            CommonBackButton(
              title: widget.item.item!.commonName!,
            ),
            Consumer<ItemOrderProvider>(
              builder: (context, itmOrder, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.getPropotionateHeight(18),
                      ),
                      Text(
                        'Quantity',
                        style: TextStyle(
                          color: kTxtWhite,
                          fontSize: size.getTextSize(14),
                        ),
                      ),
                      SizedBox(
                        height: size.getPropotionateHeight(5),
                      ),
                      CommonInputField(
                        hint: 'Quantity',
                        controller: itmOrder.getQuantityController,
                      ),
                      SizedBox(
                        height: size.getPropotionateHeight(14),
                      ),
                      Text(
                        'Breeding Capacity',
                        style: TextStyle(
                          color: kTxtWhite,
                          fontSize: size.getTextSize(14),
                        ),
                      ),
                      SizedBox(
                        height: size.getPropotionateHeight(5),
                      ),
                      CommonInputField(
                        hint: 'Breeding Capacity',
                        controller: itmOrder.getBreedingCapacityController,
                      ),
                      SizedBox(
                        height: size.getPropotionateHeight(14),
                      ),
                      Text(
                        'Future Collection',
                        style: TextStyle(
                          color: kTxtWhite,
                          fontSize: size.getTextSize(14),
                        ),
                      ),
                      SizedBox(
                        height: size.getPropotionateHeight(5),
                      ),
                      CommonInputField(
                        hint: 'Future Collection',
                        controller: itmOrder.getFutureCollectionController,
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
                        controller: itmOrder.getDescriptionController,
                      ),
                      SizedBox(
                        height: size.getPropotionateHeight(14),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: size.getPropotionateHeight(5),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: size.getPropotionateHeight(18),
                  ),
                  Consumer<ItemOrderProvider>(
                    builder: (context, itmord, child) {
                      if (itmord.getisSavingRequest) {
                        return CupertinoActivityIndicator(
                          color: kTxtWhite,
                        );
                      }
                      return CommonButton(
                        size: size,
                        btnTxt: "Send Request",
                        onTap: () {
                          // itmord.saveSuplierRequest(context, item: widget.item);
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: size.getPropotionateHeight(18),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
