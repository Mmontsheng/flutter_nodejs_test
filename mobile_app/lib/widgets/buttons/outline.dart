import 'package:flutter/material.dart';
import 'package:mobile_app/theme/colors.dart';
import 'package:mobile_app/widgets/loading_icon.dart';

class OutlinedPrimaryButton extends StatefulWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  final String text;
  const OutlinedPrimaryButton(
      {Key? key,
      required this.onPressed,
      this.isLoading = false,
      required this.text})
      : super(key: key);

  @override
  _OutlinedPrimaryButtonState createState() => _OutlinedPrimaryButtonState();
}

class _OutlinedPrimaryButtonState extends State<OutlinedPrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: const BorderSide(
            width: 1.0,
            color: AppColors.primary,
            style: BorderStyle.solid,
          ),
        ),
        onPressed: widget.onPressed,
        child: Center(
          child: widget.isLoading
              ? const LoadingIcon()
              : Text(
                  widget.text,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }
}
