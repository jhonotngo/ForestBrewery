import 'package:equatable/equatable.dart';
import 'package:forest_brewery_test/features/breweries/domain/entities/brewery.dart';

sealed class BreweryListState extends Equatable {
  const BreweryListState();

  @override
  List<Object?> get props => [];
}

class BreweryListInitial extends BreweryListState {
  const BreweryListInitial();
}

class BreweryListLoading extends BreweryListState {
  const BreweryListLoading();
}

class BreweryListSuccess extends BreweryListState {
  final List<Brewery> breweries;
  final bool hasReachedMax;
  final int currentPage;

  const BreweryListSuccess({
    required this.breweries,
    required this.hasReachedMax,
    required this.currentPage,
  });

  BreweryListSuccess copyWith({
    List<Brewery>? breweries,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return BreweryListSuccess(
      breweries: breweries ?? this.breweries,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [breweries, hasReachedMax, currentPage];
}

class BreweryListError extends BreweryListState {
  final String message;

  const BreweryListError(this.message);

  @override
  List<Object?> get props => [message];
}

class BreweryListEmpty extends BreweryListState {
  const BreweryListEmpty();
}
