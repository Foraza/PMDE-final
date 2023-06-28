// ignore_for_file: public_member_api_docs, sort_constructors_first
// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ifsp_aluno/components/ifsp_data_card.dart';

class IFSPNotificacaoCard extends IFSPDataCard {
  final String title;
  final String from;
  final String data;
  final String time;
  final String content;
  final bool notRead;
  final bool isSelected;
  final bool selectionMode;

  const IFSPNotificacaoCard(
      {super.key,
      required super.collapsed,
      required this.title,
      required this.from,
      required this.data,
      required this.time,
      required this.content,
      required this.notRead,
      required this.isSelected,
      required this.selectionMode});

  @override
  Widget build(BuildContext context) {
    Widget cardTop = Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      from,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              const VerticalDivider(),
              SizedBox(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      notRead
                          ? Icon(
                              Icons.mail_outline,
                              color: Theme.of(context).colorScheme.onPrimary,
                            )
                          : Icon(
                              Icons.drafts_outlined,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            time,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        const Divider(
          indent: 0,
          endIndent: 0,
        ),
      ],
    );

    Widget cardContent = Text(
      content,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
    );

    Color border = notRead ? Theme.of(context).colorScheme.primary : Colors.black54;
    BorderSide selectedBorder = isSelected
        ? BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          )
        : BorderSide.none;

    return IFSPDataCard(
      top: cardTop,
      bottom: cardContent,
      collapsed: collapsed,
      border: Border(
        left: BorderSide(
          color: border,
          width: selectionMode ? 30 : 12,
        ),
        top: selectedBorder,
        right: selectedBorder,
        bottom: selectedBorder,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: isSelected ? 10 : 4,
    );
  }
}
