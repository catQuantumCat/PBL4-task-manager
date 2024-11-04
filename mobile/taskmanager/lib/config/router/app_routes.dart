import 'package:flutter/material.dart';
import 'package:taskmanager/modules/auth/view/login.view.dart';
import 'package:taskmanager/modules/auth/view/register.view.dart';
import 'package:taskmanager/modules/navigation/view/navigation.view.dart';
import 'package:taskmanager/modules/search/view/search.view.dart';

class AppRoutes {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("Dummy Page"),
            ),
          );
        });

      case '/authLogin':
        return MaterialPageRoute(
          builder: (_) {
            return const LoginPage();
          },
        );

      case '/authRegister':
        return MaterialPageRoute(
          builder: (_) {
            return const RegisterPage();
          },
        );

      case '/home':
        return MaterialPageRoute(
          builder: (_) {
            return const NavigationPage();
          },
        );
      case '/search':
        return MaterialPageRoute(
          builder: (_) {
            return const SearchPage();
          },
        );
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
