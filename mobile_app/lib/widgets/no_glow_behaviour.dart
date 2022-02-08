import 'package:flutter/material.dart';

/// Removes the glow behavior when pulling down a list while at the end of the list.
class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
