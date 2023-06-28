/* // Flutter imports:
import 'package:flutter/material.dart';
import 'package:ifsp_aluno/components/ifsp_app_bar.dart';
import 'package:ifsp_aluno/components/ifsp_notification_body.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationListViewModel? notificationListViewModel = context.watch<NotificationListViewModel>();
    NotificationViewModel? notificationViewModel = context.watch<NotificationViewModel>();

    int? notificationIndex = notificationListViewModel.clickIndex;

    //Muda o status da notificação
    notificationViewModel.changeNotificationStatus(notificationListViewModel.model.data[notificationIndex].id!, 'read');

    if (notificationListViewModel.isLoading) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          title: const Text('Notificações'),
          scrolledUnderElevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(
                height: 15,
              ),
              Text("Carregando notificação..."),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: IFSPAppBar(
        title: 'Notificações',
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        actions: const [],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  color: Theme.of(context).colorScheme.surface.withAlpha(80),
                  child: Center(
                      child: IFSPNotificationBody(
                    id: notificationListViewModel.model.data[notificationIndex].id!,
                    title: notificationListViewModel.model.data[notificationIndex].titulo,
                    from: notificationListViewModel.model.data[notificationIndex].autor,
                    bodyText: notificationListViewModel.model.data[notificationIndex].conteudo,
                    //status: notificationListViewModel.model.data[notificationIndex].status,
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
 */