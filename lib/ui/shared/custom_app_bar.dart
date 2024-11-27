import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, this.title = 'C-House'});

  @override
  Widget build(BuildContext context) {
    final appBarTheme = Theme.of(context).appBarTheme;

    return AppBar(
      title: Row(
        children: [
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      backgroundColor: appBarTheme.backgroundColor,
      foregroundColor: appBarTheme.foregroundColor,
      elevation: appBarTheme.elevation ?? 4,
      shadowColor: appBarTheme.shadowColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
