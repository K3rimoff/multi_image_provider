
# Multi Image Provider

🌟 A versatile Flutter widget to display images with custom aspect ratio, supporting multiple image sources including asset, network (with caching), and SVG images.

## ✨Features
✅ Supports asset images (Image.asset)

✅ Network and SVG images are automatically cached for faster loading and offline access.

✅ Supports network images with caching (cached_network_image)

✅ Supports SVG images from assets and network (flutter_svg + caching)

✅ Custom aspect ratio control

✅ Border radius and decoration support

✅ Placeholder and error widgets for network images
## 🚀Installation
Add to your `pubspec.yaml`:
```yaml
  dependencies:
  multi_image_provider: ^1.0.2
```
Then run:
```bash
flutter pub get
```
## 🛠️Usage
```dart
import 'package:multi_image_provider/multi_image_provider.dart';
```

## ⚙️ App Initialization (`main.dart`)

```dart
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
```

## 📦 Asset image example
```dart
MultiImage(
 imagePath: "assets/image.jpg",
 borderRadius: BorderRadius.all(Radius.circular(30)),
 )
```

## 🌐 Cached network image example
```dart
MultiImage(
 imageType: ImageType.network,
 imagePath: "https://images.pexels.com/photos/378570/pexels-photo-378570.jpeg",
 borderRadius: BorderRadius.all(Radius.circular(20)),
 aspectRatio: 1,
)
```
## 🧩 SVG asset example
```dart
MultiImage(
 imageType: ImageType.svgAsset,
 imagePath: "assets/sample.svg",
 width: 200,
 height: 200,
)
```
## 🕸️ SVG network image example (cached)
```dart
MultiImage(
 imageType: ImageType.svgNetwork,
 imagePath: "https://www.svgrepo.com/show/530486/earphone.svg",
 height: 300,
 width: 300,
)
```

## 📌Notes
⚠️ Currently, the package does not support the Web platform due to dependency on `flutter_cache_manager` and `path_provider`.

Works on Android, iOS, Windows, Linux, and macOS platforms.

Does not support Web or WASM runtimes due to underlying dependencies.