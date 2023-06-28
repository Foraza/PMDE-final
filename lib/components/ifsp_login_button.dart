// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ifsp_aluno/components/ifsp_buttons.dart';

class LoginBaseButton extends IFSPButton {
  final double width;
  final double height;
  final double? fontSize;
  final Widget? lightIcon;
  final Widget? darkIcon;
  final bool? transparency;
  final bool? elevation;

  const LoginBaseButton(
      {required title,
      required func,
      required this.width,
      required this.height,
      this.fontSize,
      this.lightIcon,
      this.darkIcon,
      this.transparency,
      this.elevation,
      super.key})
      : super(title: title, func: func);

  @override
  Widget build(BuildContext context) {
    Widget iconFinal =
        Theme.of(context).colorScheme.brightness == Brightness.dark
            ? darkIcon!
            : lightIcon!;
    TextStyle txtStyle = TextStyle(
        color: Theme.of(context).colorScheme.brightness == Brightness.dark
            ? Colors.white70
            : Colors.black87,
        fontWeight: FontWeight.bold,
        fontSize: fontSize ?? 20);
    ButtonStyle btnStyle = ButtonStyle(
      backgroundColor: transparency!
          ? MaterialStateProperty.all(const Color(0x00000000))
          : MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
      elevation: elevation!
          ? MaterialStateProperty.all(0)
          : MaterialStateProperty.all(2.0),
      minimumSize: MaterialStateProperty.all(Size(
        MediaQuery.of(context).size.width * width,
        MediaQuery.of(context).size.height * height,
      )),
    );

    return IFSPButton(
      title: title,
      func: func,
      icon: iconFinal,
      btnStyle: btnStyle,
      txtStyle: txtStyle,
    );
  }
}
