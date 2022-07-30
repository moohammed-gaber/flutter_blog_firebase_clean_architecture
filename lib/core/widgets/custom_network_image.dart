import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage(
      {Key? key,
      this.height,
      this.width,
      required this.imageUrl,
      this.fit = BoxFit.cover,
      this.radius = 7})
      : super(key: key);
  final double? height, width;
  final double radius;
  final String imageUrl;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
          width: width, height: height, fit: fit, imageUrl: imageUrl),
    );
  }
}
