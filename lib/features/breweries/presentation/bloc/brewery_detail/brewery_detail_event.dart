import 'package:equatable/equatable.dart';

sealed class BreweryDetailEvent extends Equatable {
  const BreweryDetailEvent();

  @override
  List<Object?> get props => [];
}

class BreweryDetailFetch extends BreweryDetailEvent {
  final String id;

  const BreweryDetailFetch({required this.id});

  @override
  List<Object?> get props => [id];
}
