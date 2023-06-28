// Flutter imports:
import 'package:flutter/material.dart';
import 'package:ifsp_aluno/model/evento.dart';
import 'package:intl/intl.dart';
//import 'package:ifsp_aluno/viewmodel/notification_viewmodel.dart';

class IFSPEventBody extends StatefulWidget {
  final Evento event;
  final Color color;

  const IFSPEventBody({
    required this.event,
    required this.color,
    super.key,
  });

  @override
  State<IFSPEventBody> createState() => _IFSEventnBodyState();
}

class _IFSEventnBodyState extends State<IFSPEventBody> {
  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('EEEE');
    DateTime day = DateTime.parse(widget.event.date);
    String weekDay = formatter.format(day);

    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.90,
        height: MediaQuery.of(context).size.height * 0.85,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.60,
                  height: MediaQuery.of(context).size.width * 0.20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.event.title,
                        //textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '$weekDay - ${widget.event.date}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                    //overlayColor: MaterialStatePropertyAll(Colors.transparent),
                    shadowColor: MaterialStatePropertyAll(Colors.transparent),
                    foregroundColor: MaterialStatePropertyAll(Colors.transparent),
                    backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                    surfaceTintColor: MaterialStatePropertyAll(Colors.transparent),
                  ),
                  icon: Icon(
                    Icons.edit_calendar,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 50,
                  ),
                )
              ],
            ),
            Divider(
              color: widget.color,
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.event.desc,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
