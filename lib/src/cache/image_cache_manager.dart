import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Provides a customizable singleton cache manager for handling network and SVG image caching.
///
/// Allows configuration of [stalePeriod] and [maxNrOfCacheObjects].
class ImageCacheManager {
  /// Internal singleton instance
  static BaseCacheManager? _instance;

  /// Initializes the cache manager with custom parameters.
  ///
  /// This should be called before using [ImageCacheManager.instance].
  static void init({
    Duration stalePeriod = const Duration(days: 365),
    int maxNrOfCacheObjects = 1000000,
  }) {
    _instance = CacheManager(
      Config(
        'multiImageCache',
        stalePeriod: stalePeriod,
        maxNrOfCacheObjects: maxNrOfCacheObjects,
        repo: JsonCacheInfoRepository(databaseName: 'multi_image_cache.db'),
        fileService: HttpFileService(),
      ),
    );
  }

  /// Accessor to the singleton instance of the cache manager.
  ///
  /// If [init] has not been called, it initializes with default parameters.
  static BaseCacheManager get instance {
    _instance ??= CacheManager(
      Config(
        'multiImageCache',
        stalePeriod: const Duration(days: 365),
        maxNrOfCacheObjects: 1000000,
        repo: JsonCacheInfoRepository(databaseName: 'multi_image_cache.db'),
        fileService: HttpFileService(),
      ),
    );
    return _instance!;
  }
}
