//import 'package:expandable/expandable.dart';

// Flutter imports:
import 'package:flutter/material.dart';

class IFSPDataCard extends StatelessWidget {
  final Widget? top;
  final Widget? bottom;
  final bool collapsed;
  final Color? backgroundColor;
  final Color? borderColor;
  final Border? border;
  final double? height;
  final double? width;
  final double? elevation;

  const IFSPDataCard(
      {required this.collapsed,
      this.top,
      this.bottom,
      this.backgroundColor,
      this.borderColor,
      this.border,
      this.height,
      this.width,
      this.elevation,
      super.key});

  @override
  Widget build(BuildContext context) {
    Widget cardData;

    cardData = ListTile(
      title: top,
      subtitle: collapsed ? null : bottom,
    );

    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.95,
      height: height != null ? MediaQuery.of(context).size.height * height! : height,
      child: Card(
        color: Theme.of(context).colorScheme.onPrimary,
        elevation: elevation ?? 4,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            decoration: BoxDecoration(
              border: border ?? Border.all(color: borderColor ?? Theme.of(context).colorScheme.primary, width: 1),
              borderRadius: border != null ? null : BorderRadius.circular(5),
              color: backgroundColor ?? Theme.of(context).colorScheme.onPrimary,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[cardData],
            ),
          ),
        ),
      ),
    );
  }
}
