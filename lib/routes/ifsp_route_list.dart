// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ifsp_aluno/routes/ifsp_route.dart';
import 'package:ifsp_aluno/view/calendar_page.dart';

class IFSPRouteList {
  static final GlobalKey<NavigatorState> _calendarPK = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _notificationPK = GlobalKey<NavigatorState>();

  static final List<IFSPRoute> _ifspRouteList = <IFSPRoute>[
    IFSPRoute(
      title: 'Agenda',
      icon: Icons.calendar_month,
      page: CalendarPage(key: _calendarPK),
      pageKey: _calendarPK,
      route: '/calendar',
    ),
  ];

  static List<IFSPRoute> get routeList => _ifspRouteList;
  static GlobalKey<NavigatorState> get notificationPK => _notificationPK;
}
