abstract class IAnalyticsService {
  void log(String message);
  void setUserInfo(String uid, {String name, String email});
}
