import 'package:flutter/material.dart';

class RetMessagePage extends StatelessWidget {
  const RetMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              ElevatedButton(
                child: Row(
                  children: [
                    Icon(Icons.request_page),
                    SizedBox(width: 10),
                    Text('Requests', style: TextStyle(fontSize: 20)),
                  ],
                ),
                onPressed: () {
                  // Add your action for request button tap
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Row(
                  children: [
                    Icon(Icons.message),
                    SizedBox(width: 10),
                    Text('Messages', style: TextStyle(fontSize: 20)),
                  ],
                ),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
