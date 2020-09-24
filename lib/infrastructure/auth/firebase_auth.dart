import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/infrastructure/interfaces/i_auth_service.dart';
import 'package:flutter_base/services/auth/auth_exception.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_base/models/user.dart' as FLUTTERBASE;

class FirebaseAuthService implements IAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  static const _errorCodeInvalidEmail = "ERROR_INVALID_EMAIL";
  static const _errorCodeWrongEmailPass = "ERROR_WRONG_PASSWORD";
  static const _errorCodeWeakPassword = "ERROR_WEAK_PASSWORD";
  static const _errorCodeUserNotFound = "ERROR_USER_NOT_FOUND";
  static const _errorCodeUserDisabled = "ERROR_USER_DISABLED";
  static const _errorCodeRequestLimit = "ERROR_TOO_MANY_REQUESTS";
  static const _errorCodeEmailInUse = "ERROR_EMAIL_ALREADY_IN_USE";
  static const _errorCodeInvalidCreds = "ERROR_INVALID_CREDENTIAL";

  @override
  Future<FLUTTERBASE.User> get currentUser async =>
      _fbUserToUser(_auth.currentUser);

  @override
  Stream<FLUTTERBASE.User> get onAuthStateChanged => _auth
      .authStateChanges()
      .map((User u) => u == null ? null : _fbUserToUser(u));

  @override
  Future<FLUTTERBASE.User> signInWithCredentials(
      CredentialProvider provider) async {
    try {
      switch (provider) {
        case CredentialProvider.google:
          UserCredential authResult = await this._signInWithGoogle();
          assert(authResult.user != null);
          assert(!authResult.user.isAnonymous);
          assert(await authResult.user.getIdToken() != null);
          // TODO throw exceptions instead of using asserts
          return _fbUserToUser(authResult.user);
          break;
        default:
          return null;
      }
    } on PlatformException catch (e) {
      var newError;
      switch (e.code) {
        case _errorCodeInvalidCreds:
          newError = InvalidCredentialsException(
              "An error occurred, please try again or try signing in with your email and password");
          break;
        case _errorCodeUserDisabled:
          newError = UserDisabledException(
              "Opps. Looks like your account is disabled, please contact us to resolve this issue.");
          break;
        default:
          newError = e;
      }

      throw newError;
    }
  }

  @override
  Future<FLUTTERBASE.User> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      assert(authResult.user != null);
      assert(await authResult.user.getIdToken() != null);
      return _fbUserToUser(authResult.user);
      // TODO throw exceptions instead of using asserts
    } on PlatformException catch (e) {
      var newError;
      switch (e.code) {
        // case _errorCodeInvalidEmail:
        //   newError = InvalidEmailException("Enter a valid email");
        //   break;
        case _errorCodeWrongEmailPass:
          newError =
              InvalidCredentialsException("Email or password are incorrect");
          break;
        case _errorCodeUserNotFound:
          newError = UserNotFoundException(
              "The email doesn't match our system. Sign up first or sign in with Google");
          break;
        case _errorCodeUserDisabled:
          newError = UserDisabledException(
              "Opps. Looks like your account is disabled, please contact us to resolve this issue.");
          break;
        case _errorCodeRequestLimit:
        default:
          newError = e;
      }

      throw newError;
    }
  }

  @override
  Future<FLUTTERBASE.User> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      assert(authResult != null);
      assert(await authResult.user.getIdToken() != null);
      // TODO throw exceptions instead of using asserts

      // Manually add in the User's name to their Firebase account

      await authResult.user.updateProfile(displayName: name);
      return _fbUserToUser(authResult.user);
    } on PlatformException catch (e) {
      var newError;
      switch (e.code) {
        // case _errorCodeInvalidEmail:
        //   newError = InvalidEmailException("Enter a valid email");
        //   break;
        // case _errorCodeWeakPassword:
        //   newError = WeakPasswordException(
        //       "Password must be longer than 6 characters. Throw in some numbers and symbols as well! You can never be too secure.");
        //   break;
        case _errorCodeEmailInUse:
          newError = EmailInUseException(
              "Looks like that email is already being used. If you think this is incorrect please contact us.");
          break;
        default:
          newError = e;
      }

      throw newError;
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
    return await _googleSignIn.signOut();
  }

  @override
  Future<void> sendPasswordResetEmail() async {
    // TODO: implement sendPasswordResetEmail
    return null;
  }

  Future<UserCredential> _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // final AuthResult authResult = await _auth.signInWithCredential(credential);

    // assert(authResult.user != null);
    // assert(!authResult.user.isAnonymous);
    // assert(await authResult.user.getIdToken() != null);

    // final FirebaseUser currentFBUser = await this._auth.currentUser();
    // assert(authResult.user.uid == currentFBUser.uid);

    return await _auth.signInWithCredential(credential);
  }

  FLUTTERBASE.User _fbUserToUser(User fbUser) {
    if (fbUser == null) {
      return null;
    } else {
      return FLUTTERBASE.User(
        uid: fbUser.uid,
        name: fbUser.displayName,
        email: fbUser.email,
        photoUrl: fbUser.photoURL,
      );
    }
  }
}
