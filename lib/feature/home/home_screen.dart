import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather/data/repository/open_weather_repo.dart';
import 'package:weather/dependency_injector/injector.dart';
import 'package:weather/feature/common/extentions/build_context.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(l10n?.helloWorld ?? ''),
            ElevatedButton(
                onPressed: () async {
                  try {
                    final res = await OpenWeatherRepo(inject()).get5dayForecast(
                      latitude: '48.833618',
                      longitude: '12.960610',
                    );
                    debugPrint(res.toString());
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
                child: const Text('Test weather repo'))
          ],
        ),
      ),
    );
  }
}
