import 'package:forest_brewery_test/features/breweries/data/datasources/brewery_remote_datasource.dart';
import 'package:forest_brewery_test/features/breweries/domain/entities/brewery.dart';
import 'package:forest_brewery_test/features/breweries/domain/repositories/brewery_repository.dart';

class BreweryRepositoryImpl implements BreweryRepository {
  final BreweryRemoteDataSource remoteDataSource;

  BreweryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Brewery>> getBreweries({
    required int page,
    required int perPage,
  }) async {
    final dtos = await remoteDataSource.getBreweries(
      page: page,
      perPage: perPage,
    );
    return dtos.map((dto) => dto.toDomain()).toList();
  }
}
