// Flutter imports:
import 'package:flutter/material.dart';

class IFSPButton extends StatelessWidget {
  final String title;
  final void Function() func;
  final Widget? icon;
  final TextStyle? txtStyle;
  final ButtonStyle? btnStyle;

  const IFSPButton({
    required this.title,
    required this.func,
    super.key,
    this.icon,
    this.btnStyle,
    this.txtStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return ElevatedButton.icon(
        onPressed: func,
        icon: icon!,
        label: Text(
          title,
          style: txtStyle,
        ),
        style: btnStyle,
      );
    } else {
      return ElevatedButton(
        onPressed: func,
        style: btnStyle,
        child: Text(
          title,
          style: txtStyle,
        ),
      );
    }
  }
}
