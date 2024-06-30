import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather/data/service/weather_image_service.dart';
import 'package:weather/generated/assets.gen.dart';

class WeatherImage extends StatelessWidget {
  const WeatherImage({
    required this.iconId,
    super.key,
  });

  final String iconId;

  @override
  Widget build(BuildContext context) {
    final imageUrl = WeatherImageService.getUrl(iconId);

    if (kDebugMode) {
      return Image.asset(Assets.testImage.keyName);
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
