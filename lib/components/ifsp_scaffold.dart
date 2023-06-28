// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ifsp_aluno/components/ifsp_bottom_nav_bar.dart';
import 'package:ifsp_aluno/routes/ifsp_route.dart';
import 'package:ifsp_aluno/routes/ifsp_route_builder.dart';
import 'package:ifsp_aluno/routes/ifsp_route_list.dart';

class IFSPScaffold extends StatefulWidget {
  const IFSPScaffold({super.key, required this.selectedKey});

  final int selectedKey;

  @override
  State<IFSPScaffold> createState() => _IFSPScaffoldState();
}

class _IFSPScaffoldState extends State<IFSPScaffold> {
  int _currentPageIndex = 0;

  @override
  void initState() {
    _currentPageIndex = widget.selectedKey;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: _currentPageIndex,
          children: IFSPRouteList.routeList
              .map<Widget>((IFSPRoute ifspRoute) =>
                  IFSPRouteBuilder(ifspRoute: ifspRoute))
              .toList(),
        ),
      ),
      bottomNavigationBar: IFSPBottomNavBar(
        updateBodyCallback: (page) => {
          setState(() {
            _currentPageIndex = page;
          }),
        },
      ),
    );
  }
}
