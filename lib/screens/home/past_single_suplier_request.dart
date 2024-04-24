import 'package:aquaria_mobile/models/sup_req_model.dart';
import 'package:aquaria_mobile/utils/color_constants.dart';
import 'package:aquaria_mobile/utils/size_config.dart';
import 'package:aquaria_mobile/widgets/common_back_button.dart';
import 'package:aquaria_mobile/widgets/custom_background_container.dart';
import 'package:aquaria_mobile/widgets/video_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class PastSingleSupplierRequest extends StatefulWidget {
  const PastSingleSupplierRequest({super.key, required this.item});

  final SingleSupplierRequestModel item;

  @override
  State<PastSingleSupplierRequest> createState() => _PastSingleSupplierRequestState();
}

class _PastSingleSupplierRequestState extends State<PastSingleSupplierRequest> {
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
            SizedBox(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      getStatusCard(widget.item.status!),
                    ],
                  ),
                  SizedBox(
                    height: size.getPropotionateHeight(18),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xFF0E52A8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Item Specifications',
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
                            const Text('Common Name:'),
                            Text('${widget.item.item!.commonName}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Scientific Name:'),
                            Text('${widget.item.item!.scientificName}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Description:'),
                            Text('${widget.item.item!.description ?? "n/a"}'),
                          ],
                        ),
                        Text(
                          'Request Specifications',
                          style: TextStyle(
                            color: kTxtWhite,
                            fontSize: size.getTextSize(14),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Breeding Capacity:'),
                            Text('${widget.item.breedingCapacity}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Description:'),
                            Text('${widget.item.description}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Future Collection:'),
                            Text('${widget.item.futureCollection}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Quantity:'),
                            Text('${widget.item.quantity}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Container(
                  //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       ),
                  //     ),
                  //     Container(
                  //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
                                widget.item.images![index],
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
                  if (widget.item.videos!.isEmpty)
                    Text(
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
                                      return CupertinoActivityIndicator(
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
                  //             '${widget.item.item!.origin}',
                  //             style: TextStyle(
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
                  //             '${widget.item.item!.size}',
                  //             style: TextStyle(
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
                  //             '${widget.item.item!.color}',
                  //             style: TextStyle(
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
                    '${widget.item.description}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: size.getPropotionateHeight(14),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     CommonButton(
                  //       size: size,
                  //       btnTxt: "Request",
                  //       width: size.getPropotionateWidth(200),
                  //       height: size.getPropotionateHeight(40),
                  //       bgColor: Color(0xFFF8E328),
                  //       txtColor: Color(0xFF002E57),
                  //       onTap: () => Navigator.push(
                  //         context,
                  //         MaterialPageRoute<void>(
                  //           builder: (BuildContext context) => SupplierAddRequest(item: widget.item),
                  //         ),
                  //       ),
                  //     ),
                  //     // CommonButton(
                  //     //   size: size,
                  //     //   btnTxt: 'Reject',
                  //     //   width: size.getPropotionateWidth(120),
                  //     //   height: size.getPropotionateHeight(40),
                  //     //   bgColor: Color(0xFFFF4242),
                  //     //   onTap: () {
                  //     //     Alert(
                  //     //       context: context,
                  //     //       style: AlertStyle(
                  //     //         backgroundColor: Colors.white.withOpacity(.3),
                  //     //       ),
                  //     //       content: Column(
                  //     //         crossAxisAlignment: CrossAxisAlignment.start,
                  //     //         children: [
                  //     //           Text(
                  //     //             'Reason/Note',
                  //     //             style: TextStyle(
                  //     //               color: Colors.white,
                  //     //               fontSize: 16,
                  //     //
                  //     //               fontWeight: FontWeight.w600,
                  //     //             ),
                  //     //           ),
                  //     //           SizedBox(
                  //     //             height: 8,
                  //     //           ),
                  //     //           CommonInputField(
                  //     //             maxLines: 5,
                  //     //             hint: 'Enter Reason/Note',
                  //     //           ),
                  //     //           SizedBox(
                  //     //             height: 8,
                  //     //           ),
                  //     //           Row(
                  //     //             mainAxisAlignment: MainAxisAlignment.end,
                  //     //             children: [
                  //     //               CommonButton(
                  //     //                 size: size,
                  //     //                 btnTxt: 'Reject',
                  //     //                 width: size.getPropotionateWidth(250),
                  //     //                 height: size.getPropotionateHeight(40),
                  //     //                 bgColor: Color(0xFFFF4242),
                  //     //               ),
                  //     //             ],
                  //     //           )
                  //     //         ],
                  //     //       ),
                  //     //       buttons: [],
                  //     //     ).show();
                  //     //   },
                  //     // ),
                  //     // SizedBox(
                  //     //   width: 14,
                  //     // ),
                  //     // CommonButton(
                  //     //   size: size,
                  //     //   btnTxt: 'Approve',
                  //     //   width: size.getPropotionateWidth(120),
                  //     //   height: size.getPropotionateHeight(40),
                  //     //   bgColor: Color(0xFFF8E328),
                  //     //   txtColor: Color(0xFF002E57),
                  //     //   onTap: () {
                  //     //     Alert(
                  //     //       context: context,
                  //     //       style: AlertStyle(
                  //     //         backgroundColor: Colors.white.withOpacity(.3),
                  //     //       ),
                  //     //       content: Column(
                  //     //         crossAxisAlignment: CrossAxisAlignment.start,
                  //     //         children: [
                  //     //           Text(
                  //     //             'Reason/Note',
                  //     //             style: TextStyle(
                  //     //               color: Colors.white,
                  //     //               fontSize: 16,
                  //     //
                  //     //               fontWeight: FontWeight.w600,
                  //     //             ),
                  //     //           ),
                  //     //           SizedBox(
                  //     //             height: 8,
                  //     //           ),
                  //     //           CommonInputField(
                  //     //             maxLines: 5,
                  //     //             hint: 'Enter Reason/Note',
                  //     //           ),
                  //     //           SizedBox(
                  //     //             height: 8,
                  //     //           ),
                  //     //           Row(
                  //     //             mainAxisAlignment: MainAxisAlignment.end,
                  //     //             children: [
                  //     //               CommonButton(
                  //     //                 size: size,
                  //     //                 btnTxt: "Approve",
                  //     //                 width: size.getPropotionateWidth(250),
                  //     //                 height: size.getPropotionateHeight(40),
                  //     //                 bgColor: Color(0xFFF8E328),
                  //     //                 txtColor: Color(0xFF002E57),
                  //     //               ),
                  //     //             ],
                  //     //           )
                  //     //         ],
                  //     //       ),
                  //     //       buttons: [],
                  //     //     ).show();
                  //     //   },
                  //     // ),
                  //   ],
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget getStatusCard(String status) {
  Color statusColor;
  String statusText;

  switch (status.toLowerCase()) {
    case 'approved':
      statusColor = Colors.green;
      statusText = 'Approved';
      break;
    case 'rejected':
      statusColor = Colors.red;
      statusText = 'Rejected';
      break;
    case 'pending':
      statusColor = Colors.orange;
      statusText = 'Pending';
      break;
    case 'published':
      statusColor = Colors.blue;
      statusText = 'Published';
      break;
    default:
      statusColor = Colors.grey;
      statusText = 'Unknown';
      break;
  }

  return Card(
    color: statusColor,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        statusText,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
