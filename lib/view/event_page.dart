// Flutter imports:
import 'package:flutter/material.dart';
import 'package:ifsp_aluno/components/ifsp_app_bar.dart';
import 'package:ifsp_aluno/components/ifsp_event_body.dart';
import 'package:ifsp_aluno/model/evento.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: IFSPAppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        title: 'Agenda',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 10,
                decoration: BoxDecoration(color: args['color']),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: IFSPEventBody(
                    event: args['event'],
                    color: args['color'],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
