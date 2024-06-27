part of '../weather_screen.dart';

class _DataView extends StatelessWidget {
  const _DataView({
    required this.data,
    required this.onLoadWeather,
  });

  final WeatherModel data;
  final RefreshCallback onLoadWeather;
  @override
  Widget build(BuildContext context) {
    final bottomPadding = context.bottomPadding;
    return Scaffold(
      appBar: AppBar(
        title: Text('${data.city.name} - ${data.list.first.dayName(context)}'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: onLoadWeather,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: bottomPadding + Spacing.s4,
                  top: Spacing.s4,
                ),
                child: Row(
                  children: [
                    const SizedBox(width: Spacing.s2),
                    ...data.list.map((e) => _DailyWeatherTile(e)),
                    const SizedBox(width: Spacing.s2),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DailyWeatherTile extends StatelessWidget {
  const _DailyWeatherTile(this.weatherData);

  final WeatherData weatherData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.s2),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.s2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(weatherData.dayShortName(context)),
              Text('${weatherData.main.tempMax} / ${weatherData.main.tempMin}')
            ],
          ),
        ),
      ),
    );
  }
}
