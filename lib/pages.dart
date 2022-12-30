import 'package:flutter/cupertino.dart';
import 'package:mapavirtual/Request_Permission_Page.dart';
import 'package:mapavirtual/main.dart';
import 'package:mapavirtual/routes.dart';
import 'package:mapavirtual/splash_page.dart';

import 'ArCorePage.dart';

Map<String, Widget Function(BuildContext)> appRoutes(){
  return {
    Routes.SPLASH:(_)=> const SplashPage(),
    Routes.PERMISSIONS :(_) => const RequestPermissionPage(),
    Routes.HOME: (_) => const MyHomePage(),
    Routes.ARCORE: (_)=> const ArCorePage(),
  };
}