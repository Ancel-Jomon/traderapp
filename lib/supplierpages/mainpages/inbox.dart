import 'package:flutter/material.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.request_page),
            title: const Text('Request 1'),
            onTap: () {
              // Add your action for request item tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.request_page),
            title: const Text('Request 2'),
            onTap: () {
              // Add your action for request item tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text('Message 1'),
            onTap: () {
              // Add your action for message item tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text('Message 2'),
            onTap: () {
              // Add your action for message item tap
            },
          ),
        ],
      ),
    );
  }
}
