import 'package:forest_brewery_test/features/breweries/domain/entities/brewery.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brewery_dto.g.dart';

@JsonSerializable()
class BreweryDto {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'brewery_type')
  final String? breweryType;

  @JsonKey(name: 'address_1')
  final String? address1;

  @JsonKey(name: 'address_2')
  final String? address2;

  @JsonKey(name: 'address_3')
  final String? address3;

  @JsonKey(name: 'city')
  final String? city;

  @JsonKey(name: 'state_province')
  final String? stateProvince;

  @JsonKey(name: 'postal_code')
  final String? postalCode;

  @JsonKey(name: 'country')
  final String? country;

  @JsonKey(name: 'longitude')
  final double? longitude;

  @JsonKey(name: 'latitude')
  final double? latitude;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'website_url')
  final String? websiteUrl;

  @JsonKey(name: 'state')
  final String? state;

  @JsonKey(name: 'street')
  final String? street;

  BreweryDto({
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

  factory BreweryDto.fromJson(Map<String, dynamic> json) =>
      _$BreweryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BreweryDtoToJson(this);

  Brewery toDomain() {
    return Brewery(
      id: id,
      name: name,
      breweryType: breweryType,
      address1: address1,
      address2: address2,
      address3: address3,
      city: city,
      stateProvince: stateProvince,
      postalCode: postalCode,
      country: country,
      longitude: longitude,
      latitude: latitude,
      phone: phone,
      websiteUrl: websiteUrl,
      state: state,
      street: street,
    );
  }
}
