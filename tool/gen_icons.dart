// سكربت لمرة واحدة: يقصّ الهامش حول أيقونة المشغّل ويولّد طبقات adaptive.
// التشغيل: dart run tool/gen_icons.dart
import 'dart:io';
import 'package:image/image.dart' as img;

const _src = 'assets/images/launcher_icon.png';
const _legacyOut = 'assets/images/launcher_icon_full.png';
const _fgOut = 'assets/images/launcher_icon_fg.png';

bool _isBackground(img.Pixel p) {
  // هامش = شفّاف أو أبيض شبه كامل.
  if (p.a < 16) return true;
  return p.r > 240 && p.g > 240 && p.b > 240;
}

void main() {
  final src = img.decodePng(File(_src).readAsBytesSync())!;

  // 1) إيجاد حدود المحتوى (تجاهل الهامش).
  int minX = src.width, minY = src.height, maxX = 0, maxY = 0;
  for (var y = 0; y < src.height; y++) {
    for (var x = 0; x < src.width; x++) {
      if (!_isBackground(src.getPixel(x, y))) {
        if (x < minX) minX = x;
        if (y < minY) minY = y;
        if (x > maxX) maxX = x;
        if (y > maxY) maxY = y;
      }
    }
  }
  final cropped =
      img.copyCrop(src, x: minX, y: minY, width: maxX - minX + 1, height: maxY - minY + 1);

  // 2) أيقونة legacy ممتلئة (مربّعة 1024).
  final legacy = img.copyResizeCropSquare(cropped, size: 1024);
  File(_legacyOut).writeAsBytesSync(img.encodePng(legacy));

  // 3) لون الخلفية = عيّنة من مركز البطاقة.
  final center = legacy.getPixel(legacy.width ~/ 2, 40);
  final bgHex = '#${_hex(center.r)}${_hex(center.g)}${_hex(center.b)}';

  // 4) الطبقة الأمامية: نُبقي الرمز الأبيض فقط (شفّاف حوله) داخل المنطقة الآمنة.
  final fgContent = img.Image(width: legacy.width, height: legacy.height, numChannels: 4);
  for (var y = 0; y < legacy.height; y++) {
    for (var x = 0; x < legacy.width; x++) {
      final p = legacy.getPixel(x, y);
      final lum = (0.299 * p.r + 0.587 * p.g + 0.114 * p.b);
      if (lum > 170) {
        fgContent.setPixelRgba(x, y, 255, 255, 255, 255);
      } else {
        fgContent.setPixelRgba(x, y, 0, 0, 0, 0);
      }
    }
  }
  // نقصّ حدود الرمز ثم نضعه في كادر 1024 بنسبة ~60% (منطقة adaptive الآمنة).
  final fgTrim = _trimAlpha(fgContent);
  final canvas = img.Image(width: 1024, height: 1024, numChannels: 4);
  // نملأ ~88% من كادر الـ foreground؛ يضيف flutter_launcher_icons inset 16% فوقها.
  final target = (1024 * 0.88).round();
  final scaled = img.copyResize(fgTrim,
      width: fgTrim.width >= fgTrim.height ? target : null,
      height: fgTrim.height > fgTrim.width ? target : null);
  final dx = (1024 - scaled.width) ~/ 2;
  final dy = (1024 - scaled.height) ~/ 2;
  img.compositeImage(canvas, scaled, dstX: dx, dstY: dy);
  File(_fgOut).writeAsBytesSync(img.encodePng(canvas));

  stdout.writeln('legacy => $_legacyOut');
  stdout.writeln('foreground => $_fgOut');
  stdout.writeln('background color => $bgHex');
}

img.Image _trimAlpha(img.Image im) {
  int minX = im.width, minY = im.height, maxX = 0, maxY = 0;
  for (var y = 0; y < im.height; y++) {
    for (var x = 0; x < im.width; x++) {
      if (im.getPixel(x, y).a > 16) {
        if (x < minX) minX = x;
        if (y < minY) minY = y;
        if (x > maxX) maxX = x;
        if (y > maxY) maxY = y;
      }
    }
  }
  return img.copyCrop(im, x: minX, y: minY, width: maxX - minX + 1, height: maxY - minY + 1);
}

String _hex(num v) => v.toInt().toRadixString(16).padLeft(2, '0');
