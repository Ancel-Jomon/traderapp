import 'package:flutter/material.dart';

class RetMessagePage extends StatelessWidget {
  const RetMessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  // Add your action for request button tap
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.request_page),
                    SizedBox(width: 10),
                    Text('Requests', style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.message),
                    SizedBox(width: 10),
                    Text('Messages', style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
