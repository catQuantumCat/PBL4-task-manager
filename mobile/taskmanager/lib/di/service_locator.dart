import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:taskmanager/common/constants/hive_constant.dart';
import 'package:taskmanager/data/datasources/local/user_local.datasource.dart';
import 'package:taskmanager/data/datasources/remote/task_remote.datasource.dart';
import 'package:taskmanager/data/datasources/remote/user_remote.datasource.dart';
import 'package:taskmanager/data/repositories/task.repository.dart';
import 'package:taskmanager/data/repositories/user.repository.dart';
import 'package:taskmanager/services/dio_provider.dart';

class ServiceLocator {
  // Private constructor
  ServiceLocator._internal() {
    setup();
  }

  final GetIt _getIt = GetIt.instance;
  GetIt get getIt => _getIt;

  static final ServiceLocator _instance = ServiceLocator._internal();

  factory ServiceLocator() {
    return _instance;
  }

  Future<void> setup() async {
    _getIt.registerSingletonAsync<Box>(
        () async => await Hive.openBox(HiveConstant.boxName));

    _getIt.registerSingletonAsync<Dio>(
        () async =>
            DioProvider().getDio(tokenBox: await _getIt.getAsync<Box>()),
        dependsOn: [Box]);

    _getIt.registerLazySingleton<TaskRepository>(
      () => TaskRepository(
        remoteDataSource: TaskRemoteDataSource(
          dio: _getIt<Dio>(),
        ),
      ),
    );
    _getIt.registerSingletonWithDependencies<UserRepository>(
        () => UserRepository(
            remoteSource: UserRemoteDatasource(dio: _getIt<Dio>()),
            localSource: UserLocalDatasource()),
        dependsOn: [Box, Dio]);
  }
}
