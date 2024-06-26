import 'package:auto_route/auto_route.dart';
import 'package:weather/feature/weather/weather_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: WeatherRoute.page, initial: true, path: '/weather'),
      ];
}
