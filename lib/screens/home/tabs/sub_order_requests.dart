import 'package:aquaria_mobile/models/orders_model.dart';
import 'package:aquaria_mobile/providers/item_order_provider.dart';
import 'package:aquaria_mobile/screens/home/past_single_user_reques.dart';
import 'package:aquaria_mobile/utils/color_constants.dart';
import 'package:aquaria_mobile/utils/size_config.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubOrderRequestsTab extends StatefulWidget {
  const SubOrderRequestsTab({
    super.key,
    this.isSubUser = false,
  });
  final bool isSubUser;

  @override
  State<SubOrderRequestsTab> createState() => _SubOrderRequestsTabState();
}

class _SubOrderRequestsTabState extends State<SubOrderRequestsTab> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ItemOrderProvider>(context, listen: false).loadOrders(context, isSubUser: widget.isSubUser);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = SizeConfig();
    return DefaultTabController(
      length: 3,
      child: Consumer<ItemOrderProvider>(
        builder: (context, itmOrder, child) {
          if (itmOrder.getisLoadingOrders) {
            return CupertinoActivityIndicator(
              color: kTxtWhite,
            );
          }
          return Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                "User Requests",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              // TabBar(
              //   isScrollable: true,
              //   tabs: [
              //     Tab(text: 'Pending(${itmOrder.getSepeateOrderMainUser(approval: 'pending').length})'),
              //     Tab(text: 'Approved'),
              //     Tab(text: 'Rejected'),
              //   ],
              // ),
              // Expanded(child: Container())
              itmOrder.getSepeateOrderMainUser(approval: '').isEmpty
                  ? Padding(
                      padding: EdgeInsets.only(top: 70),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .75,
                        child: EmptyWidget(
                          image: null,
                          packageImage: PackageImage.Image_3,
                          title: 'No Requests',
                          // subTitle: 'Try Changing Filters',
                          titleTextStyle: TextStyle(
                            fontSize: 22,
                            color: Color(0xff9da9c7),
                            fontWeight: FontWeight.w500,
                          ),
                          subtitleTextStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xffabb8d6),
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: ListView.separated(
                          itemCount: itmOrder.getSepeateOrderMainUser(approval: '').length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 14,
                            );
                          },
                          itemBuilder: (context, index) {
                            return SupplierRequestCard(
                              size: size,
                              order: itmOrder.getSepeateOrderMainUser(approval: '')[index],
                              // onTap: () => Navigator.push(
                              //   context,
                              //   MaterialPageRoute<void>(
                              //     builder: (BuildContext context) => const SingleSupplierRequest(),
                              //   ),
                              // ),
                            );
                          },
                        ),
                      ),
                      // child: TabBarView(
                      //   children: [
                      // Content of Tab 1
                      // Container(
                      //   padding: const EdgeInsets.all(20),
                      //   child: ListView.separated(
                      //     itemCount: itmOrder.getSepeateOrderMainUser(approval: 'pending').length,
                      //     separatorBuilder: (context, index) {
                      //       return const SizedBox(
                      //         height: 14,
                      //       );
                      //     },
                      //     itemBuilder: (context, index) {
                      //       return SupplierRequestCard(
                      //         size: size,
                      //         order: itmOrder.getSepeateOrderMainUser(approval: 'pending')[index],
                      //         showButtons: true,
                      //       );
                      //     },
                      //   ),
                      // ),
                      // Content of Tab 2
                      // Container(
                      //   padding: const EdgeInsets.all(20),
                      //   child: ListView.separated(
                      //     itemCount: itmOrder.getSepeateOrderMainUser(approval: 'approved').length,
                      //     separatorBuilder: (context, index) {
                      //       return const SizedBox(
                      //         height: 14,
                      //       );
                      //     },
                      //     itemBuilder: (context, index) {
                      //       return SupplierRequestCard(
                      //         size: size,
                      //         order: itmOrder.getSepeateOrderMainUser(approval: 'approved')[index],
                      //         // onTap: () => Navigator.push(
                      //         //   context,
                      //         //   MaterialPageRoute<void>(
                      //         //     builder: (BuildContext context) => const SingleSupplierRequest(),
                      //         //   ),
                      //         // ),
                      //       );
                      //     },
                      //   ),
                      // ),
                      // Content of Tab 3
                      // Container(
                      //   padding: const EdgeInsets.all(20),
                      //   child: ListView.separated(
                      //     itemCount: itmOrder.getSepeateOrderMainUser(approval: 'rejected').length,
                      //     separatorBuilder: (context, index) {
                      //       return const SizedBox(
                      //         height: 14,
                      //       );
                      //     },
                      //     itemBuilder: (context, index) {
                      //       return SupplierRequestCard(
                      //         size: size,
                      //         order: itmOrder.getSepeateOrderMainUser(approval: 'rejected')[index],
                      //         // onTap: () => Navigator.push(
                      //         //   context,
                      //         //   MaterialPageRoute<void>(
                      //         //     builder: (BuildContext context) => const SingleSupplierRequest(),
                      //         //   ),
                      //         // ),
                      //       );
                      //     },
                      //   ),
                      // ),
                      //   ],
                      // ),
                    )
            ],
          );
        },
      ),
    );
  }
}

// class SupplierRequestCard extends StatelessWidget {
//   const SupplierRequestCard({
//     super.key,
//     required this.size,
//     this.showButtons = false,
//     this.onTap,
//     required this.order,
//   });

//   final SizeConfig size;
//   final void Function()? onTap;
//   final bool showButtons;
//   final SingleOrder order;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute<void>(
//             builder: (BuildContext context) => PastSingleUserRequest(item: order, isFromMainUser: true),
//           ),
//         );
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: size.getPropotionateWidth(20),
//           vertical: size.getPropotionateHeight(15),
//         ),
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: const Color(0xFF024F7D).withOpacity(.29),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(
//             color: const Color.fromARGB(2, 78, 145, 176).withOpacity(1),
//             width: 3,
//           ),
//         ),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Text.rich(
//                   TextSpan(
//                     children: [
//                       TextSpan(
//                         text: '${order.advertisement!.item!.commonName!}\n',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 17,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       TextSpan(
//                         text: 'Item ID: ${order.advertisement!.item!.code!}',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 10,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Spacer(),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomRight,
//                       colors: [
//                         Colors.white.withOpacity(0.25),
//                         Colors.white.withOpacity(0.15),
//                       ],
//                     ),
//                   ),
//                   child: Text(
//                     'Quantity: ${order.quantity}',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             Row(
//               children: [
//                 Text(
//                   'Note :${order.note ?? ""}',
//                   style: TextStyle(color: kTxtWhite),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             // Row(
//             //   children: [
//             //     Container(
//             //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
//             //       decoration: BoxDecoration(
//             //         borderRadius: BorderRadius.circular(12),
//             //         gradient: LinearGradient(
//             //           begin: Alignment.topCenter,
//             //           end: Alignment.bottomRight,
//             //           colors: [
//             //             Colors.white.withOpacity(0.25),
//             //             Colors.white.withOpacity(0.15),
//             //           ],
//             //         ),
//             //       ),
//             //       child: Text(
//             //         '${order.}',
//             //         style: TextStyle(
//             //           color: Colors.white,
//             //           fontSize: 12,
//             //
//             //           fontWeight: FontWeight.w400,
//             //         ),
//             //       ),
//             //     ),
//             //   ],
//             // ),
//             // const SizedBox(
//             //   height: 10,
//             // ),
//             // Text(
//             //   'PayFishKart delivers your favorite marine species at .......',
//             //   textAlign: TextAlign.justify,
//             //   style: TextStyle(
//             //     color: Colors.white.withOpacity(0.699999988079071),
//             //     fontSize: 14,
//             //
//             //     fontWeight: FontWeight.w400,
//             //     letterSpacing: 0.14,
//             //   ),
//             // ),
//             // const SizedBox(
//             //   height: 10,
//             // ),
//             // if (showButtons)
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.end,
//             //   children: [
//             //     CommonButton(
//             //       size: size,
//             //       btnTxt: "Reject",
//             //       width: size.getPropotionateWidth(120),
//             //       height: size.getPropotionateHeight(40),
//             //       bgColor: Color(0xFFFF4242),
//             //     ),
//             //     SizedBox(
//             //       width: 10,
//             //     ),
//             //     CommonButton(
//             //       size: size,
//             //       btnTxt: "Publish",
//             //       width: size.getPropotionateWidth(120),
//             //       height: size.getPropotionateHeight(40),
//             //       bgColor: Color(0xFFF8E328),
//             //       txtColor: Color(0xFF002E57),
//             //     )
//             //   ],
//             // )
//           ],
//         ),
//       ),
//     );
//   }
// }

class SupplierRequestCard extends StatelessWidget {
  const SupplierRequestCard({
    super.key,
    required this.size,
    this.showButtons = false,
    this.onTap,
    required this.order,
  });

  final SizeConfig size;
  final void Function()? onTap;
  final bool showButtons;
  final SingleOrder order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => PastSingleUserRequest(item: order, isFromMainUser: true),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF024F7D).withOpacity(.29),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color.fromARGB(2, 78, 145, 176).withOpacity(1),
            width: 3,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.getPropotionateWidth(20),
                vertical: size.getPropotionateHeight(15),
              ),
              child: Row(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${order.advertisement!.item!.commonName!}\n',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: 'Item ID: ${order.advertisement!.item!.code!}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
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
                      'Quantity: ${order.quantity}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                // color: Colors.white,
                color: const Color.fromARGB(2, 78, 145, 176).withOpacity(1),

                borderRadius: BorderRadius.circular(45),
                // border: Border.all(
                // color: const Color.fromARGB(2, 78, 145, 176).withOpacity(1),
                // width: 3,
                // ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    order.status!.replaceAll("_", " "),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            // Row(
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
            //         '${order.}',
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 12,
            //
            //           fontWeight: FontWeight.w400,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // Text(
            //   'PayFishKart delivers your favorite marine species at .......',
            //   textAlign: TextAlign.justify,
            //   style: TextStyle(
            //     color: Colors.white.withOpacity(0.699999988079071),
            //     fontSize: 14,
            //
            //     fontWeight: FontWeight.w400,
            //     letterSpacing: 0.14,
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // if (showButtons)
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     CommonButton(
            //       size: size,
            //       btnTxt: "Reject",
            //       width: size.getPropotionateWidth(120),
            //       height: size.getPropotionateHeight(40),
            //       bgColor: Color(0xFFFF4242),
            //     ),
            //     SizedBox(
            //       width: 10,
            //     ),
            //     CommonButton(
            //       size: size,
            //       btnTxt: "Publish",
            //       width: size.getPropotionateWidth(120),
            //       height: size.getPropotionateHeight(40),
            //       bgColor: Color(0xFFF8E328),
            //       txtColor: Color(0xFF002E57),
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
