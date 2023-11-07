import 'package:flutter/material.dart';

AppBar commonAppbar = AppBar(
  elevation: 0,
  toolbarHeight: 45,
  titleSpacing: 2,
  backgroundColor: Colors.white,
  foregroundColor: Colors.black,
  leading: IconButton(
    padding: EdgeInsets.zero,
    icon: Image.asset(
      'assets/icons/logo.png',
      width: 25, // Adjust the width as needed
      height: 25, // Adjust the height as needed
    ),
    onPressed: () {},
  ),
  title: const Row(children: [
    Text("SeeQul"),
    Icon(Icons.chevron_right, color: Colors.black)
  ]),
  actions: [
    IconButton(
      icon: Image.asset(
        'assets/icons/search.png',
        width: 25, // Adjust the width as needed
        height: 25, // Adjust the height as needed
      ),
      onPressed: () {},
    ),
    IconButton(
      icon: Image.asset(
        'assets/icons/last.png',
        width: 25, // Adjust the width as needed
        height: 25, // Adjust the height as needed
      ),
      onPressed: () {},
    ),
  ],
);

AppBar secondAppbar(BuildContext context, String title) => AppBar(
      elevation: 0,
      toolbarHeight: 45,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      titleSpacing: 2,
      title: Text(title),
      leading: IconButton(
        // splashRadius: 15,
        padding: EdgeInsets.zero,
        icon: const CircleAvatar(
          radius: 15,
          backgroundColor: Colors.black,
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
