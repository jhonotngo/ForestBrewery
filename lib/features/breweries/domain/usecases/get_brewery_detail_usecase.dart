import 'package:forest_brewery_test/core/usecases/usecase.dart';
import 'package:forest_brewery_test/features/breweries/domain/entities/brewery.dart';
import 'package:forest_brewery_test/features/breweries/domain/repositories/brewery_repository.dart';

class GetBreweryDetailUseCase extends UseCase<Brewery, GetBreweryDetailParams> {
  final BreweryRepository repository;

  GetBreweryDetailUseCase({required this.repository});

  @override
  Future<Brewery> call(GetBreweryDetailParams params) async {
    return await repository.getBreweryDetail(id: params.id);
  }
}

class GetBreweryDetailParams {
  final String id;

  const GetBreweryDetailParams({required this.id});
}
