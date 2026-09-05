import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:forest_brewery_test/core/exceptions/app_exceptions.dart';
import 'package:forest_brewery_test/core/exceptions/location_exception.dart';
import 'package:forest_brewery_test/core/services/geolocator_service.dart';
import 'package:forest_brewery_test/core/utils/constanst.dart';
import 'package:forest_brewery_test/core/utils/haversine.dart';
import 'package:forest_brewery_test/features/breweries/domain/entities/brewery.dart';
import 'package:forest_brewery_test/features/breweries/domain/usecases/get_breweries_usecase.dart';
import 'package:forest_brewery_test/features/breweries/domain/usecases/search_breweries_usecase.dart';
import 'package:geolocator/geolocator.dart';

import 'brewery_list_event.dart';
import 'brewery_list_state.dart';

class BreweryListBloc extends Bloc<BreweryListEvent, BreweryListState> {
  final GetBreweriesUseCase getBreweriesUseCase;
  final SearchBreweriesUseCase searchBreweriesUseCase;
  final GeolocatorService geolocatorService = GeolocatorService();

  Position? _userPosition;

  BreweryListBloc({
    required this.getBreweriesUseCase,
    required this.searchBreweriesUseCase,
  }) : super(const BreweryListInitial()) {
    on<BreweryListFetch>(_onFetch, transformer: droppable());
    on<BreweryListLoadMore>(_onLoadMore, transformer: droppable());
    on<BreweryListRefresh>(_onRefresh, transformer: droppable());
    on<BreweryListSortByDistance>(_onSortByDistance);
    on<BreweryListSearch>(_onSearch);
    on<BreweryListClearSearch>(_onClearSearch);
  }

  Future<List<Brewery>> _getBreweriesWithDistance(
    List<Brewery> breweries,
  ) async {
    try {
      final position = await geolocatorService.getCurrentPosition();

      _userPosition = position;

      return breweries.map((brewery) {
        double? distance;

        if (brewery.latitude != null && brewery.longitude != null) {
          distance = Haversine.calculateDistance(
            userLat: position.latitude,
            userLng: position.longitude,
            breweryLat: brewery.latitude!,
            breweryLng: brewery.longitude!,
          );
        }

        return brewery.copyWith(distance: distance);
      }).toList();
    } on LocationException {
      return breweries;
    } catch (e) {
      throw UnexpectedException('Unexpected error calculating distance: $e');
    }
  }

  Future<void> _onFetch(
    BreweryListFetch event,
    Emitter<BreweryListState> emit,
  ) async {
    emit(const BreweryListLoading());
    try {
      final breweries = await getBreweriesUseCase(
        GetBreweriesParams(page: 1, perPage: AppConstants.pageSize),
      );

      if (breweries.isEmpty) {
        emit(const BreweryListEmpty());
      } else {
        final breweriesWithDistance = await _getBreweriesWithDistance(
          breweries,
        );

        emit(
          BreweryListSuccess(
            breweries: breweriesWithDistance,
            hasReachedMax: breweries.length < AppConstants.pageSize,
            currentPage: 1,
          ),
        );
      }
    } on AppException catch (e) {
      emit(BreweryListError(e.message));
    } catch (e) {
      emit(BreweryListError('Unexpected error: $e'));
    }
  }

  Future<void> _onLoadMore(
    BreweryListLoadMore event,
    Emitter<BreweryListState> emit,
  ) async {
    final state = this.state;
    if (state is! BreweryListSuccess) return;
    if (state.hasReachedMax) return;

    try {
      final nextPage = state.currentPage + 1;
      final breweries = await getBreweriesUseCase(
        GetBreweriesParams(page: nextPage, perPage: AppConstants.pageSize),
      );

      if (breweries.isEmpty) {
        emit(state.copyWith(hasReachedMax: true));
      } else {
        final breweriesWithDistance = await _getBreweriesWithDistance(
          breweries,
        );

        emit(
          BreweryListSuccess(
            breweries: List.of(state.breweries)..addAll(breweriesWithDistance),
            hasReachedMax: breweries.length < AppConstants.pageSize,
            currentPage: nextPage,
          ),
        );
      }
    } on AppException catch (e) {
      emit(BreweryListError(e.message));
    }
  }

  Future<void> _onRefresh(
    BreweryListRefresh event,
    Emitter<BreweryListState> emit,
  ) async {
    try {
      final breweries = await getBreweriesUseCase(
        GetBreweriesParams(page: 1, perPage: AppConstants.pageSize),
      );

      if (breweries.isEmpty) {
        emit(const BreweryListEmpty());
      } else {
        final breweriesWithDistance = await _getBreweriesWithDistance(
          breweries,
        );

        emit(
          BreweryListSuccess(
            breweries: breweriesWithDistance,
            hasReachedMax: breweries.length < AppConstants.pageSize,
            currentPage: 1,
          ),
        );
      }
    } on AppException catch (e) {
      emit(BreweryListError(e.message));
    }
  }

  Future<void> _onSortByDistance(
    BreweryListSortByDistance event,
    Emitter<BreweryListState> emit,
  ) async {
    final state = this.state;
    if (state is! BreweryListSuccess) return;

    try {
      final position =
          _userPosition ?? await geolocatorService.getCurrentPosition();

      _userPosition = position;

      final sortedBreweries = List.of(state.breweries);
      sortedBreweries.sort((a, b) {
        if (a.distance == null && b.distance == null) return 0;
        if (a.distance == null) return 1;
        if (b.distance == null) return -1;
        return a.distance!.compareTo(b.distance!);
      });

      emit(
        BreweryListSuccess(
          breweries: sortedBreweries,
          hasReachedMax: state.hasReachedMax,
          currentPage: state.currentPage,
        ),
      );
    } on LocationException catch (e) {
      emit(BreweryListError(e.message));
    } catch (e) {
      emit(BreweryListError('Error sorting by distance: $e'));
    }
  }

  Future<void> _onSearch(
    BreweryListSearch event,
    Emitter<BreweryListState> emit,
  ) async {
    if (event.query.isEmpty) {
      add(const BreweryListFetch());
      return;
    }

    emit(const BreweryListLoading());
    try {
      final breweries = await searchBreweriesUseCase(
        SearchBreweriesParams(query: event.query),
      );

      if (breweries.isEmpty) {
        emit(const BreweryListEmpty());
      } else {
        final breweriesWithDistance = await _getBreweriesWithDistance(
          breweries,
        );

        emit(
          BreweryListSuccess(
            breweries: breweriesWithDistance,
            hasReachedMax: true,
            currentPage: 1,
          ),
        );
      }
    } on AppException catch (e) {
      emit(BreweryListError(e.message));
    }
  }

  Future<void> _onClearSearch(
    BreweryListClearSearch event,
    Emitter<BreweryListState> emit,
  ) async {
    add(const BreweryListFetch());
  }
}
