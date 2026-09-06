import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:forest_brewery_test/core/exceptions/app_exceptions.dart';
import 'package:forest_brewery_test/features/breweries/domain/entities/brewery.dart';
import 'package:forest_brewery_test/features/breweries/domain/usecases/get_breweries_usecase.dart';
import 'package:forest_brewery_test/features/breweries/domain/usecases/search_breweries_usecase.dart';
import 'package:forest_brewery_test/features/breweries/presentation/bloc/brewery_list/brewery_list_boc.dart';
import 'package:forest_brewery_test/features/breweries/presentation/bloc/brewery_list/brewery_list_event.dart';
import 'package:forest_brewery_test/features/breweries/presentation/bloc/brewery_list/brewery_list_state.dart';
import 'package:mocktail/mocktail.dart';

class MockGetBreweriesUseCase extends Mock implements GetBreweriesUseCase {}

class MockSearchBreweriesUseCase extends Mock
    implements SearchBreweriesUseCase {}

void main() {
  setUpAll(() {
    registerFallbackValue(GetBreweriesParams(page: 1, perPage: 20));
    registerFallbackValue(SearchBreweriesParams(query: ''));
  });

  late BreweryListBloc breweryListBloc;
  late MockGetBreweriesUseCase mockGetBreweriesUseCase;
  late MockSearchBreweriesUseCase mockSearchBreweriesUseCase;

  setUp(() {
    mockGetBreweriesUseCase = MockGetBreweriesUseCase();
    mockSearchBreweriesUseCase = MockSearchBreweriesUseCase();
    breweryListBloc = BreweryListBloc(
      getBreweriesUseCase: mockGetBreweriesUseCase,
      searchBreweriesUseCase: mockSearchBreweriesUseCase,
    );
  });

  tearDown(() {
    breweryListBloc.close();
  });

  final mockBreweries = [
    Brewery(id: '1', name: 'Test Brewery', city: 'Test City'),
  ];

  group('BreweryListBloc - Search', () {
    blocTest<BreweryListBloc, BreweryListState>(
      'emits [Loading, Success] when search succeeds',
      build: () {
        when(() => mockSearchBreweriesUseCase(any()))
            .thenAnswer((_) async => mockBreweries);
        return breweryListBloc;
      },
      act: (bloc) => bloc.add(BreweryListSearch(query: 'Corona')),
      expect: () => [const BreweryListLoading(), isA<BreweryListSuccess>()],
    );

    blocTest<BreweryListBloc, BreweryListState>(
      'emits [Loading, Empty] when no breweries found',
      build: () {
        when(() => mockSearchBreweriesUseCase(any()))
            .thenAnswer((_) async => []);
        return breweryListBloc;
      },
      act: (bloc) => bloc.add(BreweryListSearch(query: 'NonExistent')),
      expect: () => [const BreweryListLoading(), const BreweryListEmpty()],
    );

    blocTest<BreweryListBloc, BreweryListState>(
      'emits [Loading, Error] when search fails',
      build: () {
        when(() => mockSearchBreweriesUseCase(any()))
            .thenThrow(NetworkException('Connection failed'));
        return breweryListBloc;
      },
      act: (bloc) => bloc.add(BreweryListSearch(query: 'error')),
      expect: () => [
        const BreweryListLoading(),
        isA<BreweryListError>().having(
          (state) => state.message,
          'message',
          'Connection failed',
        ),
      ],
    );
  });
}
