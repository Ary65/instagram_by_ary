import 'package:flutter/material.dart';
import 'package:instagram_by_ary/utils/colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('Notifications'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {},
              child: const Text(
                'Clear',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: Colors.purple),
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          getActivities(),
        ],
      ),
    );
  }

  getActivities() {}
}
