import 'package:e_commerce_app/common/widgets/bottom_bar.dart';
import 'package:e_commerce_app/features/auth/screens/auth_screens.dart';
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
