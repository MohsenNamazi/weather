import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/data/repository/open_weather_repo.dart'; // Adjust this import if necessary
import 'package:weather/feature/weather/cubit/units_cubit.dart'; // Adjust this import to the actual location of your UnitsCubit

void main() {
  group('UnitsCubit', () {
    late UnitsCubit unitsCubit;

    setUp(() {
      unitsCubit = UnitsCubit();
    });

    tearDown(() {
      unitsCubit.close();
    });

    blocTest<UnitsCubit, Units>(
      'emits [Units.imperial] when toggleUnits is called and initial state is Units.metric',
      build: () => unitsCubit,
      act: (cubit) => cubit.toggleUnits(),
      expect: () => [Units.imperial],
    );

    blocTest<UnitsCubit, Units>(
      'emits [Units.metric] when toggleUnits is called and initial state is Units.imperial',
      build: () {
        unitsCubit.emit(Units.imperial); // Set initial state to Units.imperial
        return unitsCubit;
      },
      act: (cubit) => cubit.toggleUnits(),
      expect: () => [Units.metric],
    );
  });
}
