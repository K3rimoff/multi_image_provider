# Multi Image Provider

A versatile Flutter widget to display images with custom aspect ratio, supporting multiple image sources including asset, network (with caching), and SVG images.

## Features

- Supports asset images (`Image.asset`)
- Supports network images with caching (`cached_network_image`)
- Supports SVG images from assets and network (`flutter_svg` + caching)
- Custom aspect ratio control
- Border radius and decoration support
- Placeholder and error widgets for network images

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  multi_image_provider: ^1.0.0
```

Then run:
```bash
flutter pub get
```
## Usage
```dart
import 'package:multi_image_provider/multi_image_provider.dart';
MultiImage(
  imagePath: 'assets/images/sample.png',
  imageType: ImageType.asset,
  aspectRatio: 382 / 500,
  borderRadius: BorderRadius.circular(12),
)
```

## For network images:
```dart
MultiImage(
  imagePath: 'https://picsum.photos/400/600',
  imageType: ImageType.network,
  aspectRatio: 382 / 500,
  width: MediaQuery.of(context).size.width * 0.9,
  placeholder: CircularProgressIndicator(),
)
```
