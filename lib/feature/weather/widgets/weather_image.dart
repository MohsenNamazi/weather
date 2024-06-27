import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather/data/service/weather_image_service.dart';

class WeatherImage extends StatelessWidget {
  const WeatherImage({
    required this.iconId,
    super.key,
  });

  final String iconId;

  @override
  Widget build(BuildContext context) {
    final imageUrl = WeatherImageService.getUrl(iconId);
    return CachedNetworkImage(
      imageUrl: imageUrl,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
