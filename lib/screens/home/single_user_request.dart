import 'package:aquaria_mobile/models/advertisement_model.dart';
import 'package:aquaria_mobile/screens/home/user_add_request.dart';
import 'package:aquaria_mobile/utils/color_constants.dart';
import 'package:aquaria_mobile/utils/size_config.dart';
import 'package:aquaria_mobile/widgets/common_back_button.dart';
import 'package:aquaria_mobile/widgets/common_button.dart';
import 'package:aquaria_mobile/widgets/custom_background_container.dart';
import 'package:aquaria_mobile/widgets/video_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:popup_banner/popup_banner.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class SingleUserRequest extends StatefulWidget {
  const SingleUserRequest({super.key, required this.item});

  final SingleAvertisement item;

  @override
  State<SingleUserRequest> createState() => _SingleUserRequestState();
}

class _SingleUserRequestState extends State<SingleUserRequest> {
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
              title: widget.item.item!.commonName!,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.getPropotionateHeight(18),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0E52A8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Specifications',
                          style: TextStyle(
                            color: kTxtWhite,
                            fontSize: size.getTextSize(14),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Code:'),
                            Text('${widget.item.item!.code}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Scientific:'),
                            Text('${widget.item.item!.scientificName}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Quantity:'),
                            Text('${widget.item.quantity}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Breeding:'),
                            Text('${widget.item.breedingCapacity}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Future Collection:'),
                            Text('${widget.item.futureCollection}'),
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text('Description:'),
                        //     Text('${widget.item.description}'),
                        //   ],
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Color:'),
                            Text('${widget.item.color!.name}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Size:'),
                            Text('${widget.item.size}'),
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Container(
                        //       // width: MediaQuery.of(context).size.width * .4,
                        //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(12),
                        //         gradient: LinearGradient(
                        //           begin: Alignment.topCenter,
                        //           end: Alignment.bottomRight,
                        //           colors: [
                        //             Colors.white.withOpacity(0.25),
                        //             Colors.white.withOpacity(0.15),
                        //           ],
                        //         ),
                        //       ),
                        //       child: Text(
                        //         'Code: ${widget.item.item!.code}',
                        //         style: const TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 12,
                        //           fontWeight: FontWeight.w400,
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Container(
                        //       // width: MediaQuery.of(context).size.width * .4,
                        //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(12),
                        //         gradient: LinearGradient(
                        //           begin: Alignment.topCenter,
                        //           end: Alignment.bottomRight,
                        //           colors: [
                        //             Colors.white.withOpacity(0.25),
                        //             Colors.white.withOpacity(0.15),
                        //           ],
                        //         ),
                        //       ),
                        //       child: Text(
                        //         'Scientific: ${widget.item.item!.scientificName}',
                        //         style: const TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 12,
                        //           fontWeight: FontWeight.w400,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Divider(
                        //   color: Colors.grey,
                        // ),

                        // SizedBox(
                        //   height: size.getPropotionateHeight(10),
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Container(
                        //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(12),
                        //         gradient: LinearGradient(
                        //           begin: Alignment.topCenter,
                        //           end: Alignment.bottomRight,
                        //           colors: [
                        //             Colors.white.withOpacity(0.25),
                        //             Colors.white.withOpacity(0.15),
                        //           ],
                        //         ),
                        //       ),
                        //       child: Text(
                        //         'Quantity : ${widget.item.quantity!}',
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 12,
                        //           fontWeight: FontWeight.w400,
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Container(
                        //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(12),
                        //         gradient: LinearGradient(
                        //           begin: Alignment.topCenter,
                        //           end: Alignment.bottomRight,
                        //           colors: [
                        //             Colors.white.withOpacity(0.25),
                        //             Colors.white.withOpacity(0.15),
                        //           ],
                        //         ),
                        //       ),
                        //       child: Text(
                        //         'Breeding : ${widget.item.breedingCapacity!}',
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 12,
                        //           fontWeight: FontWeight.w400,
                        //         ),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     Container(
                        //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(12),
                        //         gradient: LinearGradient(
                        //           begin: Alignment.topCenter,
                        //           end: Alignment.bottomRight,
                        //           colors: [
                        //             Colors.white.withOpacity(0.25),
                        //             Colors.white.withOpacity(0.15),
                        //           ],
                        //         ),
                        //       ),
                        //       child: Text(
                        //         'Future : ${widget.item.futureCollection!}',
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 12,
                        //           fontWeight: FontWeight.w400,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
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
                  if (widget.item.images!.isEmpty)
                    const Text(
                      'No Images',
                      style: TextStyle(color: Colors.grey),
                    ),

                  if (widget.item.images!.isNotEmpty)
                    SizedBox(
                      height: size.getPropotionateWidth(80),
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return Container(
                            width: 10,
                          );
                        },
                        itemCount: widget.item.images!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              PopupBanner(
                                context: context,
                                fit: BoxFit.contain,
                                height: MediaQuery.of(context).size.width,
                                images: widget.item.images!,
                                dotsAlignment: Alignment.bottomCenter,
                                dotsColorActive: Colors.blue,
                                dotsColorInactive: Colors.grey.withOpacity(0.5),
                                onClick: (index) {
                                  debugPrint("CLICKED $index");
                                },
                              ).show();
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.network(
                                  widget.item.images![index],
                                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                    return const Center(child: Text('This image type is not supported'));
                                  },
                                  fit: BoxFit.cover,
                                ),
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
                  if (widget.item.videos!.isEmpty)
                    const Text(
                      'No Videos',
                      style: TextStyle(color: Colors.grey),
                    ),
                  if (widget.item.videos!.isNotEmpty)
                    SizedBox(
                      height: size.getPropotionateWidth(80),
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return Container(
                            width: 10,
                          );
                        },
                        itemCount: widget.item.videos!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => VideoPage(url: widget.item.videos![index]),
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
                                  future: getVideoThumbnail(widget.item.videos![index]),
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
                  // Text(
                  //   'Specifications',
                  //   style: TextStyle(
                  //     color: kTxtWhite,
                  //     fontSize: size.getTextSize(14),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: size.getPropotionateHeight(14),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Container(
                  //       width: size.getPropotionateWidth(92),
                  //       height: size.getPropotionateWidth(80),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(12),
                  //         gradient: LinearGradient(
                  //           begin: Alignment.topCenter,
                  //           end: Alignment.bottomRight,
                  //           colors: [
                  //             Colors.white.withOpacity(0.25),
                  //             Colors.white.withOpacity(0.15),
                  //           ],
                  //         ),
                  //       ),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         children: [
                  //           Text(
                  //             'Origin',
                  //             style: TextStyle(
                  //               color: Colors.white.withOpacity(0.800000011920929),
                  //               fontSize: 12,
                  //               fontWeight: FontWeight.w400,
                  //             ),
                  //           ),
                  //           Text(
                  //             '{widget.item.item!.origin}',
                  //             style: const TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 12,
                  //               fontWeight: FontWeight.w400,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Container(
                  //       width: size.getPropotionateWidth(92),
                  //       height: size.getPropotionateWidth(80),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(12),
                  //         gradient: LinearGradient(
                  //           begin: Alignment.topCenter,
                  //           end: Alignment.bottomRight,
                  //           colors: [
                  //             Colors.white.withOpacity(0.25),
                  //             Colors.white.withOpacity(0.15),
                  //           ],
                  //         ),
                  //       ),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         children: [
                  //           Text(
                  //             'Size',
                  //             style: TextStyle(
                  //               color: Colors.white.withOpacity(0.800000011920929),
                  //               fontSize: 12,
                  //               fontWeight: FontWeight.w400,
                  //             ),
                  //           ),
                  //           Text(
                  //             '{widget.item.item!.size}',
                  //             style: const TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 12,
                  //               fontWeight: FontWeight.w400,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Container(
                  //       width: size.getPropotionateWidth(92),
                  //       height: size.getPropotionateWidth(80),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(12),
                  //         gradient: LinearGradient(
                  //           begin: Alignment.topCenter,
                  //           end: Alignment.bottomRight,
                  //           colors: [
                  //             Colors.white.withOpacity(0.25),
                  //             Colors.white.withOpacity(0.15),
                  //           ],
                  //         ),
                  //       ),
                  //       child: Column(
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         children: [
                  //           Text(
                  //             'Color',
                  //             style: TextStyle(
                  //               color: Colors.white.withOpacity(0.800000011920929),
                  //               fontSize: 12,
                  //               fontWeight: FontWeight.w400,
                  //             ),
                  //           ),
                  //           Text(
                  //             '{widget.item.item!.color}',
                  //             style: const TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 12,
                  //               fontWeight: FontWeight.w400,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: size.getPropotionateHeight(14),
                  // ),
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
                    '${widget.item.description}',
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: size.getPropotionateHeight(14),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonButton(
                        size: size,
                        btnTxt: "Request",
                        width: size.getPropotionateWidth(200),
                        height: size.getPropotionateHeight(40),
                        bgColor: const Color(0xFFF8E328),
                        txtColor: const Color(0xFF002E57),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => UserAddRequest(item: widget.item),
                          ),
                        ),
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
