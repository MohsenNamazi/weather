import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/app_router.dart';
import 'package:weather/data/network/open_weather/open_weather.dart';

final _getIt = GetIt.instance;

abstract class Injector {
  Injector._();

  static void init() {
    _getIt
      ..registerLazySingleton(
        () => AppRouter(),
      )
      ..registerLazySingleton(
        () => Dio(),
      )
      ..registerLazySingleton(
        () => OpenWeather(inject()),
      );
  }

  static T get<T extends Object>({
    String? name,
    dynamic param1,
    dynamic param2,
  }) {
    return inject(name: name, param1: param1, param2: param2);
  }
}

T inject<T extends Object>({
  String? name,
  dynamic param1,
  dynamic param2,
}) {
  try {
    return _getIt.get<T>(instanceName: name, param1: param1, param2: param2);
  } catch (e) {
    throw InjectorException(type: T, name: name, error: e);
  }
}

Future<T> injectAsync<T extends Object>({
  String? name,
  dynamic param1,
  dynamic param2,
}) async {
  try {
    return await _getIt.getAsync<T>(
      instanceName: name,
      param1: param1,
      param2: param2,
    );
  } catch (e) {
    throw InjectorException(type: T, name: name, error: e);
  }
}

class InjectorException {
  InjectorException({
    required Type type,
    String? name,
    Object? error,
  }) {
    debugPrint('Injector error: $type $name $error');
  }
}

// extension on GetIt {
//   void registerLazyBlocSingleton<B extends BlocBase<Object>>(
//     B Function() create,
//   ) {
//     registerLazySingleton(create, dispose: (bloc) => bloc.close());
//   }
// }
