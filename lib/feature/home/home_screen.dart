import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:weather/feature/common/extentions/build_context.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    print(l10n?.helloWorld);
    return Scaffold(
      body: Center(
        child: Text(l10n?.helloWorld ?? ''),
      ),
    );
  }
}
