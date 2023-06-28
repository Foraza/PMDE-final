// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ifsp_aluno/components/ifsp_base_screen.dart';
import 'package:ifsp_aluno/routes/ifsp_route.dart';

class IFSPRouteBuilder extends StatefulWidget {
  const IFSPRouteBuilder({super.key, required this.ifspRoute});

  final IFSPRoute ifspRoute;

  @override
  State<IFSPRouteBuilder> createState() => _IFSPRouteBuilderState();
}

class _IFSPRouteBuilderState extends State<IFSPRouteBuilder> {
  @override
  Widget build(BuildContext context) {
    return IFSPBaseScreen(
        title: widget.ifspRoute.title, child: widget.ifspRoute.page);
  }
}
