import 'package:bloc/bloc.dart';
import 'package:forest_brewery_test/core/exceptions/app_exceptions.dart';
import 'package:forest_brewery_test/features/breweries/domain/usecases/get_brewery_detail_usecase.dart';

import 'brewery_detail_event.dart';
import 'brewery_detail_state.dart';

class BreweryDetailBloc extends Bloc<BreweryDetailEvent, BreweryDetailState> {
  final GetBreweryDetailUseCase getBreweryDetailUseCase;
  final String breweryId;

  BreweryDetailBloc({
    required this.getBreweryDetailUseCase,
    required this.breweryId,
  }) : super(const BreweryDetailInitial()) {
    on<BreweryDetailFetch>(_onFetch);

    add(BreweryDetailFetch(id: breweryId));
  }

  Future<void> _onFetch(
    BreweryDetailFetch event,
    Emitter<BreweryDetailState> emit,
  ) async {
    emit(const BreweryDetailLoading());

    try {
      final brewery = await getBreweryDetailUseCase(
        GetBreweryDetailParams(id: event.id),
      );
      emit(BreweryDetailSuccess(brewery));
    } on AppException catch (e) {
      emit(BreweryDetailError(e.message));
    }
  }
}
