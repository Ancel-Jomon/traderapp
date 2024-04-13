import 'package:flutter/material.dart';

class InboxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.request_page),
            title: Text('Request 1'),
            onTap: () {
              // Add your action for request item tap
            },
          ),
          ListTile(
            leading: Icon(Icons.request_page),
            title: Text('Request 2'),
            onTap: () {
              // Add your action for request item tap
            },
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Message 1'),
            onTap: () {
              // Add your action for message item tap
            },
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Message 2'),
            onTap: () {
              // Add your action for message item tap
            },
          ),
        ],
      ),
    );
  }
}
