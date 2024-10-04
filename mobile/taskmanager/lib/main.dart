import 'package:flutter/material.dart';
import 'package:taskmanager/config/router/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = AppRoutes();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (setting) => _router.onGenerateRoute(setting),
    );
  }
}
