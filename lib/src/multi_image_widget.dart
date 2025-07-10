import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../multi_image_provider.dart';
import 'cache/image_cache_manager.dart';

/// A widget that displays an image with a fixed aspect ratio.
///
/// Supports multiple image sources such as asset, network, and SVG (asset/network).
/// Provides border radius, placeholder, error widget, and decoration options.
class MultiImage extends StatelessWidget {
  /// Creates a [MultiImage] widget.
  const MultiImage({
    super.key,

    /// The path to the image (either asset path or network URL).
    required this.imagePath,

    /// The type of image source.
    this.imageType = ImageType.asset,

    /// The aspect ratio to maintain (width / height).
    this.aspectRatio = 1.0,

    /// The desired width of the image (height is calculated using aspect ratio).
    this.width,

    /// How the image should be inscribed into the space allocated.
    this.fit = BoxFit.cover,

    /// Optional border radius for rounding corners.
    this.borderRadius = BorderRadius.zero,

    /// Placeholder widget shown while loading.
    this.placeholder,

    /// Widget shown in case of error.
    this.errorWidget,

    /// Optional [BoxDecoration] to wrap the image.
    this.decoration,
  });

  /// The image path to be loaded.
  final String imagePath;

  /// The type of image to load.
  final ImageType imageType;

  /// Aspect ratio to maintain (width / height).
  final double aspectRatio;

  /// Optional fixed width for the image.
  final double? width;

  /// BoxFit for the image rendering.
  final BoxFit fit;

  /// Border radius to apply to the image.
  final BorderRadius borderRadius;

  /// Placeholder widget while image is loading.
  final Widget? placeholder;

  /// Error widget if image fails to load.
  final Widget? errorWidget;

  /// Optional decoration for the image container.
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

    imageWidget = ClipRRect(borderRadius: borderRadius, child: imageWidget);

    final finalWidget = decoration == null
        ? imageWidget
        : Container(decoration: decoration, child: imageWidget);

    if (width != null) {
      return SizedBox(
        width: width,
        child: AspectRatio(aspectRatio: aspectRatio, child: finalWidget),
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
