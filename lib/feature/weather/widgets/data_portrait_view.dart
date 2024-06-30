part of '../weather_screen.dart';

class _DataPortraitView extends StatelessWidget {
  const _DataPortraitView({
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
    final bottomPadding = context.bottomPadding;
    final appUnit = inject<UnitsCubit>().state;

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(Spacing.s4),
            children: [
              Text(selectedDay.first.weather.first.main),
              const SizedBox(height: Spacing.s4),
              AspectRatio(
                aspectRatio: 4 / 3,
                child: ColoredBox(
                  color: Colors.black.withOpacity(.5),
                  child: FittedBox(
                    child: WeatherImage(
                      iconId: selectedDay.first.weather.first.icon,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: Spacing.s4),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...selectedDay.map(
                      (weatherData) => Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: Spacing.s2),
                        child: Column(
                          children: [
                            Text(
                              DateFormat('HH:mm').format(weatherData.dateTime),
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
                  ],
                ),
              ),
              const SizedBox(height: Spacing.s4),
              Text(l10n.humidity(selectedDay.first.main.humidity)),
              const SizedBox(height: Spacing.s4),
              Text(l10n.pressure(selectedDay.first.main.pressure)),
              const SizedBox(height: Spacing.s4),
              Text(l10n.wind(selectedDay.first.wind.speed)),
            ],
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
                ...data.groupedDays.map((groupedDay) {
                  final isTileSeleced = groupedDay.first.dateTime.day ==
                      selectedDay.first.dateTime.day;
                  return _DailyWeatherTile(
                    groupedDay,
                    onTapNotifier: onTapNotifier,
                    isSelected: isTileSeleced,
                  );
                }),
                const SizedBox(width: Spacing.s2),
              ],
            ),
          ),
        )
      ],
    );
  }
}
