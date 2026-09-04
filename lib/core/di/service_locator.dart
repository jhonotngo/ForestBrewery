import 'package:dio/dio.dart';
import 'package:forest_brewery_test/features/breweries/data/datasources/brewery_remote_datasource.dart';
import 'package:forest_brewery_test/features/breweries/data/datasources/brewery_remote_datasource_impl.dart';
import 'package:forest_brewery_test/features/breweries/data/repositories/brewery_repository_impl.dart';
import 'package:forest_brewery_test/features/breweries/domain/repositories/brewery_repository.dart';
import 'package:forest_brewery_test/features/breweries/domain/usecases/get_breweries_usecase.dart';
import 'package:forest_brewery_test/features/breweries/domain/usecases/get_brewery_detail_usecase.dart';
import 'package:forest_brewery_test/features/breweries/presentation/bloc/brewery_list/brewery_list_boc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // HTTP Client
  getIt.registerSingleton<Dio>(
    Dio(
      BaseOptions(
        baseUrl: 'https://api.openbrewerydb.org/v1',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    ),
  );

  // Datasource (Remote only)
  getIt.registerSingleton<BreweryRemoteDataSource>(
    BreweryRemoteDataSourceImpl(dio: getIt<Dio>()),
  );

  // Repository
  getIt.registerSingleton<BreweryRepository>(
    BreweryRepositoryImpl(remoteDataSource: getIt<BreweryRemoteDataSource>()),
  );

  // Use Cases
  getIt.registerSingleton<GetBreweriesUseCase>(
    GetBreweriesUseCase(repository: getIt<BreweryRepository>()),
  );

  getIt.registerSingleton<GetBreweryDetailUseCase>(
    GetBreweryDetailUseCase(repository: getIt<BreweryRepository>()),
  );

  // BLOCs
  getIt.registerSingleton<BreweryListBloc>(
    BreweryListBloc(getBreweriesUseCase: getIt<GetBreweriesUseCase>()),
  );
}
