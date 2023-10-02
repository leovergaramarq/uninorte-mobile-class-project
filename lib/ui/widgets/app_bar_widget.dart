import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  AppBarWidget(
      {Key? key,
      this.text = '',
      this.backButton = false,
      this.logoutButton = false,
      this.onLogout})
      : super(key: key);

  final String text;
  final bool backButton;
  final bool logoutButton;
  final void Function()? onLogout;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(text),
      centerTitle: true,
      actions: [
        if (logoutButton)
          IconButton(
              key: const Key('ButtonHomeLogOff'),
              onPressed: onLogout,
              icon: const Icon(Icons.logout))
      ],
      automaticallyImplyLeading: backButton,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
