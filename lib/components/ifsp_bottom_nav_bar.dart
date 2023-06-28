// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// Project imports:
import 'package:ifsp_aluno/routes/ifsp_route.dart';
import 'package:ifsp_aluno/routes/ifsp_route_list.dart';
import 'package:ifsp_aluno/view/calendar_page.dart';

class IFSPBottomNavBar extends StatefulWidget {
  final void Function(int) updateBodyCallback;

  const IFSPBottomNavBar({
    super.key,
    required this.updateBodyCallback,
  });

  @override
  State<IFSPBottomNavBar> createState() => _IFSPBottomNavBarState();
}

class _IFSPBottomNavBarState extends State<IFSPBottomNavBar> {
  int _index = 0;

  void changePage(idx) {
    setState(() {
      _index = idx;
      widget.updateBodyCallback(_index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Colors.transparent,
            Colors.transparent,
            Theme.of(context).colorScheme.background,
          ],
        ),
      ),
      child: CurvedNavigationBar(
        index: _index,
        height: 60,
        color: Theme.of(context).colorScheme.primary.withBlue(60),
        buttonBackgroundColor: Theme.of(context).colorScheme.primary.withBlue(60),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.ease,
        animationDuration: const Duration(milliseconds: 400),
        items: IFSPRouteList.routeList.map((IFSPRoute rotas) {
          return Icon(
            rotas.icon,
            color: Colors.white,
          );
        }).toList(),
        onTap: (index) {
          //TODO Inserir página de login
          if (IFSPRouteList.routeList[index].route == '/logout') {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const CalendarPage(),
            ));
          } else {
            changePage(index);
            closeNotification = true;
          }
        },
      ),
    );
  }
}
