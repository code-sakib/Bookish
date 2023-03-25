import 'package:firebase_1/screens/Home/home_screen.dart';
import 'package:firebase_1/screens/Settings/settings_screen.dart';
import 'package:flutter/material.dart';

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
