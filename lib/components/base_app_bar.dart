import 'package:flutter/material.dart';
import 'utilities/colors_and_vars.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = stanColor;
  final String title;
  final AppBar appBar;
  final List<Widget>? widgets;

  const BaseAppBar(
      {super.key, required this.title, required this.appBar, this.widgets});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      elevation: 0,
      backgroundColor: backgroundColor,
      leading: GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/initial_screen', ModalRoute.withName('/'));
          },
          child: iconArrow),
      title: Text(
        title,
        style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      ),
      actions: widgets,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
