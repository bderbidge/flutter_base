import 'package:flutter/material.dart';
import 'package:flutter_base/models/user.dart';
import 'package:flutter_base/ui/pages/auth/login_page.dart';
import 'package:flutter_base/ui/router.dart';
import 'package:flutter_base/ui/shared/splash_screen.dart';
import 'package:flutter_base/ui/theme.dart';

import 'package:states_rebuilder/states_rebuilder.dart';

import 'blocs/state/auth_state.dart';

class AppManager extends StatelessWidget {
  const AppManager({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: mainLightTheme,
      home: StateBuilder<AuthState>(
        watch: (rm) => rm.state.type,
        observe: () => RM.get<AuthState>()
          ..setState(
            (authState) => AuthState.attemptAutoLogin(authState),
          ),
        builder: (context, authStateRM) {
          if (authStateRM.isWaiting) {
            return SplashScreen();
          } else if (authStateRM.state is InitAuthState) {
            return LoginPage();
          } else {
            Widget widget;
            switch (authStateRM.state.type) {

              // Make the user pick a role
              case UserType.Unknown:
                break;
              default:
                // TODO No users should have an unknown type but
                // if they acutally do then we want to show an error page
                // and have them contact us
                throw Exception('Error ocurred');
            }

            return widget;
          }
        },
      ),
      onGenerateRoute: Router.generateRoute,
    );
  }
}
