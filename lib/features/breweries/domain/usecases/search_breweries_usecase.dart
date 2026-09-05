import 'package:forest_brewery_test/core/usecases/usecase.dart';
import 'package:forest_brewery_test/features/breweries/domain/entities/brewery.dart';
import 'package:forest_brewery_test/features/breweries/domain/repositories/brewery_repository.dart';

class SearchBreweriesUseCase
    implements UseCase<List<Brewery>, SearchBreweriesParams> {
  final BreweryRepository repository;

  SearchBreweriesUseCase({required this.repository});

  @override
  Future<List<Brewery>> call(SearchBreweriesParams params) async {
    return await repository.searchBreweries(query: params.query);
  }
}

class SearchBreweriesParams {
  final String query;

  const SearchBreweriesParams({required this.query});
}
