import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather/feature/common/extentions/build_context.dart';

@RoutePage()
class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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
          ],
        ),
      ),
    );
  }
}
