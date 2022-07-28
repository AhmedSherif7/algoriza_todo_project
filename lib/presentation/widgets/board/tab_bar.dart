import 'package:flutter/material.dart';

class HomeTabBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeTabBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: Colors.black,
      isScrollable: true,
      controller: controller,
      tabs: const [
        Tab(
          text: 'All',
        ),
        Tab(
          text: 'Completed',
        ),
        Tab(
          text: 'Uncompleted',
        ),
        Tab(
          text: 'Favorites',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 48);
}
