import 'package:equatable/equatable.dart';

sealed class BreweryListEvent extends Equatable {
  const BreweryListEvent();

  @override
  List<Object?> get props => [];
}

class BreweryListFetch extends BreweryListEvent {
  const BreweryListFetch();
}

class BreweryListLoadMore extends BreweryListEvent {
  const BreweryListLoadMore();
}

class BreweryListRefresh extends BreweryListEvent {
  const BreweryListRefresh();
}

class BreweryListSortByDistance extends BreweryListEvent {
  const BreweryListSortByDistance();
}
