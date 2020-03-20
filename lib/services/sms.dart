import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class SmsService {
  static final SmsService _instance = SmsService._internal();
  PermissionHandler _permissionHandler;

  factory SmsService() {
    return _instance;
  }

  SmsService._internal() {
    _permissionHandler = PermissionHandler();
    _permissionHandler.requestPermissions([PermissionGroup.sms]);
  }

  sendSms () async {
    print("SendSMS");
    const platform = const MethodChannel('sendSms');
    try {
      final String result = await platform.invokeMethod('send',<String,dynamic>{"phone":"++33707070707","msg":"Hello! I'm sent programatically."});
      print(result);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }
}