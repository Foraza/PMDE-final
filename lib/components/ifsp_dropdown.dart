// Flutter imports:
import 'package:flutter/material.dart';

class IFSPDropdownButton<TViewModel> extends StatefulWidget {
  const IFSPDropdownButton({required this.list, required this.viewModel, this.height, super.key});
  final List<String> list;
  final TViewModel viewModel;
  final double? height;

  @override
  State<IFSPDropdownButton> createState() => _IFSPDropdownButtonState();
}

class _IFSPDropdownButtonState extends State<IFSPDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
      decoration: BoxDecoration(
        //border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(5),
        // border: Theme.of(context).colorScheme.brightness == Brightness.dark
        //     ? null
        //     : Border.all(color: Theme.of(context).colorScheme.onPrimaryContainer, width: 1),
        color: Theme.of(context).colorScheme.secondaryContainer,
        boxShadow: Theme.of(context).colorScheme.brightness == Brightness.light
            ? const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 4.0,
                  spreadRadius: 0.0,
                  offset: Offset(0.0, 3.0),
                )
              ]
            : null,
      ),
      width: MediaQuery.of(context).size.width * 0.95,
      height: widget.height ?? 45,
      child: DropdownButton<String>(
        value: widget.viewModel.dropdownValue,
        alignment: Alignment.centerRight,
        borderRadius: BorderRadius.circular(15),
        dropdownColor: Theme.of(context).colorScheme.surface,
        icon: const Icon(Icons.arrow_drop_down_outlined),
        elevation: 8,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
        underline: Container(color: Colors.transparent),
        onChanged: (String? value) {
          widget.viewModel.setDropdownValue(value);
        },
        items: widget.list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
