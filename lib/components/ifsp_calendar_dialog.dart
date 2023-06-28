import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/material.dart';
import 'package:ifsp_aluno/components/ifsp_buttons.dart';
import 'package:ifsp_aluno/model/evento.dart';
import 'package:ifsp_aluno/viewmodel/event_viewmodel.dart';
import 'package:intl/intl.dart';

class CalendarDialog extends StatelessWidget {
  final Map<String, TextEditingController> controllers;
  final EventViewModel eventViewModel;
  final DateFormat formatter;
  final DateTime selectedDay;
  final Function refresh;
  final List<String> types = const ['Prova', 'Lembrete'];

  const CalendarDialog({
    required this.controllers,
    required this.eventViewModel,
    required this.formatter,
    required this.selectedDay,
    required this.refresh,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      insetPadding: const EdgeInsets.all(10),
      title: const Center(child: Text('Adicionar Lembrete')),
      content: Builder(builder: ((context) {
        return SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.78,
                      height: 55,
                      child: TextField(
                        controller: controllers['titulo'],
                        decoration: InputDecoration(
                          label: const Text(
                            'Título',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.78,
                      height: 55,
                      child: TextField(
                        controller: controllers['tipo'],
                        decoration: InputDecoration(
                          label: const Text(
                            'Tipo',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.78,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: TextField(
                        controller: controllers['desc'],
                        maxLines: 10,
                        decoration: InputDecoration(
                          label: const Text(
                            'Descrição',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      })),
      actions: [
        Container(
          width: MediaQuery.of(context).size.width * 0.78,
          height: 50,
          margin: const EdgeInsets.only(bottom: 15),
          child: IFSPButton(
            title: 'SALVAR',
            func: () async {
              String dayFormatted = formatter.format(selectedDay);
              bool addEvent = true;

              //Verifica se todos os campos foram preenchidos
              controllers.forEach((key, controller) {
                if (controller.text.isEmpty) {
                  addEvent = false;
                }
              });

              //Caso não tenham campos vazios, o evento é adicionado
              if (addEvent) {
                Evento evento = Evento(
                  date: dayFormatted,
                  title: controllers['titulo']!.text,
                  type: controllers['tipo']!.text,
                  desc: controllers['desc']!.text,
                );

                eventViewModel.model.eventos.add(evento);
                await eventViewModel.addEvent();

                refresh();

                Navigator.pop(context);
              } else {
                final snackbar = SnackBar(
                  content: const Text('Insira todas as informações'),
                  action: SnackBarAction(
                    label: 'OK',
                    textColor: Theme.of(context).colorScheme.onSecondary,
                    onPressed: () {},
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }
            },
            btnStyle: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) => Theme.of(context).colorScheme.primary),
            ),
            txtStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
    ;
  }
}
