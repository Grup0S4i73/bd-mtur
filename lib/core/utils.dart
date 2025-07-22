import 'package:flutter/foundation.dart';

double getResponsiveWidth(double width) {
  final isWebLarge = kIsWeb && width > 600;

  return isWebLarge ? 390 : width;
}
