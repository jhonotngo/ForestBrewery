import 'package:forest_brewery_test/core/exceptions/app_exceptions.dart';
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
    try {
      final dtos = await remoteDataSource.getBreweries(
        page: page,
        perPage: perPage,
      );
      return dtos.map((dto) => dto.toDomain()).toList();
    } on AppException {
      rethrow;
    } catch (e) {
      throw UnexpectedException('Error fetching breweries: $e');
    }
  }

  @override
  Future<Brewery> getBreweryDetail({required String id}) async {
    try {
      final dto = await remoteDataSource.getBreweryDetail(id: id);
      return dto.toDomain();
    } on AppException {
      rethrow;
    } catch (e) {
      throw UnexpectedException('Error fetching brewery detail: $e');
    }
  }

  @override
  Future<List<Brewery>> searchBreweries({required String query}) async {
    try {
      final dtos = await remoteDataSource.searchBreweries(query: query);
      return dtos.map((dto) => dto.toDomain()).toList();
    } on AppException {
      rethrow;
    } catch (e) {
      throw UnexpectedException('Error searching breweries: $e');
    }
  }
}
