// One-off: resize/compress source PNGs in assets/ for repo size.
// Run: dart run tool/optimize_branding_assets.dart
import 'dart:io';

import 'package:image/image.dart' as img;

Future<void> main() async {
  await _process('assets/icon.png', 1024, 1024);
  await _process('assets/splash_logo.png', 512, 512);
}

Future<void> _process(String path, int w, int h) async {
  final file = File(path);
  if (!file.existsSync()) {
    stderr.writeln('Missing $path');
    exit(1);
  }
  final before = file.lengthSync();
  final decoded = img.decodeImage(await file.readAsBytes());
  if (decoded == null) {
    stderr.writeln('Could not decode $path');
    exit(1);
  }
  final resized = img.copyResize(
    decoded,
    width: w,
    height: h,
    interpolation: img.Interpolation.cubic,
  );
  await file.writeAsBytes(img.encodePng(resized, level: 6));
  final after = file.lengthSync();
  stdout.writeln('$path: ${before ~/ 1024} KB → ${after ~/ 1024} KB (${w}x$h)');
}
