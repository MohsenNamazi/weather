part of '../weather_screen.dart';

class _DataLandscapeView extends StatelessWidget {
  const _DataLandscapeView({
    required this.selectedDay,
    required this.data,
    required this.onTapNotifier,
  });

  final WeatherModel data;
  final List<WeatherData> selectedDay;
  final ValueNotifier<List<WeatherData>> onTapNotifier;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final appUnit = inject<UnitsCubit>().state;

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(Spacing.s4),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Center(child: Text(selectedDay.first.weather.first.main)),
                    const SizedBox(height: Spacing.s4),
                    Wrap(
                      children: [
                        Text(l10n.humidity(selectedDay.first.main.humidity)),
                        const SizedBox(width: Spacing.s4),
                        Text(l10n.pressure(selectedDay.first.main.pressure)),
                        const SizedBox(width: Spacing.s4),
                        Text(l10n.wind(selectedDay.first.wind.speed)),
                      ],
                    ),
                    const SizedBox(height: Spacing.s4),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: selectedDay
                            .map(
                              (weatherData) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Spacing.s2),
                                child: Column(
                                  children: [
                                    Text(
                                      DateFormat('HH:mm')
                                          .format(weatherData.dateTime),
                                    ),
                                    const SizedBox(
                                      height: Spacing.s1,
                                    ),
                                    Text(
                                      '${weatherData.main.temp} ${appUnit.sym}',
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Spacing.s40,
                child: ColoredBox(
                  color: Colors.black.withOpacity(.5),
                  child: FittedBox(
                    child: WeatherImage(
                      iconId: selectedDay.first.weather.first.icon,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: Spacing.s4),
        Row(
          children: [
            ...data.groupedDays.map((groupedDay) {
              final isTileSeleced = groupedDay.first.dateTime.day ==
                  selectedDay.first.dateTime.day;
              return _DailyWeatherTile(
                groupedDay,
                onTapNotifier: onTapNotifier,
                isSelected: isTileSeleced,
              );
            }),
          ],
        )
      ],
    );
  }
}
