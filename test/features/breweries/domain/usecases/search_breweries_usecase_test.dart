import 'package:flutter_test/flutter_test.dart';
import 'package:forest_brewery_test/features/breweries/domain/entities/brewery.dart';
import 'package:forest_brewery_test/features/breweries/domain/repositories/brewery_repository.dart';
import 'package:forest_brewery_test/features/breweries/domain/usecases/search_breweries_usecase.dart';
import 'package:mocktail/mocktail.dart';

// Mock del repository
class MockBreweryRepository extends Mock implements BreweryRepository {}

void main() {
  late SearchBreweriesUseCase searchBreweriesUseCase;
  late MockBreweryRepository mockBreweryRepository;

  setUp(() {
    mockBreweryRepository = MockBreweryRepository();
    searchBreweriesUseCase = SearchBreweriesUseCase(
      repository: mockBreweryRepository,
    );
  });

  group('SearchBreweriesUseCase', () {
    test('should return breweries from repository', () async {
      final mockBreweries = [
        Brewery(
          id: '1',
          name: 'Corona Brewery',
          breweryType: 'micro',
          city: 'Mexico City',
        ),
        Brewery(
          id: '2',
          name: 'Corina Light Brewery',
          breweryType: 'micro',
          city: 'Mexico City',
        ),
      ];

      when(
        () => mockBreweryRepository.searchBreweries(query: any(named: 'query')),
      ).thenAnswer((_) async => mockBreweries);

      final result = await searchBreweriesUseCase(
        SearchBreweriesParams(query: 'test'),
      );

      expect(result, mockBreweries); // ✓ Verifica que devolvió lo correcto
    });

    test('should call repository with correct query', () async {
      when(
        () => mockBreweryRepository.searchBreweries(query: any(named: 'query')),
      ).thenAnswer((_) async => []);

      await searchBreweriesUseCase(SearchBreweriesParams(query: 'Corona'));

      verify(() => mockBreweryRepository.searchBreweries(query: 'Corona'))
          .called(1);
    });

    test('should return empty list when no results', () async {
      when(
        () => mockBreweryRepository.searchBreweries(query: any(named: 'query')),
      ).thenAnswer((_) async => []);

      final result = await searchBreweriesUseCase(
        SearchBreweriesParams(query: 'nonexistent'),
      );

      expect(result, isEmpty);
    });
  });
}
