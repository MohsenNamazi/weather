import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/data/repository/open_weather_repo.dart';

class UnitsCubit extends Cubit<Units> {
  UnitsCubit() : super(Units.metric);

  void toggleUnits() => emit(switch (state) {
        Units.imperial => Units.metric,
        Units.metric => Units.imperial,
      });
}
