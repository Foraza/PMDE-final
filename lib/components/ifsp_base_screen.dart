// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ifsp_aluno/components/ifsp_app_bar.dart';

class IFSPBaseScreen extends StatelessWidget {
  final Widget child;
  final String title;
  const IFSPBaseScreen({required this.title, super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IFSPAppBar(
        title: title,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 8),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: child,
      ),
    );
  }
}
