import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../multi_image_provider.dart';
import 'cache/image_cache_manager.dart';

class MultiImage extends StatelessWidget {
  const MultiImage({
    super.key,
    required this.imagePath,
    this.imageType = ImageType.asset,
    this.aspectRatio = 1.0,
    this.width,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
    this.placeholder,
    this.errorWidget,
    this.decoration,
  });

  final String imagePath;
  final ImageType imageType;
  final double aspectRatio;
  final double? width;
  final BoxFit fit;
  final BorderRadius borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    switch (imageType) {
      case ImageType.asset:
        imageWidget = Image.asset(imagePath, fit: fit);
        break;

      case ImageType.network:
        imageWidget = CachedNetworkImage(
          imageUrl: imagePath,
          fit: fit,
          placeholder: (context, url) =>
              placeholder ?? const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) =>
              errorWidget ?? const Icon(Icons.error),
        );
        break;

      case ImageType.svgAsset:
        imageWidget = SvgPicture.asset(imagePath, fit: fit);
        break;

      case ImageType.svgNetwork:
        imageWidget = FutureBuilder<File>(
          future: ImageCacheManager.instance.getSingleFile(imagePath),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return placeholder ??
                  const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || !snapshot.hasData) {
              return errorWidget ?? const Icon(Icons.error);
            } else {
              return SvgPicture.file(snapshot.data!, fit: fit);
            }
          },
        );
        break;
    }

    imageWidget = ClipRRect(
      borderRadius: borderRadius,
      child: imageWidget,
    );

    final finalWidget = decoration == null
        ? imageWidget
        : Container(decoration: decoration, child: imageWidget);

    if (width != null) {
      return SizedBox(
        width: width,
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: finalWidget,
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        return SizedBox(
          width: maxWidth,
          height: maxWidth / aspectRatio,
          child: finalWidget,
        );
      },
    );
  }
}