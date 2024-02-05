import 'package:aquaria_mobile/providers/auth_provider.dart';
import 'package:aquaria_mobile/screens/auth/login_screen.dart';
import 'package:aquaria_mobile/screens/home/tabs/home_adv_tab.dart';
import 'package:aquaria_mobile/screens/home/tabs/home_tab.dart';
import 'package:aquaria_mobile/screens/home/tabs/order_requests.dart';
import 'package:aquaria_mobile/screens/home/tabs/profile_tab.dart';
import 'package:aquaria_mobile/screens/home/tabs/requests_tab.dart';
import 'package:aquaria_mobile/screens/home/tabs/sub_order_requests.dart';
import 'package:aquaria_mobile/screens/home/tabs/users_tab.dart';
import 'package:aquaria_mobile/utils/color_constants.dart';
import 'package:aquaria_mobile/widgets/custom_background_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return CustomBackGroundContainer(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
            backgroundColor: const Color(0xFF1D1F24),
            unselectedIconTheme: const IconThemeData(
              color: Color(0xFF676D75),
            ),
            unselectedItemColor: const Color(0xFF676D75),
            selectedItemColor: kTxtWhite,
            selectedIconTheme: const IconThemeData(
              color: kTxtWhite,
            ),
            unselectedLabelStyle: const TextStyle(
              color: Color(0xFF676D75), //sada
            ),
            selectedLabelStyle: const TextStyle(
              color: kTxtWhite,
            ),
            type: BottomNavigationBarType.fixed,
            items: [
              if (auth.getloggedinUser!.data!.role == "supplier") ...[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: "Items",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.edit_document),
                  label: "Status",
                ),
              ],
              if (auth.getloggedinUser!.data!.role == "user" || auth.getloggedinUser!.data!.role == "sub_user") ...[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: "Items",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt_outlined),
                  label: "My Orders",
                ),
                if (auth.getloggedinUser!.data!.role != "sub_user") ...[
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: "Sub Orders",
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.person_add),
                    label: "Users",
                  ),
                ]
              ],
              const BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
          child: [
            if (auth.getloggedinUser!.data!.role == "supplier") ...[
              HomeTab(),
              // Container(),
              RequestsTab(),
            ],
            if (auth.getloggedinUser!.data!.role == "user" || auth.getloggedinUser!.data!.role == "sub_user") ...[
              // HomeTab(),
              HomeAdvTab(),
              OrderRequestsTab(isSubUser: false),
              if (auth.getloggedinUser!.data!.role != "sub_user") ...[
                SubOrderRequestsTab(
                  isSubUser: true,
                ),
                UsersTab(),
              ],
            ],
            ProfileTab(),
          ].elementAt(selectedIndex),
        );
      },
    );
  }
}
