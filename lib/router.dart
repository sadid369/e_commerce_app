import 'package:e_commerce_app/features/auth/screens/auth_screens.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreens.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const AuthScreens(),
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
