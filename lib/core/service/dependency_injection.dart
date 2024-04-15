import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veep_meep/features/presentation/bloc/chat/chat_bloc.dart';

import '../../features/data/datasources/remote_data_source.dart';
import '../../features/data/datasources/shared_preference.dart';
import '../../features/data/repositories/repository_impl.dart';
import '../../features/domain/repositories/repository.dart';
import '../../features/presentation/bloc/auth/auth_bloc.dart';
import '../../features/presentation/bloc/otp/otp_bloc.dart';
import '../../features/presentation/bloc/settings/settings_bloc.dart';
import '../../features/presentation/bloc/veep/veep_bloc.dart';
import '../network/api_helper.dart';
import '../network/mock_api_helper.dart';
import '../network/network_info.dart';
import 'cloud_services.dart';
import 'cloud_services_impl.dart';

final injection = GetIt.instance;

Future<void> setupLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  injection.registerLazySingleton(() => sharedPreferences);
  injection.registerSingleton(AppSharedData(injection()));

  injection.registerSingleton(CloudServicesImpl(injection()));
  injection.registerSingleton(Dio());
  injection.registerLazySingleton<APIHelper>(
      () => APIHelper(dio: injection(), appSharedData: injection()));
  injection.registerLazySingleton<MockAPIHelper>(() => MockAPIHelper());
  injection
      .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(injection()));
  injection.registerLazySingleton(() => Connectivity());
  injection.registerSingleton(CloudServices(injection(), injection()));

  ///Repository
  injection.registerLazySingleton<Repository>(
    () =>
        RepositoryImpl(remoteDataSource: injection(), networkInfo: injection()),
  );

  ///Data sources
  injection.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
        apiHelper: injection(), mockAPIHelper: injection()),
  );

  ///Blocs
  injection.registerFactory(
    () => AuthBloc(
        appSharedData: injection(),
        repository: injection(),
        cloudServices: injection()),
  );
  injection.registerFactory(
    () => VeepBloc(
      appSharedData: injection(),
      repository: injection(),
    ),
  );
  injection.registerFactory(
    () => ChatBloc(
      appSharedData: injection(),
      repository: injection(),
    ),
  );
  injection.registerFactory(
    () => SettingsBloc(
      appSharedData: injection(),
      repository: injection(),
    ),
  );
  injection.registerFactory(
    () => OtpBloc(
      appSharedData: injection(),
      repository: injection(),
    ),
  );
}
