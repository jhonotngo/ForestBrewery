// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brewery_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BreweryDto _$BreweryDtoFromJson(Map<String, dynamic> json) => BreweryDto(
  id: json['id'] as String,
  name: json['name'] as String,
  breweryType: json['brewery_type'] as String?,
  address1: json['address_1'] as String?,
  address2: json['address_2'] as String?,
  address3: json['address_3'] as String?,
  city: json['city'] as String?,
  stateProvince: json['state_province'] as String?,
  postalCode: json['postal_code'] as String?,
  country: json['country'] as String?,
  longitude: (json['longitude'] as num?)?.toDouble(),
  latitude: (json['latitude'] as num?)?.toDouble(),
  phone: json['phone'] as String?,
  websiteUrl: json['website_url'] as String?,
  state: json['state'] as String?,
  street: json['street'] as String?,
);

Map<String, dynamic> _$BreweryDtoToJson(BreweryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'brewery_type': instance.breweryType,
      'address_1': instance.address1,
      'address_2': instance.address2,
      'address_3': instance.address3,
      'city': instance.city,
      'state_province': instance.stateProvince,
      'postal_code': instance.postalCode,
      'country': instance.country,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'phone': instance.phone,
      'website_url': instance.websiteUrl,
      'state': instance.state,
      'street': instance.street,
    };
