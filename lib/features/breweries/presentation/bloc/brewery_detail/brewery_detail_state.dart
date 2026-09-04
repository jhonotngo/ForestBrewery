import 'package:equatable/equatable.dart';
import 'package:forest_brewery_test/features/breweries/domain/entities/brewery.dart';

sealed class BreweryDetailState extends Equatable {
  const BreweryDetailState();

  @override
  List<Object?> get props => [];
}

class BreweryDetailInitial extends BreweryDetailState {
  const BreweryDetailInitial();
}

class BreweryDetailLoading extends BreweryDetailState {
  const BreweryDetailLoading();
}

class BreweryDetailSuccess extends BreweryDetailState {
  final Brewery brewery;

  const BreweryDetailSuccess(this.brewery);

  @override
  List<Object?> get props => [brewery];
}

class BreweryDetailError extends BreweryDetailState {
  final String message;

  const BreweryDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
