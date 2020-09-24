import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:url_launcher/url_launcher.dart';

enum LauncherEnum {
  SMSURLID,
  CALLURLID,
  EMAILURLID,
}

Future<void> launchMessage(LauncherEnum type, String destination) async {
  var url;
  switch (type) {
    case LauncherEnum.CALLURLID:
      url = 'tel:' + destination;
      break;
    case LauncherEnum.SMSURLID:
      url = 'sms:' + destination;
      break;
    case LauncherEnum.EMAILURLID:
      url = 'mailto:' + destination;
      break;
    default:
  }
  try {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } catch (err) {
    Crashlytics.instance.setString('_handleButtonPress Error: ', err);
    Crashlytics.instance.log('_handleButtonPress Error: ' + err);
  }
}
