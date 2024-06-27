part of '../weather_screen.dart';

class _DataView extends StatefulWidget {
  const _DataView({
    required this.data,
    required this.onLoadWeather,
  });

  final WeatherModel data;
  final RefreshCallback onLoadWeather;

  @override
  State<_DataView> createState() => _DataViewState();
}

class _DataViewState extends State<_DataView> {
  late final ValueNotifier<List<WeatherData>> selectedTileNotifier;

  @override
  void initState() {
    selectedTileNotifier = ValueNotifier(widget.data.groupedDays.first);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait = context.isPortrait;

    return ValueListenableBuilder(
      valueListenable: selectedTileNotifier,
      builder: (context, selectedDay, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
                '${widget.data.city.name} - ${selectedDay.first.dayName(context)}'),
            centerTitle: true,
          ),
          body: RefreshIndicator(
            onRefresh: widget.onLoadWeather,
            child: isPortrait
                ? _DataPortraitView(
                    data: widget.data,
                    selectedDay: selectedDay,
                    onTapNotifier: selectedTileNotifier,
                  )
                : _DataLandscapeView(
                    data: widget.data,
                    selectedDay: selectedDay,
                    onTapNotifier: selectedTileNotifier,
                  ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    selectedTileNotifier.dispose();
    super.dispose();
  }
}

class _DailyWeatherTile extends StatefulWidget {
  const _DailyWeatherTile(
    this.groupedDay, {
    required this.onTapNotifier,
    required this.isSelected,
  });

  final List<WeatherData> groupedDay;
  final ValueNotifier<List<WeatherData>> onTapNotifier;
  final bool isSelected;

  @override
  State<_DailyWeatherTile> createState() => _DailyWeatherTileState();
}

class _DailyWeatherTileState extends State<_DailyWeatherTile> {
  late double minTemp;
  late double maxTemp;

  @override
  void initState() {
    setTheMinMaxTemp();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _DailyWeatherTile oldWidget) {
    setTheMinMaxTemp();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.s2),
      child: InkWell(
        onTap: () => widget.onTapNotifier.value = widget.groupedDay,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: widget.isSelected ? Colors.grey : null,
          ),
          child: Padding(
            padding: const EdgeInsets.all(Spacing.s2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.groupedDay.first.dayShortName(context)),
                WeatherImage(
                  iconId: widget.groupedDay.first.weather.first.icon,
                ),
                Text('$maxTemp / $minTemp')
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setTheMinMaxTemp() {
    // Get the min temp of the day
    widget.groupedDay.sort((a, b) => a.main.tempMin.compareTo(b.main.tempMin));
    minTemp = widget.groupedDay.first.main.tempMin;

    // Get the max temp of the day
    widget.groupedDay.sort((a, b) => a.main.tempMax.compareTo(b.main.tempMax));
    maxTemp = widget.groupedDay.last.main.tempMax;
  }
}
