import 'package:bloc_test/bloc_test.dart';
import 'package:weather/data/repository/open_weather_repo.dart';
import 'package:weather/feature/weather/cubit/units_cubit.dart';

class UnitsCubitMock extends MockCubit<Units> implements UnitsCubit {}
