import 'package:equatable/equatable.dart';

class Brewery extends Equatable {
  final String id;
  final String name;
  final String? breweryType;
  final String? address1;
  final String? address2;
  final String? address3;
  final String? city;
  final String? stateProvince;
  final String? postalCode;
  final String? country;
  final double? longitude;
  final double? latitude;
  final String? phone;
  final String? websiteUrl;
  final String? state;
  final String? street;

  const Brewery({
    required this.id,
    required this.name,
    this.breweryType,
    this.address1,
    this.address2,
    this.address3,
    this.city,
    this.stateProvince,
    this.postalCode,
    this.country,
    this.longitude,
    this.latitude,
    this.phone,
    this.websiteUrl,
    this.state,
    this.street,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    breweryType,
    address1,
    address2,
    address3,
    city,
    stateProvince,
    postalCode,
    country,
    longitude,
    latitude,
    phone,
    websiteUrl,
    state,
    street,
  ];
}
