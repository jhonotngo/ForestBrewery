import 'package:dio/dio.dart';
import 'package:forest_brewery_test/core/exceptions/app_exceptions.dart';
import 'package:forest_brewery_test/features/breweries/data/datasources/brewery_remote_datasource.dart';
import 'package:forest_brewery_test/features/breweries/data/models/brewery_dto.dart';

class BreweryRemoteDataSourceImpl implements BreweryRemoteDataSource {
  final Dio dio;

  BreweryRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<BreweryDto>> getBreweries({
    required int page,
    required int perPage,
  }) async {
    try {
      final response = await dio.get(
        '/breweries',
        queryParameters: {'page': page, 'per_page': perPage},
      );

      return _parseBreweryList(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw UnexpectedException('Unexpected error: $e');
    }
  }

  @override
  Future<BreweryDto> getBreweryDetail({required String id}) async {
    try {
      final response = await dio.get('/breweries/$id');

      if (response.data is! Map<String, dynamic>) {
        throw ParseException('Invalid response format');
      }

      return BreweryDto.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw UnexpectedException('Unexpected error: $e');
    }
  }

  @override
  Future<List<BreweryDto>> searchBreweries({required String query}) async {
    try {
      final response = await dio.get(
        '/breweries/search',
        queryParameters: {'query': query},
      );

      return _parseBreweryList(response.data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw UnexpectedException('Unexpected error: $e');
    }
  }

  List<BreweryDto> _parseBreweryList(dynamic data) {
    if (data is! List) {
      throw ParseException('Expected list of breweries');
    }

    try {
      return (data)
          .map((item) => BreweryDto.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ParseException('Error parsing breweries list: $e');
    }
  }

  Never _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        throw NetworkException('Connection timeout');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          throw NotFoundException('Resource not found');
        } else if (statusCode != null && statusCode >= 500) {
          throw ServerException('Server error', statusCode);
        } else {
          throw ServerException('Error: $statusCode');
        }
      case DioExceptionType.cancel:
        throw NetworkException('Request cancelled');
      case DioExceptionType.badCertificate:
        throw NetworkException('Bad certificate');
      case DioExceptionType.connectionError:
        throw NetworkException('Connection error');
      case DioExceptionType.unknown:
        throw UnexpectedException('Unknown error: ${e.message}');
      case DioExceptionType.transformTimeout:
        throw NetworkException('Connection timeout');
    }
  }
}
