import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/feature/common/extentions/build_context.dart';
import 'package:weather/feature/weather/cubit/weather_screen_cubit.dart';

@RoutePage()
class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<WeatherScreenCubit, WeatherScreenState>(
      listener: (BuildContext context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(l10n?.helloWorld ?? ''),
              ],
            ),
          ),
        );
      },
    );
  }
}
