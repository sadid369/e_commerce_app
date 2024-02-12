import 'package:e_commerce_app/common/widgets/bottom_bar.dart';
import 'package:e_commerce_app/features/admin/screens/add_product_screen.dart';
import 'package:e_commerce_app/features/admin/screens/admin_screens.dart';
import 'package:e_commerce_app/features/admin/screens/posts_screen.dart';
import 'package:e_commerce_app/features/auth/screens/auth_screens.dart';
import 'package:e_commerce_app/features/home/screens/category_deal_screen.dart';
import 'package:e_commerce_app/features/home/screens/home_screens.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreens.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const AuthScreens(),
      );
    case HomeScreens.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const HomeScreens(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const BottomBar(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const AddProductScreen(),
      );
    case PostsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const PostsScreen(),
      );
    case AdminScreens.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const AdminScreens(),
      );
    case CategoryDealScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => CategoryDealScreen(category: category),
      );
    default:
      // TODO :Add here a lottiAnimation.
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('Not a route'),
          ),
        ),
      );
  }
}
