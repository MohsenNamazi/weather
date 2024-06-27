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
    final screenWidth = context.width;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(Spacing.s4).copyWith(
            left: screenWidth / 3 + Spacing.s4,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n.humidity(selectedDay.first.main.humidity)),
                    const SizedBox(height: Spacing.s4),
                    Text(l10n.pressure(selectedDay.first.main.pressure)),
                    const SizedBox(height: Spacing.s4),
                    Text(l10n.wind(selectedDay.first.wind.speed)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    Text(
                      selectedDay.first.main.temp.toString(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        ListView(
          padding: const EdgeInsets.all(Spacing.s4)
              .copyWith(right: screenWidth * 2 / 3),
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
