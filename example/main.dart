// example/main.dart
import 'package:flutter/material.dart';
import 'package:multi_image_provider/multi_image_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Image Provider Example',
      home: const ImageExamplePage(),
    );
  }
}

class ImageExamplePage extends StatelessWidget {
  const ImageExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Multi Image Provider')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 📦 Asset image
          const MultiImage(
            imagePath: 'assets/images/sample.png',
            imageType: ImageType.asset,
            aspectRatio: 382 / 500,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),

          const SizedBox(height: 24),

          // 🌐 Cached Network image
          MultiImage(
            imagePath: 'https://picsum.photos/400/600',
            imageType: ImageType.network,
            aspectRatio: 382 / 500,
            width: screenWidth * 0.9,
            borderRadius: BorderRadius.circular(12),
            placeholder: const Center(child: CircularProgressIndicator()),
          ),

          const SizedBox(height: 24),

          // 🧩 SVG asset
          const MultiImage(
            imagePath: 'assets/icons/sample.svg',
            imageType: ImageType.svgAsset,
            aspectRatio: 1,
          ),

          const SizedBox(height: 24),

          // 🌐 SVG from network (cached)
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
