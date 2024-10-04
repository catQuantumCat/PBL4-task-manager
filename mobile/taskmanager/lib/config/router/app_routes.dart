import 'package:flutter/material.dart';
import 'package:taskmanager/modules/navigation/view/navigation.view.dart';

class AppRoutes {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) {
          return const NavigationPage();
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
