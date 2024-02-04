import 'package:aquaria_mobile/models/sup_req_model.dart';
import 'package:aquaria_mobile/providers/auth_provider.dart';
import 'package:aquaria_mobile/providers/item_order_provider.dart';
import 'package:aquaria_mobile/screens/home/past_single_suplier_request.dart';
import 'package:aquaria_mobile/utils/size_config.dart';
import 'package:aquaria_mobile/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestsTab extends StatefulWidget {
  const RequestsTab({
    super.key,
  });
  @override
  State<RequestsTab> createState() => _RequestsTabState();
}

class _RequestsTabState extends State<RequestsTab> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ItemOrderProvider>(context, listen: false).loadSupplierRequests(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = SizeConfig();
    return Consumer<ItemOrderProvider>(
      builder: (context, itemOrd, child) {
        return DefaultTabController(
          length: 4,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Requests",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
              TabBar(
                isScrollable: true,
                tabs: [
                  Tab(text: 'Pending(${itemOrd.getSeperateSupReq(approval: 'pending', published: [0]).length})'),
                  Tab(text: 'Approved'),
                  Tab(text: 'Rejected'),
                  Tab(text: 'Published'),
                ],
              ),
              // Expanded(child: Container())
              Expanded(
                child: TabBarView(
                  children: [
                    // Content of Tab 1
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: ListView.separated(
                        itemCount: itemOrd.getSeperateSupReq(approval: 'pending', published: [0]).length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 14,
                          );
                        },
                        itemBuilder: (context, index) {
                          return SupplierRequestCard(
                            size: size,
                            requestModel: itemOrd.getSeperateSupReq(approval: 'pending', published: [0])[index],
                          );
                        },
                      ),
                    ),
                    // Content of Tab 2
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: ListView.separated(
                        itemCount: itemOrd.getSeperateSupReq(approval: 'approved', published: [0]).length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 14,
                          );
                        },
                        itemBuilder: (context, index) {
                          return SupplierRequestCard(
                            size: size,
                            isFromApproved: true,
                            requestModel: itemOrd.getSeperateSupReq(approval: 'approved', published: [0])[index],
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
                    // Content of Tab 3
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: ListView.separated(
                        itemCount: itemOrd.getSeperateSupReq(approval: 'rejected', published: [0, 1]).length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 14,
                          );
                        },
                        itemBuilder: (context, index) {
                          return SupplierRequestCard(
                            size: size,
                            isFromApproved: true,
                            requestModel: itemOrd.getSeperateSupReq(approval: 'rejected', published: [0, 1])[index],
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
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: ListView.separated(
                        itemCount: itemOrd.getSeperateSupReq(approval: 'approved', published: [1]).length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 14,
                          );
                        },
                        itemBuilder: (context, index) {
                          return SupplierRequestCard(
                            size: size,
                            isFromApproved: true,
                            requestModel: itemOrd.getSeperateSupReq(approval: 'approved', published: [1])[index],
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
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class SupplierRequestCard extends StatelessWidget {
  const SupplierRequestCard({
    super.key,
    required this.size,
    this.isFromApproved = false,
    this.onTap,
    required this.requestModel,
  });

  final SizeConfig size;
  final void Function()? onTap;
  final bool isFromApproved;
  final SingleSupplierRequestModel requestModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => PastSingleSupplierRequest(item: requestModel),
            ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.getPropotionateWidth(20),
          vertical: size.getPropotionateHeight(15),
        ),
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
            Row(
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${requestModel.item!.commonName!}\n',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'Item Code:${requestModel.item!.code!} ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(12),
                //     gradient: LinearGradient(
                //       begin: Alignment.topCenter,
                //       end: Alignment.bottomRight,
                //       colors: [
                //         Colors.white.withOpacity(0.25),
                //         Colors.white.withOpacity(0.15),
                //       ],
                //     ),
                //   ),
                //   child:  Text(
                //     'User Code: ${requestModel.item!.commonName!}',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 12,
                //       fontFamily: 'Inter',
                //       fontWeight: FontWeight.w400,
                //     ),
                //   ),
                // )
              ],
            ),
            const SizedBox(
              height: 10,
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
                    'Quantity : ${requestModel.quantity!}',
                    style: TextStyle(
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
                    'Breeding : ${requestModel.breedingCapacity!}',
                    style: TextStyle(
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
                    'Future : ${requestModel.futureCollection!}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  requestModel.description!,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.699999988079071),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.14,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            if (isFromApproved)
              Consumer<AuthProvider>(
                builder: (context, value, child) {
                  if (value.getloggedinUser!.data!.role == "supplier") {
                    return Container();
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CommonButton(
                        size: size,
                        btnTxt: "Publish",
                        width: size.getPropotionateWidth(120),
                        height: size.getPropotionateHeight(40),
                        bgColor: const Color(0xFFF8E328),
                        txtColor: const Color(0xFF002E57),
                      )
                    ],
                  );
                },
              )
          ],
        ),
      ),
    );
  }
}
