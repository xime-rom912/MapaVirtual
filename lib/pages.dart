import 'package:flutter/cupertino.dart';
import 'package:mapavirtual/request_permission_page.dart';
import 'package:mapavirtual/main.dart';
import 'package:mapavirtual/routes.dart';
import 'package:mapavirtual/splash_page.dart';
import 'package:mapavirtual/ar_core_page.dart';

Map<String, Widget Function(BuildContext)> appRoutes() {
  return {
    Routes.SPLASH: (_) => const SplashPage(),
    Routes.PERMISSIONS: (_) => const RequestPermissionPage(),
    Routes.HOME: (_) => const MyHomePage(),
    Routes.ARCORE: (_) => const ArCorePage(),
  };
}
