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
  static Future<void> setup(GetIt getIt) async {
    getIt.registerSingletonAsync<Box>(
        () async => await Hive.openBox(HiveConstant.boxName));

    getIt.registerSingletonAsync<Dio>(
        () async => DioProvider().getDio(tokenBox: await getIt.getAsync<Box>()),
        dependsOn: [Box]);

    getIt.registerLazySingleton<TaskRepository>(
      () => TaskRepository(
        remoteDataSource: TaskRemoteDataSource(
          dio: getIt<Dio>(),
        ),
      ),
    );
    getIt.registerSingletonWithDependencies<UserRepository>(
        () => UserRepository(
            remoteSource: UserRemoteDatasource(dio: getIt<Dio>()),
            localSource: UserLocalDatasource()),
        dependsOn: [Box, Dio]);
  }
}
