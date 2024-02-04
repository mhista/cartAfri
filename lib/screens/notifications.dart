import 'package:cartafri/core/constants/color_constants.dart';
import 'package:cartafri/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.close),
        centerTitle: false,
        title: const Text(
          'Notification',
          style: kOrderTextStyle,
        ),
      ),
      body: ListView(children: const [
        NotificationCard(headerText: 'Offers', notifications: [1, 2]),
        NotificationCard(headerText: 'Orders', notifications: [1, 2, 3]),
        NotificationCard(
          headerText: 'Accounts',
          notifications: [1, 2],
        )
      ]),
    );
  }
}

/* card for each notification object. this widget holds the notification 
header e.g{orders, offers, account} and the notificatiosn in a list*/
class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.headerText,
    required this.notifications,
  });

  final String headerText;
  final List notifications;

  @override
  Widget build(BuildContext context) {
    final String text = lorem(paragraphs: 1, words: 5);

    return Card(
      color: Colors.white,
      elevation: 0.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: NotificationHeader(
              headerText: headerText,
              count: notifications.length,
            ),
          ),
          notifications.length == 2
              ? Column(
                  children: [
                    NotificationListTile(notification: text, time: '1:20pm'),
                    NotificationListTile(notification: text, time: '1:20pm')
                  ],
                )
              : notifications.length == 1
                  ? NotificationListTile(notification: text, time: '1:20pm')
                  : Column(
                      children: [
                        NotificationListTile(
                            notification: text, time: '1:20pm'),
                        NotificationListTile(
                            notification: text, time: '1:20pm'),
                        Center(
                            child: TextButton(
                                onPressed: () {},
                                child: const Text('view all')))
                      ],
                    ),
        ],
      ),
    );
  }
}

// The Notification header text goes here
class NotificationHeader extends StatelessWidget {
  const NotificationHeader({
    super.key,
    required this.headerText,
    required this.count,
  });
  final String headerText;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(headerText, style: kOrderTextStyle),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Badge(
            backgroundColor: const Color(0xffe2e8fe),
            textColor: ColorConstants.kButtonColor,
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            label: Text(count.toString()),
          ),
        )
      ],
    );
  }
}

// the notification list
class NotificationListTile extends StatelessWidget {
  const NotificationListTile({
    super.key,
    required this.notification,
    required this.time,
  });
  final String notification;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: AssetImage(
            'images/homes (6).jpg',
          ),
        ),
        title: Text(
          notification,
          style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500),
        ),
        trailing: Text(time),
      ),
    );
  }
}
