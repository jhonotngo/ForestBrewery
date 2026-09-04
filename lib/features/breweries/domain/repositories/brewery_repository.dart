import 'package:forest_brewery_test/features/breweries/domain/entities/brewery.dart';

abstract class BreweryRepository {
  Future<List<Brewery>> getBreweries({required int page, required int perPage});
}
