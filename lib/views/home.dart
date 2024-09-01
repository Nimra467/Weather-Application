import 'package:flutter/material.dart';
import 'package:weatherapp/services/weather_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  final TextEditingController _controller = TextEditingController();
  String _city = '';
  String _temperature = '';
  String _description = '';
  String _icon = '';
  bool _loading = false;
  final WeatherService _weatherService = WeatherService();

  void _getWeather() async {
    setState(() {
      _loading = true;
    });
    try {
      final weatherModel = await _weatherService.fetchWeather(_city);
      setState(() {
        _icon = weatherModel.weather?.first.icon ?? 'icon not found';
        _temperature =
            '${weatherModel.main?.temp?.toStringAsFixed(1) ?? 'N/A'}°';
        _description =
            weatherModel.weather?.first.description ?? 'No description';
      });
    } catch (e) {
      setState(() {
        _temperature = 'Error';
        _description = 'Could not fetch weather data';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter city',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _city = value;
                      });
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: _getWeather,
                    child: _loading
                        ? CircularProgressIndicator()
                        : Icon(Icons.search)),
              ],
            ),
            SizedBox(height: 20),
            Text(
              _temperature,
              style: TextStyle(fontSize: 36),
            ),
            Text(
              _description,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
