import 'dart:developer';

import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/features/auth/screens/auth_screens.dart';
import 'package:e_commerce_app/features/auth/services/auth_services.dart';
import 'package:e_commerce_app/features/home/screens/home_screens.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    // authService.getUserData(context: context);
  }

  void getData() async {
    final SharedPreferences p = await SharedPreferences.getInstance();
    var data = p.getString('x-auth-token');
    log(data.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Builder(builder: (context) {
        return FutureBuilder(
          future: authService.getUserData(context: context),
          builder: (context, snapshot) {
            getData();
            if (snapshot.connectionState == ConnectionState.done) {
              log("token ${context.watch<UserProvider>().user.token}");
              return context.watch<UserProvider>().user.token.isNotEmpty
                  ? const HomeScreens()
                  : const AuthScreens();
            }
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        );
      }),
    );
  }
}
