import 'package:flutter/material.dart';
import 'package:mobile_app/theme/colors.dart';
import 'package:mobile_app/widgets/loading_icon.dart';

class PrimaryButton extends StatefulWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  final Color foregroundColor;
  final Color backgroundColor;
  final String text;
  const PrimaryButton(
      {Key? key,
      required this.onPressed,
      this.isLoading = false,
      this.foregroundColor = Colors.white,
      this.backgroundColor = AppColors.primary,
      required this.text})
      : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: widget.backgroundColor,
      onPressed: widget.onPressed,
      height: 55,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: widget.isLoading
            ? const LoadingIcon()
            : Text(
                widget.text,
                style: TextStyle(
                  color: widget.foregroundColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    );
  }
}
