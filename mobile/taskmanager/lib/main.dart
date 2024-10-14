import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:taskmanager/common/constants/hive_constant.dart';

import 'package:taskmanager/config/router/app_routes.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:taskmanager/modules/auth/bloc/auth/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
  await Hive.openBox(HiveConstant.boxName);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = AppRoutes();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        onGenerateRoute: (setting) => _router.onGenerateRoute(setting),
      ),
    );
  }
}
