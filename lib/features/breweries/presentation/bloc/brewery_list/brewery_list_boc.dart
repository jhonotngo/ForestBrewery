import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:forest_brewery_test/core/exceptions/app_exceptions.dart';
import 'package:forest_brewery_test/core/utils/constanst.dart';
import 'package:forest_brewery_test/features/breweries/domain/usecases/get_breweries_usecase.dart';

import 'brewery_list_event.dart';
import 'brewery_list_state.dart';

class BreweryListBloc extends Bloc<BreweryListEvent, BreweryListState> {
  final GetBreweriesUseCase getBreweriesUseCase;

  BreweryListBloc({required this.getBreweriesUseCase})
    : super(const BreweryListInitial()) {
    on<BreweryListFetch>(_onFetch, transformer: droppable());
    on<BreweryListLoadMore>(_onLoadMore, transformer: droppable());
    on<BreweryListRefresh>(_onRefresh, transformer: droppable());
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
        emit(
          BreweryListSuccess(
            breweries: breweries,
            hasReachedMax: breweries.length < AppConstants.pageSize,
            currentPage: 1,
          ),
        );
      }
    } on AppException catch (e) {
      emit(BreweryListError(e.message));
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
        emit(
          BreweryListSuccess(
            breweries: List.of(state.breweries)..addAll(breweries),
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
        emit(
          BreweryListSuccess(
            breweries: breweries,
            hasReachedMax: breweries.length < AppConstants.pageSize,
            currentPage: 1,
          ),
        );
      }
    } on AppException catch (e) {
      emit(BreweryListError(e.message));
    }
  }
}
