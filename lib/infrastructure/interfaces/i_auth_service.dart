import 'package:flutter_base/models/user.dart';

abstract class IAuthService {
  Future<User> get currentUser;

  Future<User> createUserWithEmailAndPassword(
      String email, String password, String name);
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> signInWithCredentials(CredentialProvider provider);
  Future<void> signOut();
  Stream<User> get onAuthStateChanged; //TODO maybe this for logging in and out?

  Future<void> sendPasswordResetEmail();
}

enum CredentialProvider {
  google,
}

CredentialProvider getCredProviderFromString(String val) {
  return CredentialProvider.values.firstWhere(
      (type) => type.toString().split(".").last == val.toLowerCase());
}
