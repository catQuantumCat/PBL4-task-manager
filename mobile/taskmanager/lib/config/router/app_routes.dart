import 'package:flutter/material.dart';
import 'package:taskmanager/modules/auth/view/login.view.dart';
import 'package:taskmanager/modules/navigation/view/navigation.view.dart';

class AppRoutes {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) {
          // return const NavigationPage();
          return const LoginPage();
        });

      case '/authLogin':
        return MaterialPageRoute(builder: (_) {
          return const LoginPage();
        });

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Text("Error! onGenerateRoute"),
                ));
    }
  }

  dispose() {
    //TODO
  }
}
