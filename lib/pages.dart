import 'package:flutter/cupertino.dart';
import 'package:mapavirtual/Pages/request_permission_page.dart';
import 'package:mapavirtual/main.dart';
import 'package:mapavirtual/routes.dart';
import 'package:mapavirtual/Pages/splash_page.dart';
import 'package:mapavirtual/Pages/ar_core_page.dart';

Map<String, Widget Function(BuildContext)> appRoutes() {
  return {
    Routes.SPLASH: (_) => const SplashPage(),
    Routes.PERMISSIONS: (_) => const RequestPermissionPage(),
    Routes.HOME: (_) =>  MyHomePage(),
    Routes.ARCORE: (_) => const ArCorePage(),
  };
}
