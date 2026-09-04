import 'package:forest_brewery_test/core/usecases/usecase.dart';
import 'package:forest_brewery_test/features/breweries/domain/entities/brewery.dart';
import 'package:forest_brewery_test/features/breweries/domain/repositories/brewery_repository.dart';

class GetBreweriesUseCase extends UseCase<List<Brewery>, GetBreweriesParams> {
  final BreweryRepository repository;

  GetBreweriesUseCase({required this.repository});

  @override
  Future<List<Brewery>> call(GetBreweriesParams params) async {
    return await repository.getBreweries(
      page: params.page,
      perPage: params.perPage,
    );
  }
}

class GetBreweriesParams {
  final int page;
  final int perPage;

  const GetBreweriesParams({required this.page, required this.perPage});
}
