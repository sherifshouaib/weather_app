import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_appmyself/cubits/get_weather_cubit/get_weather_states.dart';
import 'package:weather_appmyself/models/weather_model.dart';
import 'package:weather_appmyself/services/weather_service.dart';
import 'package:weather_appmyself/views/search_view.dart';

class GetWeatherCubit extends Cubit<WeatherState> {
  GetWeatherCubit() : super(WeatherInitialState());
 WeatherModel? weatherModel;
  getWeather({required String cityName}) async {
    try {
       weatherModel =
          await WeatherService(Dio()).getCurrentWeather(cityName: cityName);

      emit(WeatherLoadedState(weatherModel!));
    } catch (e) {
      emit(WeatherFailureState(e.toString()));
    }
  }
}
