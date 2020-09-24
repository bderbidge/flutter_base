import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/app.dart';
import 'package:flutter_base/blocs/state/auth_state.dart';
import 'package:flutter_base/infrastructure/analytics/firebase_analytics.dart';
import 'package:flutter_base/infrastructure/auth/firebase_auth.dart';
import 'package:flutter_base/infrastructure/data_source/firestore_service.dart';
import 'package:flutter_base/infrastructure/interfaces/i_analytics_service.dart';
import 'package:flutter_base/infrastructure/interfaces/i_auth_service.dart';
import 'package:flutter_base/infrastructure/interfaces/i_data_source.dart';
import 'package:flutter_base/services/file_service.dart';
import 'package:flutter_base/services/interfaces/i_file_service.dart';
import 'package:flutter_base/services/interfaces/i_user_service.dart';
import 'package:flutter_base/services/user_service.dart';

import 'package:states_rebuilder/states_rebuilder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = (FlutterErrorDetails details) {
    Crashlytics.instance.recordFlutterError(details);
  };

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Injector(
      inject: [
        Inject<IAnalyticsService>(() => FirebaseAnalyticsService()),
        //Inject the AuthRepository implementation and register is via its
        // IAuthRepository interface. This is important for testing (see bellow).
        Inject<IAuthService>(
          () => FirebaseAuthService(),
        ),
        Inject<IDataSource>(
            () => FirestoreService(db: FirebaseFirestore.instance)),
        Inject<IUserService>(() => UserService(db: IN.get<IDataSource>())),
        Inject<IFileService>(() => FileService()),
        Inject<AuthState>(
          () => InitAuthState(
            IN.get<IAuthService>(),
            IN.get<IUserService>(),
            IN.get<IAnalyticsService>(),
          ),
        ),
      ],
      builder: (context) => const AppManager(),
    );
  }
}

class Database {}
