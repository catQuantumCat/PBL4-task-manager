import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:taskmanager/common/theme/palette.dart';
import 'package:taskmanager/common/theme/text_style.dart';
import 'package:taskmanager/common/theme/theme_sheet.dart';
import 'package:taskmanager/common/toast/common_toast.dart';
import 'package:taskmanager/config/router/app_routes.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:taskmanager/data/repositories/user.repository.dart';
import 'package:taskmanager/di/service_locator.dart';
import 'package:taskmanager/modules/auth/bloc/auth/auth_bloc.dart';

final GetIt getIt = GetIt.instance;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
NavigatorState get navigator => navigatorKey.currentState!;
BuildContext get navigatorContext => navigatorKey.currentContext!;

void main() async {
  await initialize();
  runApp(MyApp());
}

Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
  await ServiceLocator.setup(getIt);
  await getIt.allReady();
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = AppRoutes();

  @override
  Widget build(BuildContext context) {
    final TransitionBuilder fToastBuilder = FToastBuilder();

    return BlocProvider(
      create: (context) => AuthBloc(userRepository: getIt<UserRepository>())
        ..add(const AuthCheckToken()),
      child: MaterialApp(
        theme: ThemeSheet(
                palette: Palette.light(),
                appTextStyles: AppTextStyles.fromPalette(Palette.light()))
            .themeData,
        navigatorKey: navigatorKey,
        onGenerateRoute: _router.onGenerateRoute,
        initialRoute: "/",
        builder: (context, child) {
          child = fToastBuilder(context, child);

          return BlocListener<AuthBloc, AuthState>(
              child: child,
              listener: (context, state) {
                log(state.status.toString());

                switch (state.status) {
                  case AuthStatus.authenticated:
                    navigator.pushNamedAndRemoveUntil("/home", (_) => false);
                    break;
                  case AuthStatus.unauthenticated:
                    navigator.pushNamedAndRemoveUntil(
                        "/authWelcome", (_) => false);
                    break;
                  case AuthStatus.initial:
                    break;
                }
              });
        },
      ),
    );
  }
}
