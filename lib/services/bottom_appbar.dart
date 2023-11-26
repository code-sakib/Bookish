import 'package:flutter/material.dart';

import '../screens/Home/home_screen.dart';
import '../screens/settings/settings_screen.dart';

bottomAppBar(BuildContext context) => BottomAppBar(
      notchMargin: 5,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              tooltip: 'Home',
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: ((context) => const HomeScreen()))),
              icon: const Icon(
                Icons.home_rounded,
                size: 30,
              )),
          IconButton(
              tooltip: 'Settings',
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: ((context) => const SettingsScreen()))),
              icon: const Icon(Icons.more_horiz_rounded, size: 30)),
        ],
      ),
    );
