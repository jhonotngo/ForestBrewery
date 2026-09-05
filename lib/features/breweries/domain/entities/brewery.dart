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
  final double? distance;

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
    this.distance,
  });

  Brewery copyWith({
    String? id,
    String? name,
    String? breweryType,
    String? address1,
    String? address2,
    String? address3,
    String? city,
    String? stateProvince,
    String? postalCode,
    String? country,
    double? longitude,
    double? latitude,
    String? phone,
    String? websiteUrl,
    String? state,
    String? street,
    double? distance,
  }) {
    return Brewery(
      id: id ?? this.id,
      name: name ?? this.name,
      breweryType: breweryType ?? this.breweryType,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      address3: address3 ?? this.address3,
      city: city ?? this.city,
      stateProvince: stateProvince ?? this.stateProvince,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      phone: phone ?? this.phone,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      state: state ?? this.state,
      street: street ?? this.street,
      distance: distance ?? this.distance,
    );
  }

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
    distance,
  ];
}
