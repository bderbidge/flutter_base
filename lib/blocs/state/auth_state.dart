import 'package:flutter/foundation.dart';
import 'package:flutter_base/blocs/exceptions/validation_exception.dart';
import 'package:flutter_base/infrastructure/interfaces/i_analytics_service.dart';
import 'package:flutter_base/infrastructure/interfaces/i_auth_service.dart';
import 'package:flutter_base/models/user.dart';
import 'package:flutter_base/services/interfaces/i_user_service.dart';

@immutable
class AuthState {
  final IAuthService _authRepository;
  final IAnalyticsService _analyticsService;
  final User _user;
  final IUserService _userService;
  final UserType _type;

  AuthState({
    @required IAuthService authRepository,
    @required IAnalyticsService analyticsService,
    @required IUserService database,
    @required User user,
    @required UserType type,
  })  : _authRepository = authRepository,
        _analyticsService = analyticsService,
        _userService = database,
        _user = user,
        _type = type;

  User get user => _user;
  UserType get type => _type;

  static Function getUser(AuthState authState) {
    return authState._userService.getUser;
  }

  static Future<AuthState> attemptAutoLogin(AuthState authState) async {
    var currentUser = await authState._authRepository.currentUser;
    if (currentUser != null) {
      return await authState._initUserSession(currentUser.uid);
    }

    return InitAuthState(authState._authRepository, authState._userService,
        authState._analyticsService);
  }

  Future<AuthState> _initUserSession(String id) async {
    print("Sign in successful!");
    print("Getting rest of user $id's info");
    var currentUser = await this._userService.getUser(id);
    await this._initAnalyticsForUserSession(currentUser);
    return this.copyWith(user: currentUser, role: currentUser.role);
  }

  static Future<AuthState> updateUserInfo(
      AuthState authState, Map<String, dynamic> updates) async {
    Map<String, dynamic> uMap = authState.user.toJson()..addAll(updates);
    User updatedUser = User.fromJSON(uMap, null);
    await authState._userService.updateUser(updatedUser);
    return authState.copyWith(user: updatedUser, role: updatedUser.role);
  }

  static Future<AuthState> signInWithCredentials(
      AuthState authState, String providerStr) async {
    var user = await authState._authRepository
        .signInWithCredentials(getCredProviderFromString(providerStr));
    return await authState._initUserSession(user.uid);
  }

  Future<void> _initAnalyticsForUserSession(User currentUser) async {
    // Setup the analytics service for this user
    print("Initializing analytics");
    this._analyticsService.setUserInfo(
          currentUser.uid,
          email: currentUser.email,
          name: currentUser.name,
        );
  }

  static Future<AuthState> createUserWithEmailAndPassword(
    AuthState authState,
    String email,
    String password,
    String confirmPassword,
    String name,
  ) async {
    if (password != confirmPassword) {
      // TODO put into validator
      throw PasswordMisMatchException("Passwords must be matching");
    }
    final currentUser =
        await authState._authRepository.createUserWithEmailAndPassword(
      email,
      password,
      name,
    );
    await authState._userService.createUser(currentUser);
    return await authState._initUserSession(currentUser.uid);
  }

  static Future<AuthState> signInWithEmailAndPassword(
    AuthState authState,
    String email,
    String password,
  ) async {
    final currentUser =
        await authState._authRepository.signInWithEmailAndPassword(
      email,
      password,
    );
    return await authState._initUserSession(currentUser.uid);
  }

  static Future<AuthState> signOut(AuthState authState) async {
    await authState._authRepository.signOut();
    return InitAuthState(authState._authRepository, authState._userService,
        authState._analyticsService);
  }

  static AuthState selectRole(AuthState authState, UserType role) {
    var state = authState.copyWith(
      user: authState.user,
      role: role,
    );
    return state;
  }

  AuthState copyWith({
    IAuthService authRepository,
    IUserService database,
    IAnalyticsService analyticsService,
    User user,
    UserType role,
  }) {
    // switch (role) {
    //   case {USERTYPE}:
    //     return {USERTYPE}AuthState(
    //       user ?? _user,
    //       authRepository ?? _authRepository,
    //       database ?? _userService,
    //       analyticsService ?? _analyticsService,
    //     );
    //   default:
    return InitAuthState(authRepository, database, analyticsService);
    // }
  }

  @override
  String toString() => 'AuthState(user: $user)';
}

class InitAuthState extends AuthState {
  InitAuthState(IAuthService authRepository, IUserService database,
      IAnalyticsService analyticsService)
      : super(
          authRepository: authRepository,
          user: User(),
          database: database,
          analyticsService: analyticsService,
          type: UserType.Unknown,
        );
}
