import 'package:forest_brewery_test/features/breweries/data/models/brewery_dto.dart';

abstract class BreweryRemoteDataSource {
  Future<List<BreweryDto>> getBreweries({
    required int page,
    required int perPage,
  });

  Future<BreweryDto> getBreweryDetail({required String id});

  Future<List<BreweryDto>> searchBreweries({required String query});
}
