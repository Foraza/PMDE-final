// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ifsp_aluno/repositories/event_repo.dart';
import 'package:ifsp_aluno/services/notification_service.dart';
import 'package:ifsp_aluno/view/calendar_page.dart';
import 'package:ifsp_aluno/view/event_page.dart';
import 'package:ifsp_aluno/view/login_auth_page.dart';
import 'package:ifsp_aluno/view/login_page.dart';
import 'package:ifsp_aluno/view/register_page.dart';
import 'package:ifsp_aluno/viewmodel/event_viewmodel.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:ifsp_aluno/theme/ifsp_theme_data.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => EventViewModel(repo: EventRepo())),
        ),
        Provider<NotificationService>(
          create: (context) => NotificationService(),
        ),
      ],
      child: const IFSPAlunoApp(),
    ),
  );
}

class IFSPAlunoApp extends StatefulWidget {
  const IFSPAlunoApp({super.key});

  @override
  State<IFSPAlunoApp> createState() => _IFSPAlunoAppState();
}

class _IFSPAlunoAppState extends State<IFSPAlunoApp> {
  @override
  void initState() {
    super.initState();
    checkNotifications();
  }

  void checkNotifications() async {
    await Provider.of<NotificationService>(context, listen: false).checkForNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IFSP Aluno',
      theme: IFSPThemeData.theme(themeMode: IFSPThemeMode.lightMode, useMaterial3: true),
      darkTheme: IFSPThemeData.theme(themeMode: IFSPThemeMode.darkMode, useMaterial3: true),
      initialRoute: '/login',
      routes: {
        //'/login': (context) => const LoginPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/loginauth': (context) => const LoginAuthPage(),
        '/home': (context) => const CalendarPage(),
        '/evento': (context) => const EventPage(),
      },
    );
  }
}
