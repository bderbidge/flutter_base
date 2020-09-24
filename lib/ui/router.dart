import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/auth/login_page.dart';

class Router {
  static const root = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return MaterialPageRoute(builder: (_) => LoginPage());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}

// Route Transitions
class SlideRightToLeftRouteAnimation extends PageRouteBuilder {
  final Widget widget;
  SlideRightToLeftRouteAnimation({this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}

// A route animation that slides in the new screen/widget from the left to the right of the screen
class SlideLeftToRightRouteAnimation extends PageRouteBuilder {
  final Widget widget;
  SlideLeftToRightRouteAnimation({this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}

// A route animation that slides in the new screen/widget from the bottom to the top of the screen
class SlideBottomToTopRouteAnimation extends PageRouteBuilder {
  final Widget widget;
  SlideBottomToTopRouteAnimation({this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}

// A route animation that slides in the new screen/widget from the top to the bottom of the screen
class SlideTopToBottomRouteAnimation extends PageRouteBuilder {
  final Widget widget;
  SlideTopToBottomRouteAnimation({this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, -1.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}
