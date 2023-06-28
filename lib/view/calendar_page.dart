// Flutter imports:
import 'package:flutter/material.dart';
import 'package:ifsp_aluno/components/ifsp_app_bar.dart';
import 'package:ifsp_aluno/components/ifsp_calendar_dialog.dart';
import 'package:ifsp_aluno/components/ifsp_data_card.dart';
import 'package:ifsp_aluno/model/evento.dart';
import 'package:ifsp_aluno/viewmodel/event_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final DateFormat _formatter = DateFormat('yyy-MM-dd');
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  List<Evento> events = [];
  List<Evento> _selectedEvents = [];
  List<Widget> eventCards = [];

  _showDialog(BuildContext context) async {
    EventViewModel eventViewModel = Provider.of<EventViewModel>(context, listen: false);
    Map<String, TextEditingController> controllers = {
      'titulo': TextEditingController(),
      'tipo': TextEditingController(),
      'desc': TextEditingController(),
    };

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CalendarDialog(
            controllers: controllers,
            eventViewModel: eventViewModel,
            formatter: _formatter,
            selectedDay: _selectedDay!,
            refresh: _refresh,
          );
        });
  }

  void _refresh() {
    setState(() {});
  }

  List<Evento> _getEventsForDay(DateTime day) {
    List<Evento> aux = [];
    String dayFormatted = _formatter.format(day);

    for (var event in events) {
      if (event.date == dayFormatted) {
        aux.add(event);
      }
    }

    return aux;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    bool showDialog = _selectedDay == selectedDay;

    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _selectedEvents = _getEventsForDay(selectedDay);
    });

    if (showDialog) {
      _showDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    EventViewModel eventViewModel = context.watch<EventViewModel>();

    if (eventViewModel.isLoading) {
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
              Text("Carregando agenda..."),
            ],
          ),
        ),
      );
    }

    //Atualiza a lista de eventos
    events = eventViewModel.model.eventos;
    //Atualiza a lista de eventos do dia
    _selectedEvents = _getEventsForDay(_selectedDay!);

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  child: TableCalendar(
                    daysOfWeekHeight: 20,
                    eventLoader: ((day) => _getEventsForDay(day)),
                    selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    firstDay: DateTime.utc(2022),
                    lastDay: DateTime.utc(2100),
                    calendarBuilders: CalendarBuilders(
                      todayBuilder: ((context, day, focusedDay) {
                        return Container(
                          margin: const EdgeInsets.all(4),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            day.day.toString(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }),
                      selectedBuilder: ((context, day, focusedDay) {
                        return Container(
                          margin: const EdgeInsets.all(4),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            day.day.toString(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }),
                    ),
                    onDaySelected: _onDaySelected,
                    onFormatChanged: (format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _selectedEvents.length,
                itemBuilder: ((context, index) {
                  DateTime day = DateTime.parse(_selectedEvents[index].date);
                  DateFormat formatter = DateFormat('EEEE');
                  String weekDay = formatter.format(day);

                  Color cardColor = Theme.of(context).colorScheme.primary;

                  switch (_selectedEvents[index].type.toLowerCase()) {
                    case 'prova':
                      cardColor = Colors.blue.shade400;
                      break;

                    case 'lembrete':
                      cardColor = Colors.brown.shade300;
                      break;
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/evento', arguments: {
                            'event': _selectedEvents[index],
                            'color': cardColor,
                          });
                        },
                        child: IFSPDataCard(
                          width: MediaQuery.of(context).size.width * 0.95,
                          collapsed: false,
                          backgroundColor: Theme.of(context).colorScheme.background,
                          border: Border(
                            left: BorderSide(
                              width: 10,
                              color: cardColor,
                            ),
                          ),
                          top: Text(
                            '${_selectedEvents[index].type} - ${_selectedEvents[index].title}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          bottom: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('$weekDay - ${_selectedEvents[index].date}'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Icon(Icons.add_circle),
                                Text('Detalhes'),
                              ],
                            )
                          ]),
                        ),
                      ),
                    ],
                  );
                })),
          ],
        ),
      ),
    );
  }
}
