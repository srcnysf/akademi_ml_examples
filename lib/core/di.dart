import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ml_kit_akademi_examples/core/api_client.dart';
import 'package:ml_kit_akademi_examples/core/api_services.dart';
import 'package:ml_kit_akademi_examples/core/repository.dart';

final getIt = GetIt.instance;

setupDI() async {
  //NETWORK
  getIt.registerLazySingleton<Dio>(() => ApiClient().getDio());
  getIt.registerLazySingleton(() => ApiService(getIt.get()));
  getIt.registerLazySingleton(() => Repository(getIt.get()));
}
