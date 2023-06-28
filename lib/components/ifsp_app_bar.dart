// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:ifsp_aluno/routes/ifsp_route.dart';

class IFSPAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final int? notificationNum;
  final Widget? leading;
  final List<Widget>? actions;
  const IFSPAppBar({
    required this.title,
    this.notificationNum,
    this.leading,
    this.actions,
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<IFSPAppBar> createState() => _IFSPAppBarState();
}

class _IFSPAppBarState extends State<IFSPAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      leading: widget.leading ??
          Image.asset(
            './assets/img/marca_ifsp.png',
          ),
      title: Text(widget.title),
      actions: widget.actions ??
          [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                child: Stack(
                  children: [
                    const Icon(
                      Icons.notifications_outlined,
                      size: 35,
                    ),
                    if (widget.notificationNum != null)
                      Container(
                        alignment: Alignment.center,
                        width: 25,
                        height: 25,
                        margin: const EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.notificationNum! > 9 ? '9+' : widget.notificationNum.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      )
                    else
                      Container(
                        alignment: Alignment.center,
                        width: 25,
                        height: 25,
                        margin: const EdgeInsets.only(left: 15),
                      )
                  ],
                ),
                onTap: () {
                  closeNotification = false;
                  Navigator.pushNamed(
                    context,
                    '/notificationlist',
                  );
                },
              ),
            ),
          ],
    );
  }
}
