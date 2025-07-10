import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageCacheManager {
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
