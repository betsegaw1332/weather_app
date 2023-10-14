
import 'package:final_assesment/data/data.dart';
import 'package:final_assesment/domain/domain.dart';
import 'package:final_assesment/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_assesment/presentation/blocs/blocs.dart';

class WeatherBloc extends Bloc<WeatherEvent,WeatherState>{

  final APIWeatherRepository _apiWeatherRepository;

  WeatherBloc():_apiWeatherRepository=serviceLocator<APIWeatherRepositoryImpl>(),super(WeatherInit()){
    on<FetchWeatherData>(_onFethWeatherData);
  }



  _onFethWeatherData(FetchWeatherData event,Emitter emit) async{

    print("GETTING CALLED #########");
      emit(WeatherInProgress());
    try {
      final apiData = await _apiWeatherRepository.getWeatherData(weatherRequest: event.apiWeatherRequestData);
      print(apiData);
      if(apiData.error!=null){
        print("ERROR HAPPEND #### ${apiData.error!.message}");
        emit (WeatherFailed(message: apiData.error!.message));
      }

      print("HERE IS THE RESPONSE OF THE DATA####${apiData.data!.weather[2]}");
      
    } catch (e) {
        emit (WeatherFailed(message:e.toString()));
    }

  }
}