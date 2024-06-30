import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/data/repository/open_weather_repo.dart';
import 'package:weather/feature/weather/cubit/units_cubit.dart';
import 'package:weather/feature/weather/cubit/weather_screen_cubit.dart';
import 'package:weather/feature/weather/weather_screen.dart';
import 'package:weather/data/service/geo_locator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/model/weather_model.dart';
import '../../mocks/geo_locator_mock.dart';
import '../../mocks/units_cubit_mock.dart';
import '../../mocks/weather_screen_cubit_mock.dart';

final getIt = GetIt.instance;

void main() {
  setUpAll(() {
    // Register fallback values for generics
    registerFallbackValue(const WeatherScreenState.initial());
    registerFallbackValue(Units.metric);
  });

  setUp(() {
    // Clear the existing registrations in GetIt
    getIt.reset();

    // Initialize mock dependencies
    final weatherScreenCubitMock = WeatherScreenCubitMock();
    final unitsCubitMock = UnitsCubitMock();
    final geoLocatorMock = GeoLocatorMock();

    // Register mock dependencies in GetIt
    getIt
      ..registerLazySingleton<WeatherScreenCubit>(() => weatherScreenCubitMock)
      ..registerLazySingleton<UnitsCubit>(() => unitsCubitMock)
      ..registerLazySingleton<GeoLocator>(() => geoLocatorMock);

    when(() => unitsCubitMock.state).thenReturn(Units.imperial);
    when(() => geoLocatorMock.getLocation())
        .thenAnswer((_) async => UserLocation(lat: 0.0, lon: 0.0));
  });

  tearDown(() {
    // Reset GetIt after each test
    getIt.reset();
  });

  Widget createTestableWidget(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherScreenCubit>(
            create: (_) => getIt<WeatherScreenCubit>()),
        BlocProvider<UnitsCubit>(create: (_) => getIt<UnitsCubit>()),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        home: child,
      ),
    );
  }

  testWidgets('WeatherScreen shows initial view', (WidgetTester tester) async {
    final mockWeatherScreenCubit = getIt<WeatherScreenCubit>();
    when(() => mockWeatherScreenCubit.state)
        .thenReturn(const WeatherScreenState.initial());

    await tester.pumpWidget(createTestableWidget(const WeatherScreen()));

    await tester.pumpAndSettle();

    final l10n =
        AppLocalizations.of(tester.element(find.byType(WeatherScreen)))!;

    expect(find.text(l10n.welcome), findsOneWidget);
  });

  testWidgets('WeatherScreen shows loading view', (WidgetTester tester) async {
    final mockWeatherScreenCubit = getIt<WeatherScreenCubit>();
    when(() => mockWeatherScreenCubit.state)
        .thenReturn(const WeatherScreenState.loading());

    await tester.pumpWidget(createTestableWidget(const WeatherScreen()));

    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('WeatherScreen shows error view', (WidgetTester tester) async {
    final mockWeatherScreenCubit = getIt<WeatherScreenCubit>();
    when(() => mockWeatherScreenCubit.state)
        .thenReturn(const WeatherScreenState.error());

    await tester.pumpWidget(createTestableWidget(const WeatherScreen()));

    await tester.pump();

    final l10n =
        AppLocalizations.of(tester.element(find.byType(WeatherScreen)))!;

    expect(find.text(l10n.retry), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('WeatherScreen shows data view', (WidgetTester tester) async {
    final mockWeatherScreenCubit = getIt<WeatherScreenCubit>();

    final weatherData = await WeatherModelFake.getData();

    when(() => mockWeatherScreenCubit.state)
        .thenReturn(WeatherScreenState.data(weatherData));

    await tester.pumpWidget(createTestableWidget(const WeatherScreen()));

    await tester.pump();

    final l10n =
        AppLocalizations.of(tester.element(find.byType(WeatherScreen)))!;

    expect(find.byType(Text), findsWidgets);
    expect(find.text(l10n.tuesdayShort), findsOneWidget);
    expect(find.text(l10n.humidity(69)), findsOneWidget);
    expect(find.text(l10n.pressure(1015)), findsOneWidget);
    expect(find.text(l10n.wind(.62)), findsOneWidget);
    expect(find.text('Rain'), findsOneWidget);
    expect(find.text('296.76 ${Units.imperial.sym}'), findsOneWidget);
  });
}
