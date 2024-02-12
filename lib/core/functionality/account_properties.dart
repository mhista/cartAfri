import 'package:flutter/material.dart';

class ListTileProperties {
  ListTileProperties({required this.size});
  double size = 18;
  List listTileWidget(size) {
    return [
      {
        'title': 'Edit Profile',
        'leading': Icon(Icons.person_3_outlined, size: size),
        'route': '/profile'
      },
      {
        'title': 'My Notifications',
        'leading': Icon(Icons.notifications_none_outlined, size: size),
        'route': '/notification'
      },
      {
        'title': 'Watchlist',
        'leading': Icon(Icons.remove_red_eye_outlined, size: size),
        'route': '/watchlist'
      },
      {
        'title': 'Language',
        'leading': Icon(Icons.language_outlined, size: size),
        'route': '/language'
      },
      {
        'title': 'App Settings',
        'leading': Icon(Icons.settings_outlined, size: size),
        'route': '/settings'
      },
      {
        'title': 'Referrals',
        'leading': Icon(Icons.supervisor_account_outlined, size: size),
        'route': '/referral'
      },
      {
        'title': 'Feedback & Help',
        'leading': Icon(Icons.headphones_outlined, size: size),
        'route': '/feedback'
      },
    ];
  }

  int getTileLength() => listTileWidget(size).length;
  List getTileList() => listTileWidget(size);
  String getTitle(index) => listTileWidget(size)[index]['title'];
  Widget getIcon(index) => listTileWidget(size)[index]['leading'];
  String getRoute(index) => listTileWidget(size)[index]['route'];
}
