import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Provides a singleton cache manager for handling network and SVG image caching.
class ImageCacheManager {
  /// Singleton instance of [BaseCacheManager] for caching downloaded images.
  static final BaseCacheManager instance = CacheManager(
    Config(
      'multiImageCache',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 100,
      repo: JsonCacheInfoRepository(databaseName: 'multi_image_cache.db'),
      fileService: HttpFileService(),
    ),
  );
}
