import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';

class RetMessagePage extends StatefulWidget {
  const RetMessagePage({super.key});

  @override
  State<RetMessagePage> createState() => _MyAppState();
}

class _MyAppState extends State<RetMessagePage> {
  String yelan = 'Requests';
  String reff = 'Refresh';
  int count = 0;
  TextStyle submitTextStyle = const TextStyle(
    color: Color.fromARGB(255, 97, 97, 97),
    fontSize: 16.0,
  );
 final bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 20,
                //foregroundColor: const Color.fromARGB(255, 255, 0, 0),
                //backgroundColor: Colors.white,
                padding: const EdgeInsets.all(50),
                animationDuration: const Duration(milliseconds: 300),
              ),
              onPressed: () {},
              child: Row(
                children: [
                  const Icon(
                    Icons.request_page,
                    size: 40,
                  ),
                  const SizedBox(width: 15),
                  Text(yelan, style: const TextStyle(fontSize: 25)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 34, 58, 194),
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
                            offset: const Offset(6, 6),
                            blurRadius: 15,
                            spreadRadius: 1,
                          )
                        ]),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  //foregroundColor: const Color.fromARGB(255, 255, 0, 0),
                  padding: const EdgeInsets.all(50),
                ),
                onPressed: () {},
                child: const Row(
                  children: [
                    Icon(
                      Icons.message,
                      size: 40,
                    ),
                    SizedBox(width: 15),
                    Text('Messages', style: TextStyle(fontSize: 25)),
                  ],
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
              backgroundColor: const Color.fromARGB(69, 134, 134, 134),
              borderColor: const Color.fromARGB(122, 141, 25, 25),
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
    );
  }
}
