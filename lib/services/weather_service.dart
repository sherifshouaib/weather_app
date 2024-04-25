import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:weather_appmyself/models/weather_model.dart';

class WeatherService {
  final Dio dio;

  WeatherService(this.dio);

  final String baseUrl = 'http://api.weatherapi.com/v1';
  final String apiKey = '8071d9d10fc14140ab8233404241004';

  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try {
      Response response = await dio
          .get('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1');  //I met an exception that was because i 
          // left space between ($baseUrl) and  (/forecast) so be careful
      
      WeatherModel weatherModel = WeatherModel.fromJson(response.data);

      return weatherModel;
    } on DioException catch (e) {
      final String errMessage = e.response?.data['error']['message'] ??
          'oops there was an error,try later';
      throw Exception(errMessage);
    } catch (e) {
      log(e.toString());
      throw Exception('oops there was an error, try later');
    }
  }
}
