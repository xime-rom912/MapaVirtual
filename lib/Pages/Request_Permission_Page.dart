// ignore_for_file: import_of_legacy_library_into_null_safe
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mapavirtual/Controllers/Request_Permission_Controller.dart';
import 'package:mapavirtual/routes.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestPermissionPage extends StatefulWidget {
  const RequestPermissionPage({Key? key}) : super(key: key);

  @override
  State<RequestPermissionPage> createState() => _RequestPermissionPageState();
}

class _RequestPermissionPageState extends State<RequestPermissionPage>
    with WidgetsBindingObserver {
  final _controller = RequestPermissionController(Permission.locationWhenInUse);
  late StreamSubscription _subscription;
  bool _fromSettings = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _subscription = _controller.onStatusChanged.listen(
      (status) {
        switch (status) {
          case PermissionStatus.granted:
            _goToHome();
            break;
          case PermissionStatus.permanentlyDenied:
            _goToHome();
            break;
          case PermissionStatus.undetermined:
            _goToHome();
            break;
          case PermissionStatus.denied:
            _goToHome();
            break;
          case PermissionStatus.restricted:
            _goToHome();
            break;
          case PermissionStatus.limited:
            _goToHome();
            break;
        }
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed && _fromSettings) {
      final status = await _controller.check();
      if (status == PermissionStatus.granted) {
        _goToHome();
      }
    }
    _fromSettings = false;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _subscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _goToHome() {
    Navigator.pushReplacementNamed(context, Routes.HOME);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/png/uach.png",alignment:Alignment.center,),
            ElevatedButton(
              child: const Text("Allow"),
              onPressed: () {
                _controller.request();
              },
            ),
          ],
        ),
      ),
    );
  }
}
