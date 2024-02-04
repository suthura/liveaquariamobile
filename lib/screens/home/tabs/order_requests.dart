import 'package:aquaria_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';

class OrderRequestsTab extends StatefulWidget {
  const OrderRequestsTab({
    super.key,
  });
  @override
  State<OrderRequestsTab> createState() => _OrderRequestsTabState();
}

class _OrderRequestsTabState extends State<OrderRequestsTab> {
  @override
  Widget build(BuildContext context) {
    var size = SizeConfig();
    return DefaultTabController(
      length: 3,
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
          const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Pending(10)'),
              Tab(text: 'Approved'),
              Tab(text: 'Rejected'),
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
                    itemCount: 10,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 14,
                      );
                    },
                    itemBuilder: (context, index) {
                      return SupplierRequestCard(
                        size: size,
                        showButtons: true,
                      );
                    },
                  ),
                ),
                // Content of Tab 2
                Container(
                  padding: const EdgeInsets.all(20),
                  child: ListView.separated(
                    itemCount: 10,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 14,
                      );
                    },
                    itemBuilder: (context, index) {
                      return SupplierRequestCard(
                        size: size,

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
                  color: Colors.red,
                  child: const Center(
                    child: Text('Tab 3 Content'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SupplierRequestCard extends StatelessWidget {
  const SupplierRequestCard({
    super.key,
    required this.size,
    this.showButtons = false,
    this.onTap,
  });

  final SizeConfig size;
  final void Function()? onTap;
  final bool showButtons;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Tilapia Fish\n',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'Item ID: 34567G',
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
                  child: const Text(
                    'User ID: 34567G',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'PayFishKart delivers your favorite marine species at .......',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.white.withOpacity(0.699999988079071),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
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
