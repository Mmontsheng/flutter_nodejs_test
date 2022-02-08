import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingIcon extends StatelessWidget {
  const LoadingIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
      width: 20,
      child: LoadingIndicator(
        colors: [
          Colors.white,
        ],
        indicatorType: Indicator.circleStrokeSpin,
      ),
    );
  }
}
