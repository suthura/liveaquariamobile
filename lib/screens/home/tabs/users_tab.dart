import 'package:aquaria_mobile/models/sub_user_model.dart';
import 'package:aquaria_mobile/providers/auth_provider.dart';
import 'package:aquaria_mobile/screens/home/add_user_screen.dart';
import 'package:aquaria_mobile/utils/color_constants.dart';
import 'package:aquaria_mobile/utils/size_config.dart';
import 'package:aquaria_mobile/widgets/common_button.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersTab extends StatefulWidget {
  const UsersTab({
    super.key,
  });
  @override
  State<UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).loadSubUsers(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = SizeConfig();
    return DefaultTabController(
      length: 1,
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            "Users",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonButton(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const AddUserScreen(),
                    ),
                  ),
                  size: size,
                  btnTxt: '+ Add',
                  width: size.getPropotionateWidth(120),
                  height: size.getPropotionateHeight(40),
                  bgColor: Color(0xFFF8E328),
                  txtColor: Colors.black,
                ),
              ],
            ),
          ),
          // TabBar(
          //   isScrollable: true,
          //   tabs: [
          //     // Tab(text: 'Suppliers'),
          //     Tab(text: 'Sub Users'),
          //   ],
          // ),
          SizedBox(
            height: size.getPropotionateHeight(5),
          ),

          // Expanded(child: Container())

          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Consumer<AuthProvider>(
                builder: (context, value, child) {
                  if (value.getisLoadingSubUsers) {
                    return CupertinoActivityIndicator(
                      color: kTxtWhite,
                    );
                  }
                  if (value.getloadedSubUser!.data!.isEmpty) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * .75,
                      child: EmptyWidget(
                        image: null,
                        packageImage: PackageImage.Image_3,
                        title: 'No Users',
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
                    );
                  }
                  return ListView.separated(
                    itemCount: value.getloadedSubUser!.data!.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 14,
                      );
                    },
                    itemBuilder: (context, index) {
                      return SupplierRequestCard(
                        size: size,
                        user: value.getloadedSubUser!.data![index],
                      );
                    },
                  );
                },
              ),
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
    this.onTap,
    required this.user,
  });

  final SizeConfig size;
  final void Function()? onTap;
  final SubUser user;

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
          color: Color(0xFF024F7D).withOpacity(.29),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color.fromARGB(2, 78, 145, 176).withOpacity(1),
            width: 3,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${user.name}\n',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: '${user.email}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
                    'User ID: ${user.id}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${user.phone}',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white.withOpacity(0.699999988079071),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.14,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
