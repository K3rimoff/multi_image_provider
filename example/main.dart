// example/main.dart

import 'package:flutter/material.dart';
import 'package:multi_image_provider/multi_image_provider.dart';

/// The entry point of the example application.
void main() {
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
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Multi Image Provider')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 📦 Asset image example
          const MultiImage(
            imagePath: 'assets/images/sample.png',
            imageType: ImageType.asset,
            aspectRatio: 382 / 500,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),

          const SizedBox(height: 24),

          // 🌐 Cached network image example
          MultiImage(
            imagePath: 'https://picsum.photos/400/600',
            imageType: ImageType.network,
            aspectRatio: 382 / 500,
            width: screenWidth * 0.9,
            borderRadius: BorderRadius.circular(12),
            placeholder: const Center(child: CircularProgressIndicator()),
          ),

          const SizedBox(height: 24),

          // 🧩 SVG asset example
          const MultiImage(
            imagePath: 'assets/icons/sample.svg',
            imageType: ImageType.svgAsset,
            aspectRatio: 1,
          ),

          const SizedBox(height: 24),

          // 🌐 SVG network image example (cached)
          const MultiImage(
            imagePath: 'https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/410.svg',
            imageType: ImageType.svgNetwork,
            aspectRatio: 1,
          ),
        ],
      ),
    );
  }
}
