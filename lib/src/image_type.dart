/// Defines the supported types of image sources for the [MultiImage] widget.
enum ImageType {
  /// Loads an image from Flutter asset.
  asset,

  /// Loads a raster image from a network URL with caching.
  network,

  /// Loads an SVG image from Flutter asset.
  svgAsset,

  /// Loads an SVG image from a network URL with caching.
  svgNetwork,
}
