import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/data/model/weather_model/weather_model.dart';
import 'package:weather/data/service/geo_locator.dart';
import 'package:weather/dependency_injector/injector.dart';
import 'package:weather/feature/common/consts/spacing.dart';
import 'package:weather/feature/common/extentions/build_context.dart';
import 'package:weather/feature/weather/cubit/weather_screen_cubit.dart';

@RoutePage()
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    getUserLocation();
    super.initState();
  }

  Future<void> getUserLocation() async {
    final userLocation = await inject<GeoLocator>().getLocation();
    inject<WeatherScreenCubit>().loadWeather(userLocation: userLocation);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherScreenCubit, WeatherScreenState>(
      listener: (BuildContext context, state) {},
      builder: (context, state) {
        return state.when(
          initial: () => const _InitialView(),
          loading: () => const _LoadingView(),
          data: (data) => _DataView(data),
          error: (e, st) => const _ErrorView(),
        );
      },
    );
  }
}

class _InitialView extends StatelessWidget {
  const _InitialView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: Center(
        child: Text(l10n.welcome),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: Spacing.s15,
          width: Spacing.s15,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {},
        child: Text(l10n.retry),
      ),
    );
  }
}

class _DataView extends StatelessWidget {
  const _DataView(this.weatherModel);

  final WeatherModel weatherModel;
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
