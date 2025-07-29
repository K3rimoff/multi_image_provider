import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:multi_image_provider/multi_image_provider.dart';

/// A versatile widget that displays an image with robust sizing options.
///
/// This widget supports multiple image sources: local assets (PNG, JPG, SVG)
/// and network URLs (PNG, JPG, SVG). It provides caching for network images,
/// including SVGs, via a [FutureBuilder].
///
/// The sizing logic is highly flexible:
/// 1. If both [width] and [height] are provided, they are used directly,
///    and [aspectRatio] is ignored.
/// 2. If [aspectRatio] is provided, it will be maintained. If [width] or [height]
///    is also provided, the other dimension will be calculated automatically.
/// 3. If only [width] or [height] is provided, that single dimension is fixed.
class MultiImage extends StatelessWidget {
  /// Creates a [MultiImage] widget.
  const MultiImage({
    super.key,
    required this.imagePath,
    this.imageType = ImageType.asset,
    this.aspectRatio,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
    this.placeholder,
    this.errorWidget,
    this.decoration,
  });

  /// The path to the image, which can be a network URL or a local asset path.
  final String imagePath;

  /// The type of the image source. Defaults to [ImageType.asset].
  final ImageType imageType;

  /// The desired aspect ratio (width / height) to maintain.
  ///
  /// This property is ignored if both [width] and [height] are provided.
  final double? aspectRatio;

  /// The desired width of the image widget.
  final double? width;

  /// The desired height of the image widget.
  final double? height;

  /// How the image should be inscribed into the allocated space.
  /// Defaults to [BoxFit.cover].
  final BoxFit fit;

  /// The border radius to apply for rounding the corners of the image.
  /// Defaults to [BorderRadius.zero].
  final BorderRadius borderRadius;

  /// A widget to display while the image is loading.
  ///
  /// If null, a [CircularProgressIndicator] is shown by default.
  final Widget? placeholder;

  /// A widget to display if an error occurs while loading the image.
  ///
  /// If null, an [Icons.error] icon is shown.
  final Widget? errorWidget;

  /// An optional [BoxDecoration] to apply behind the image container.
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    // Determine the appropriate image widget based on the source type.
    switch (imageType) {
      case ImageType.asset:
        imageWidget = ClipRRect(
          borderRadius: borderRadius,
          child: Image.asset(imagePath, fit: fit),
        );
        break;

      case ImageType.network:
        // Network image with custom cache manager (from ImageCacheManager)
        imageWidget = CachedNetworkImage(
          imageUrl: imagePath,
          fit: fit,
          cacheManager: ImageCacheManager.instance,
          placeholder: (context, url) => _buildPlaceholder(),
          errorWidget: (context, url, error) => _buildErrorWidget(),
          imageBuilder: (context, imageProvider) => ClipRRect(
            borderRadius: borderRadius,
            child: Image(image: imageProvider, fit: fit),
          ),
        );
        break;

      case ImageType.svgAsset:
        imageWidget = ClipRRect(
          borderRadius: borderRadius,
          child: SvgPicture.asset(imagePath, fit: fit),
        );
        break;

      case ImageType.svgNetwork:
        // First cache the SVG file using custom cache manager
        imageWidget = FutureBuilder<File>(
          future: ImageCacheManager.instance.getSingleFile(imagePath),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildPlaceholder();
            } else if (snapshot.hasError || !snapshot.hasData) {
              return _buildErrorWidget();
            } else {
              return ClipRRect(
                borderRadius: borderRadius,
                child: SvgPicture.file(snapshot.data!, fit: fit),
              );
            }
          },
        );
        break;
    }

    // Apply decoration behind image (optional)
    final finalWidget = decoration == null
        ? imageWidget
        : Container(decoration: decoration, child: imageWidget);

    // --- Start of the robust sizing logic ---

    if (width != null && height != null) {
      return SizedBox(width: width, height: height, child: finalWidget);
    }

    if (aspectRatio != null) {
      Widget constrainedChild = AspectRatio(
        aspectRatio: aspectRatio!,
        child: finalWidget,
      );

      if (width != null || height != null) {
        return SizedBox(width: width, height: height, child: constrainedChild);
      }

      return constrainedChild;
    }

    if (width != null) {
      return SizedBox(width: width, child: finalWidget);
    }

    if (height != null) {
      return SizedBox(height: height, child: finalWidget);
    }

    return finalWidget;
  }

  Widget _buildPlaceholder() {
    return ClipRRect(
      borderRadius: borderRadius,
      child: placeholder ?? const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorWidget() {
    return ClipRRect(
      borderRadius: borderRadius,
      child: errorWidget ?? const Icon(Icons.error),
    );
  }
}
