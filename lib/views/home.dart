// import 'package:flutter/material.dart';
// import 'package:weatherapp/services/weather_service.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final TextEditingController _controller = TextEditingController();
//   String _city = '';
//   String _temperature = '';
//   String _description = '';
//   String _pressure = '';
//   String _humidity = '';
//   String _feels_like = '';
//   String _wind = '';
//   String _icon = '';
//   bool _loading = false;
//   final WeatherService _weatherService = WeatherService();

//   void _getWeather() async {
//     setState(() {
//       _loading = true;
//     });
//     try {
//       final weatherModel = await _weatherService.fetchWeather(_city);
//       setState(() {
//         _icon = weatherModel.weather?.first.icon ?? '01d';
//         _temperature =
//             '${weatherModel.main?.feelsLike?.toStringAsFixed(1) ?? 'N/A'}°F';

//         _description =
//             weatherModel.weather?.first.description ?? 'No description';

//         _controller.clear();
//       });
//     } catch (e) {
//       setState(() {
//         _temperature = 'Error';
//         _description = 'Could not fetch weather data';
//       });
//     } finally {
//       setState(() {
//         _loading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     String iconUrl = 'https://openweathermap.org/img/wn/$_icon@2x.png';

//     return Scaffold(
//       backgroundColor: Colors.blueAccent,
//       appBar: AppBar(
//         backgroundColor: Colors.blueAccent,
//         title: const Text(
//           'Weather App',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 24,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _controller,
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         hintText: 'Search for a city...',
//                         hintStyle: TextStyle(
//                           color: Colors.grey[600],
//                           fontSize: 16,
//                           fontStyle: FontStyle.italic,
//                         ),
//                         prefixIcon:
//                             Icon(Icons.search, color: Colors.blueAccent),
//                         contentPadding: EdgeInsets.symmetric(vertical: 10.0),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(30.0),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       style: TextStyle(
//                         color: Colors.black87,
//                         fontSize: 18,
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _city = value;
//                         });
//                       },
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   ElevatedButton(
//                     onPressed: _getWeather,
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.all(15.0),
//                       shape: CircleBorder(),
//                       backgroundColor: Colors.white,
//                       foregroundColor: Colors.blueAccent,
//                     ),
//                     child: _loading
//                         ? CircularProgressIndicator(color: Colors.blueAccent)
//                         : Icon(Icons.search, color: Colors.blueAccent),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Text(
//                 _city,
//                 style: TextStyle(fontSize: 36, color: Colors.white),
//               ),
//               SizedBox(height: 20),
//               if (_icon.isNotEmpty) // Show the icon if available
//                 Image.network(
//                   iconUrl,
//                   width: 100,
//                   height: 100,
//                   color: Colors.white,
//                 ),
//               SizedBox(height: 20),
//               Text(
//                 _temperature,
//                 style: TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.white),
//               ),
//               Text(
//                 _description,
//                 style: TextStyle(fontSize: 24, color: Colors.white),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:weatherapp/services/weather_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  String _city = '';
  String _temperature = '';
  String _description = '';
  String _icon = '';
  String _pressure = '';
  String _humidity = '';
  String _feelsLike = '';
  String _windSpeed = '';
  bool _loading = false;
  final WeatherService _weatherService = WeatherService();

  void _getWeather() async {
    setState(() {
      _loading = true;
    });
    try {
      final weatherModel = await _weatherService.fetchWeather(_city);
      setState(() {
        _icon = weatherModel.weather?.first.icon ?? '01d';
        _temperature =
            '${weatherModel.main?.temp?.toStringAsFixed(1) ?? 'N/A'}°F';
        _description =
            weatherModel.weather?.first.description ?? 'No description';
        _pressure = '${weatherModel.main?.pressure ?? 'N/A'} hPa';
        _humidity = '${weatherModel.main?.humidity ?? 'N/A'}%';
        _feelsLike =
            '${weatherModel.main?.feelsLike?.toStringAsFixed(1) ?? 'N/A'}°F';
        _windSpeed =
            '${weatherModel.wind?.speed?.toStringAsFixed(1) ?? 'N/A'} m/s';
        _controller.clear();
      });
    } catch (e) {
      setState(() {
        _temperature = 'Error';
        _description = 'Could not fetch weather data';
        _pressure = '';
        _humidity = '';
        _feelsLike = '';
        _windSpeed = '';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String iconUrl = 'https://openweathermap.org/img/wn/$_icon@2x.png';

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Weather App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search for a city...',
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                        ),
                        prefixIcon:
                            Icon(Icons.search, color: Colors.blueAccent),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _city = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _getWeather,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blueAccent,
                    ),
                    child: _loading
                        ? CircularProgressIndicator(color: Colors.blueAccent)
                        : Icon(Icons.search, color: Colors.blueAccent),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                _city,
                style: TextStyle(fontSize: 36, color: Colors.white),
              ),
              SizedBox(height: 20),
              if (_icon.isNotEmpty)
                Image.network(
                  iconUrl,
                  width: 100,
                  height: 100,
                  color: Colors.white,
                ),
              SizedBox(height: 20),
              Text(
                _temperature,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Text(
                _description,
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                'Feels Like: $_feelsLike',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                'Pressure: $_pressure',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                'Humidity: $_humidity',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                'Wind Speed: $_windSpeed',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
