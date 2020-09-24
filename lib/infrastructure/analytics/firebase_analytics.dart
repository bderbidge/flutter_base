import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_base/infrastructure/interfaces/i_analytics_service.dart';

class FirebaseAnalyticsService implements IAnalyticsService {
  @override
  void log(String message) {
    Crashlytics.instance.log(message);
  }

  @override
  void setUserInfo(String uid, {String name, String email}) {
    Crashlytics.instance.setUserIdentifier(uid);
    Crashlytics.instance.setUserEmail(email);
    Crashlytics.instance.setUserName(name);
  }
}
