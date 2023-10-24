import 'package:flutter/material.dart';

/// returns Radius
BorderRadius radius([double? radius]) {
  return BorderRadius.all(radiusCircular(radius ?? 25));
}

/// returns Radius
Radius radiusCircular([double? radius]) {
  return Radius.circular(radius ?? 25);
}
