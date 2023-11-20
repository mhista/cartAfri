import 'package:flutter/material.dart';

class ListTileProperties {
  ListTileProperties({required this.size});
  double size = 18;
  List listTileWidget(size) {
    return [
      {
        'title': 'Edit Profile',
        'leading': Icon(Icons.person_3_outlined, size: size),
      },
      {
        'title': 'My Notifications',
        'leading': Icon(Icons.notifications_none_outlined, size: size),
      },
      {
        'title': 'Watchlist',
        'leading': Icon(Icons.remove_red_eye_outlined, size: size),
      },
      {
        'title': 'Language',
        'leading': Icon(Icons.language_outlined, size: size),
      },
      {
        'title': 'App Settings',
        'leading': Icon(Icons.settings_outlined, size: size),
      },
      {
        'title': 'Referrals',
        'leading': Icon(Icons.supervisor_account_outlined, size: size),
      },
      {
        'title': 'Feedback & Help',
        'leading': Icon(Icons.headphones_outlined, size: size),
      },
    ];
  }

  int getTileLength() => listTileWidget(size).length;
  List getTileList() => listTileWidget(size);
  String getTitle(index) => listTileWidget(size)[index]['title'];
  Widget getIcon(index) => listTileWidget(size)[index]['leading'];
}
