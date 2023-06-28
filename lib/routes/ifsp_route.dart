// Flutter imports:
import 'package:flutter/material.dart';

class IFSPRoute {
  const IFSPRoute({
    required this.title,
    required this.icon,
    required this.page,
    required this.pageKey,
    required this.route,
    this.renderBottomNav = true,
  });
  final String title;
  final IconData icon;
  final Widget page;
  final GlobalKey<NavigatorState> pageKey;
  final String route;
  final bool renderBottomNav;
}

bool closeNotification = false;
