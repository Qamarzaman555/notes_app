import 'package:flutter/material.dart';

class UkTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? backgroundColor, foregroundColor;
  final String? label;
  final Widget? text;
  const UkTextButton({
    super.key,
    this.label,
    this.text,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
              elevation: 3.0,
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor ?? Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: label == null
                ? text
                : Text(
                    label!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
          )),
    );
  }
}
