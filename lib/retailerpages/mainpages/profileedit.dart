import 'package:flutter/material.dart';

class RetProfileEdit extends StatefulWidget {
  const RetProfileEdit({super.key});

  @override
  State<RetProfileEdit> createState() => _RetProfileEditState();
}

class _RetProfileEditState extends State<RetProfileEdit> {
  final _formKey = GlobalKey<FormState>();
  String phoneNumber = '';
  String address = '';
  String place = '';
  String email = '';
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number'),
                onChanged: (value) {
                  setState(() {
                    phoneNumber = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Place'),
                onChanged: (value) {
                  setState(() {
                    place = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              TweenAnimationBuilder(
                tween: ColorTween(
                    begin: Colors.blue,
                    end: _isPressed ? Colors.green : Colors.blue),
                duration: const Duration(milliseconds: 500),
                builder: (BuildContext context, Color? color, Widget? child) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    ),
                    child: const Text('Save Changes', style: TextStyle(fontSize: 20)),
                    onPressed: () {
                      setState(() {
                        _isPressed = !_isPressed;
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
