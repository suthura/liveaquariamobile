import 'package:aquaria_mobile/models/advertisement_model.dart';
import 'package:aquaria_mobile/models/orders_model.dart';
import 'package:aquaria_mobile/providers/item_order_provider.dart';
import 'package:aquaria_mobile/screens/home/user_add_request.dart';
import 'package:aquaria_mobile/utils/color_constants.dart';
import 'package:aquaria_mobile/utils/size_config.dart';
import 'package:aquaria_mobile/widgets/common_back_button.dart';
import 'package:aquaria_mobile/widgets/common_button.dart';
import 'package:aquaria_mobile/widgets/common_input_field.dart';
import 'package:aquaria_mobile/widgets/custom_background_container.dart';
import 'package:aquaria_mobile/widgets/video_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class PastSingleUserRequest extends StatefulWidget {
  const PastSingleUserRequest({
    super.key,
    required this.item,
    this.isFromMainUser = false,
  });

  final SingleOrder item;
  final bool isFromMainUser;

  @override
  State<PastSingleUserRequest> createState() => _PastSingleUserRequestState();
}

class _PastSingleUserRequestState extends State<PastSingleUserRequest> {
  List<XFile> images = [];

  Future<Widget> getVideoThumbnail(String videoUrl) async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: videoUrl,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 120,
      quality: 25,
    );

    return Image.memory(
      uint8list!,
      fit: BoxFit.cover,
    );
  }

  List<String> rejectReasons = [
    'Not in stock',
    'Insufficient information',
    'Incorrect product details',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    var size = SizeConfig();
    return CustomBackGroundContainer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            CommonBackButton(
              title: widget.item.advertisement!.item!.commonName!,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.getPropotionateHeight(18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        child: Text(
                          'Code: ${widget.item.advertisement!.item!.code}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        child: Text(
                          'Scientific: ${widget.item.advertisement!.item!.scientificName}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.getPropotionateHeight(18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
                        child: Text(
                          'Quantity : ${widget.item.quantity!}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
                        child: Text(
                          'Breeding : ${widget.item.advertisement!.breedingCapacity!}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
                        child: Text(
                          'Future : ${widget.item.advertisement!.futureCollection!}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
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
                    height: size.getPropotionateHeight(14),
                  ),
                  SizedBox(
                    height: size.getPropotionateWidth(80),
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Container(
                          width: 10,
                        );
                      },
                      itemCount: widget.item.advertisement!.images!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
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
                            child: Image.network(
                              widget.item.advertisement!.images![index],
                              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                return const Center(child: Text('This image type is not supported'));
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.getPropotionateHeight(14),
                  ),

                  ///

                  Text(
                    'Videos',
                    style: TextStyle(
                      color: kTxtWhite,
                      fontSize: size.getTextSize(14),
                    ),
                  ),
                  SizedBox(
                    height: size.getPropotionateHeight(14),
                  ),
                  if (widget.item.advertisement!.videos!.isEmpty)
                    const Text(
                      'No Videos',
                      style: TextStyle(color: Colors.grey),
                    ),
                  if (widget.item.advertisement!.videos!.isNotEmpty)
                    SizedBox(
                      height: size.getPropotionateWidth(80),
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return Container(
                            width: 10,
                          );
                        },
                        itemCount: widget.item.advertisement!.videos!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => VideoPage(url: widget.item.advertisement!.videos![index]),
                                )),
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: FutureBuilder<Widget>(
                                  future: getVideoThumbnail(widget.item.advertisement!.videos![index]),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const CupertinoActivityIndicator(
                                        color: kTxtWhite,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return snapshot.data!;
                                    }
                                  },
                                ),
                                // child: Image.network(
                                //   widget.item.images![index],
                                //   errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                //     return const Center(child: Text('This image type is not supported'));
                                //   },
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  SizedBox(
                    height: size.getPropotionateHeight(14),
                  ),
                  Text(
                    'Specifications',
                    style: TextStyle(
                      color: kTxtWhite,
                      fontSize: size.getTextSize(14),
                    ),
                  ),
                  SizedBox(
                    height: size.getPropotionateHeight(14),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Origin',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.800000011920929),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '${widget.item.advertisement!.item!.origin}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Size',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.800000011920929),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '${widget.item.advertisement!.item!.size}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Color',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.800000011920929),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '${widget.item.advertisement!.item!.color}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                    height: size.getPropotionateHeight(14),
                  ),
                  Text(
                    '${widget.item.advertisement!.description}',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: size.getPropotionateHeight(14),
                  ),
                  if (widget.isFromMainUser)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // CommonButton(
                        //   size: size,
                        //   btnTxt: "Request",
                        //   width: size.getPropotionateWidth(200),
                        //   height: size.getPropotionateHeight(40),
                        //   bgColor: const Color(0xFFF8E328),
                        //   txtColor: const Color(0xFF002E57),
                        //   onTap: () => Navigator.push(
                        //     context,
                        //     MaterialPageRoute<void>(
                        //       builder: (BuildContext context) => UserAddRequest(item: widget.item),
                        //     ),
                        //   ),
                        // ),

                        CommonButton(
                          size: size,
                          btnTxt: 'Reject',
                          width: size.getPropotionateWidth(120),
                          height: size.getPropotionateHeight(40),
                          bgColor: const Color(0xFFFF4242),
                          onTap: () {
                            Alert(
                              context: context,
                              style: AlertStyle(
                                backgroundColor: Colors.white.withOpacity(.3),
                              ),
                              content: Consumer<ItemOrderProvider>(
                                builder: (context, itmOrd, child) {
                                  itmOrd.setuserNoteController(null);
                                  if (itmOrd.getisUpdatingStatus) {
                                    return CupertinoActivityIndicator(
                                      color: kTxtWhite,
                                    );
                                  }
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      for (String reason in rejectReasons)
                                        InkWell(
                                          onTap: () {
                                            itmOrd.userNoteController.text = reason;
                                            // itmOrd.setuserNoteController(reason);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Container(
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: reason == itmOrd.getuserNoteController.text ? Colors.blue : Colors.grey,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                reason,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  // fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      const Text(
                                        'Reason/Note',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      CommonInputField(
                                        maxLines: 5,
                                        hint: 'Enter Reason/Note',
                                        controller: itmOrd.getuserNoteController,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          CommonButton(
                                            size: size,
                                            btnTxt: 'Reject',
                                            width: size.getPropotionateWidth(250),
                                            height: size.getPropotionateHeight(40),
                                            bgColor: const Color(0xFFFF4242),
                                            onTap: () => itmOrd.updateOrderrRequest(
                                              context,
                                              status: 'rejected',
                                              item: widget.item,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                },
                              ),
                              buttons: [],
                            ).show();
                          },
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        CommonButton(
                          size: size,
                          btnTxt: 'Approve',
                          width: size.getPropotionateWidth(120),
                          height: size.getPropotionateHeight(40),
                          bgColor: const Color(0xFFF8E328),
                          txtColor: const Color(0xFF002E57),
                          onTap: () {
                            Alert(
                              context: context,
                              style: AlertStyle(
                                backgroundColor: Colors.white.withOpacity(.3),
                              ),
                              content: Consumer<ItemOrderProvider>(
                                builder: (context, itmOrd, child) {
                                  itmOrd.setuserNoteController(null);

                                  if (itmOrd.getisUpdatingStatus) {
                                    return CupertinoActivityIndicator(
                                      color: kTxtWhite,
                                    );
                                  }
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Reason/Note',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      CommonInputField(
                                        maxLines: 5,
                                        hint: 'Enter Reason/Note',
                                        controller: itmOrd.getuserNoteController,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          CommonButton(
                                            size: size,
                                            btnTxt: "Approve",
                                            width: size.getPropotionateWidth(250),
                                            height: size.getPropotionateHeight(40),
                                            bgColor: const Color(0xFFF8E328),
                                            txtColor: const Color(0xFF002E57),
                                            onTap: () => itmOrd.updateOrderrRequest(
                                              context,
                                              status: 'approved',
                                              item: widget.item,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                },
                              ),
                              buttons: [],
                            ).show();
                          },
                        ),
                      ],
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
