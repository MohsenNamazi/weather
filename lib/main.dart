import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/app_router.dart';
import 'package:weather/dependency_injector/injected_bloc_provider.dart';
import 'package:weather/dependency_injector/injector.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather/feature/weather/cubit/weather_screen_cubit.dart';

void main() {
  // initialize the injector
  Injector.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        InjectedBlocProvider<WeatherScreenCubit>(
          onCreate: (bloc) => bloc.loadWeather(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: inject<AppRouter>().config(),
      ),
    );
  }
}
