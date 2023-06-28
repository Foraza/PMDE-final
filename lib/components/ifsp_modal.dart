// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ifsp_aluno/model/campus.dart';

class IFSPModal extends StatefulWidget {
  final String title;
  final List<Campus> campusList;
  final Function() funcOK;
  final Function()? funcCancel;

  const IFSPModal({required this.title, required this.campusList, required this.funcOK, this.funcCancel, super.key});

  @override
  State<IFSPModal> createState() => _IFSPModalState();
}

class _IFSPModalState extends State<IFSPModal> {
  List<Widget> radList = [];
  String selected = '';

  @override
  void initState() {
    super.initState();
    selected = widget.campusList.first.avaUrl;
  }

  @override
  Widget build(BuildContext context) {
    radList = [];
    for (int i = 0; i < widget.campusList.length; i++) {
      radList.add(
        RadioListTile(
          groupValue: selected,
          value: widget.campusList.elementAt(i).avaUrl,
          onChanged: (String? value) {
            setState(() {
              selected = value!;
            });
          },
          title: Text(widget.campusList.elementAt(i).nome),
        ),
      );
    }

    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView(
          children: radList,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: widget.funcOK,
          child: Text(
            'OK',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
        TextButton(
          onPressed: widget.funcCancel ?? () => Navigator.pop(context, 'Cancel'),
          child: Text(
            'Cancel',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ],
    );
  }
}
