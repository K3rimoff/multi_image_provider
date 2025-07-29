// example/main.dart

import 'package:flutter/material.dart';
import 'package:multi_image_provider/multi_image_provider.dart';

/// The entry point of the example application.
void main() {
  // ✅ Ensures Flutter binding is initialized before any plugin or service.
  WidgetsFlutterBinding.ensureInitialized();

  // 🗂️ Initializes the ImageCacheManager with custom settings:
  //    - stalePeriod: Defines how long cached images are considered valid (e.g. 10 days).
  //    - maxNrOfCacheObjects: Limits the number of images stored in the cache.
  ImageCacheManager.init(
    stalePeriod: Duration(days: 10),
    maxNrOfCacheObjects: 10,
  );

  // 🚀 Launches the application.
  runApp(const MyApp());
}

/// Root widget of the example application.
class MyApp extends StatelessWidget {
  /// Creates the root widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Image Provider Example',
      home: const ImageExamplePage(),
    );
  }
}

/// A page that demonstrates usage examples of the [MultiImage] widget.
class ImageExamplePage extends StatelessWidget {
  /// Creates the example page widget.
  const ImageExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multi Image Provider')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 📦 Asset image example
          const MultiImage(
            imagePath: "assets/image.jpg",
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),

          const SizedBox(height: 24),

          // 🌐 Cached network image example
          MultiImage(
            imageType: ImageType.network,
            imagePath:
                "https://images.pexels.com/photos/378570/pexels-photo-378570.jpeg",
            borderRadius: BorderRadius.all(Radius.circular(20)),
            aspectRatio: 1,
          ),

          const SizedBox(height: 24),

          // 🧩 SVG asset example
          const MultiImage(
            imageType: ImageType.svgAsset,
            imagePath: "assets/sample.svg",
            width: 200,
            height: 200,
          ),

          const SizedBox(height: 24),

          // 🌐 SVG network image example (cached)
          const MultiImage(
            imageType: ImageType.svgNetwork,
            imagePath: "https://www.svgrepo.com/show/530486/earphone.svg",
            height: 300,
            width: 300,
          ),
        ],
      ),
    );
  }
}
