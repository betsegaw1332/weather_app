import 'package:final_assesment/domain/domain.dart';
import 'package:final_assesment/presentation/Screen/weather_screen/weather_screen.dart';
import 'package:final_assesment/presentation/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseCity extends StatefulWidget {
  const ChooseCity({super.key});

  @override
  State<ChooseCity> createState() => _ChooseCityState();
}

class _ChooseCityState extends State<ChooseCity> {
  final _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F4FF),
      appBar: AppBar(
        leading: const SizedBox(),
        centerTitle: true,
        title: const Text(
          'Choose a city',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF211772),
            fontSize: 18,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              Row(
                children: [
                  Container(
                    width: 265,
                    height: 48,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: TextField(
                      autofocus: true,
                      controller: _textEditingController,
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      context.read<WeatherBloc>().add(FetchWeatherData(
                          apiWeatherRequestData: APIWeatherRequest(
                              queryString: _textEditingController.text)));
                    },
                    child: Container(
                        width: 84,
                        height: 36,
                        decoration: ShapeDecoration(
                          color: Color(0xFFFFBA25),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Search',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        )),
                  )
                ],
              ),
              SizedBox(height: 28),
              BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
                if (state is WeatherInProgress) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is WeatherSuccess) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'My Fav Cities',
                        style: TextStyle(
                          color: Color(0xFF211772),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 0.07,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: ListView.builder(
                            itemCount: 1,
                            itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                               WeatherScreen(weatherData: state.weatherData,),
                                        )),
                                    child: Container(
                                      width: 343,
                                      height: 76,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              state.weatherData.cityName,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                color: Color(0xFF575757),
                                                fontSize: 16,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w500,
                                                height: 1,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 50,
                                          ),
                                          Text(
                                            '${state.weatherData.dailyWeatherCondition.first.maxTemperature}°',
                                            style: const TextStyle(
                                              color: Color(0xFF211772),
                                              fontSize: 18,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Image.network(
                                            state
                                                .weatherData
                                                .dailyWeatherCondition
                                                .first
                                                .weatherIconUrl,
                                            height: 40,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                      )
                    ],
                  );
                } else if (state is WeatherFailed) {
                  return const Center(
                    child: Text('Failed to get weather data!'),
                  );
                }
                return Container();
              })
            ],
          ),
        ),
      ),
    );
  }
}
