import 'dart:io';

import 'package:aquaria_mobile/models/main_item_model.dart';
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

class SupplierAddRequest extends StatefulWidget {
  const SupplierAddRequest({super.key, required this.item});

  final SingleItem item;

  @override
  State<SupplierAddRequest> createState() => _SupplierAddRequestState();
}

class _SupplierAddRequestState extends State<SupplierAddRequest> {
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
              title: widget.item.commonName!,
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
                );
              },
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Consumer<ItemOrderProvider>(
                  builder: (context, itmOrd, child) {
                    return Center(
                      child: SingleChildScrollView(
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          runAlignment: WrapAlignment.spaceEvenly,
                          spacing: size.getPropotionateWidth(10),
                          runSpacing: 8.0,
                          children: [
                            for (int i = 0; i < itmOrd.getsupReqimages.length; i++)
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
                                        File(itmOrd.getsupReqimages[i].path),
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
                                        itmOrd.getsupReqimages.removeAt(i);
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
                                itmOrd.setgetsupReqimages(await picker.pickMultiImage());
                                // images = ;
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
                    );
                  },
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Row(),
                  SizedBox(
                    height: size.getPropotionateHeight(14),
                  ),
                  Row(
                    children: [
                      Text(
                        'Video',
                        style: TextStyle(
                          color: kTxtWhite,
                          fontSize: size.getTextSize(14),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.getPropotionateHeight(5),
                  ),
                  Consumer<ItemOrderProvider>(
                    builder: (context, itmOrd, child) {
                      return InkWell(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          itmOrd.setvideoFile(await picker.pickVideo(source: ImageSource.camera));
                          // videoFile = ;
                          // setState(() {});
                        },
                        child: itmOrd.getvideoFile != null
                            ? Container(
                                padding: EdgeInsets.all(5),
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
                                child: Text("Picked : ${itmOrd.getvideoFile!.name}"),
                              )
                            : Container(
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
                      );
                    },
                  ),
                ],
              ),
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
                          itmord.saveSuplierRequest(context, item: widget.item);
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
