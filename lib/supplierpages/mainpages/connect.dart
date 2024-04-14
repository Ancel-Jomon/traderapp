
import 'package:flutter/material.dart';

class Connect extends StatefulWidget {
  const Connect({super.key});

  @override
  State<Connect> createState() => _MyAppState();
}

class _MyAppState extends State<Connect> {
  String id = '';
  double _opacity = 1.0;

  Future<void> connect() async {
    // Simulate a network request
    await Future.delayed(const Duration(seconds: 3));
    //eda ivide firebase ayitolla connctivity check cheytho
    bool successful = true;

    if (successful) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User Found'),
          duration: Duration(seconds: 3),
        ),
      );

      Future.delayed(const Duration(seconds: 3), () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Request sent'),
            duration: Duration(seconds: 1),
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Retailer Not Found'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supplier Connect'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter Retailer ID',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
                onChanged: (value) {
                  setState(() {
                    id = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTapDown: (details) {
                setState(() {
                  _opacity = 0.0;
                });
              },
              onTapUp: (details) {
                setState(() {
                  _opacity = 1.0;
                });
              },
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(seconds: 1),
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Row(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(width: 20),
                            Text('Connecting...'),
                          ],
                        ),
                        duration: Duration(seconds: 3),
                      ),
                    );
                    connect();
                  },
                  child: const Text('Request', style: TextStyle(fontSize: 20)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
