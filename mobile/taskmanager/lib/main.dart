import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:taskmanager/config/router/app_routes.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:taskmanager/data/repositories/user.repository.dart';
import 'package:taskmanager/di/service_locator.dart';
import 'package:taskmanager/modules/auth/bloc/auth/auth_bloc.dart';

final GetIt getIt = ServiceLocator().getIt;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = AppRoutes();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIt.allReady(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return BlocProvider(
            create: (context) =>
                AuthBloc(userRepository: getIt<UserRepository>()),
            child: MaterialApp(
              onGenerateRoute: (setting) => _router.onGenerateRoute(setting),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
