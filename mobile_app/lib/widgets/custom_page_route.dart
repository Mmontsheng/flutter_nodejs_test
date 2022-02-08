import 'package:flutter/material.dart';

/// A wrapper that removes animation when navigating between routes
class CustomPageRoute extends MaterialPageRoute {
  CustomPageRoute({builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}
