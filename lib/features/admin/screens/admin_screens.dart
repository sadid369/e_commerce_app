import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/features/account/screens/account_screen.dart';
import 'package:e_commerce_app/features/account/services/account_services.dart';
import 'package:e_commerce_app/features/admin/screens/analytics_screen.dart';
import 'package:e_commerce_app/features/admin/screens/order_admin_screen.dart';
import 'package:e_commerce_app/features/admin/screens/posts_screen.dart';
import 'package:e_commerce_app/features/admin/services/admin_services.dart';
import 'package:e_commerce_app/features/home/screens/home_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdminScreens extends StatefulWidget {
  static const String routeName = 'admin-screen';
  const AdminScreens({Key? key}) : super(key: key);

  @override
  _AdminScreensState createState() => _AdminScreensState();
}

class _AdminScreensState extends State<AdminScreens> {
  final AccountServices accountServices = AccountServices();
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    const PostsScreen(),
    const AnalyticsScreen(),
    const OrderAdminScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Admin',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () {
                        accountServices.logOut(context);
                      },
                      icon: Icon(
                        Icons.logout,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          //Home
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
            label: 'Post',
          ),
          //Account
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.analytics_outlined,
              ),
            ),
            label: 'Analytic',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.all_inbox_outlined,
              ),
            ),
            label: 'Order',
          ),
          //Cart
        ],
      ),
    );
  }
}
