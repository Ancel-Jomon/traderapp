import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MyAppState();
}

class _MyAppState extends State<MessagePage> {
  String yelan = 'Requests';
  String reff = 'Refresh';
  int count = 0;
  TextStyle submitTextStyle = TextStyle(
    color: Color.fromARGB(255, 97, 97, 97),
    fontSize: 16.0,
  );
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.inbox),
          title: const Text('Inbox'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_isPressed == false) {
                      _isPressed = true;
                    } else {
                      _isPressed = false;
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 34, 58, 194),
                      borderRadius: BorderRadius.circular(80),
                      border: Border.all(
                        color: _isPressed
                            ? Colors.grey.shade200
                            : Colors.grey.shade300,
                      ),
                      boxShadow: _isPressed
                          ? []
                          : [
                              BoxShadow(
                                color: Colors.grey.shade500,
                                offset: Offset(6, 6),
                                blurRadius: 15,
                                spreadRadius: 1,
                              )
                            ]),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color.fromARGB(255, 255, 0, 0),
                      padding: const EdgeInsets.all(50),
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        const Icon(
                          Icons.request_page,
                          size: 40,
                        ),
                        const SizedBox(width: 15),
                        Text(yelan, style: TextStyle(fontSize: 25)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_isPressed == false) {
                      _isPressed = true;
                    } else {
                      _isPressed = false;
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 34, 58, 194),
                      borderRadius: BorderRadius.circular(80),
                      border: Border.all(
                        color: _isPressed
                            ? Colors.grey.shade200
                            : Colors.grey.shade300,
                      ),
                      boxShadow: _isPressed
                          ? []
                          : [
                              BoxShadow(
                                color: Colors.grey.shade500,
                                offset: Offset(6, 6),
                                blurRadius: 15,
                                spreadRadius: 1,
                              )
                            ]),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color.fromARGB(255, 255, 0, 0),
                      padding: const EdgeInsets.all(50),
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        const Icon(
                          Icons.message,
                          size: 40,
                        ),
                        const SizedBox(width: 15),
                        Text('Messages', style: TextStyle(fontSize: 25)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              AnimatedButton(
                height: 70,
                width: 200,
                text: reff,
                isReverse: true,
                selectedTextColor: const Color.fromARGB(255, 148, 3, 3),
                transitionType: TransitionType.LEFT_TO_RIGHT,
                textStyle: submitTextStyle,
                backgroundColor: Color.fromARGB(69, 134, 134, 134),
                borderColor: Color.fromARGB(122, 141, 25, 25),
                borderRadius: 50,
                borderWidth: 2,
                onPress: () {
                  setState(() {
                    reff = 'Refresh';
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
