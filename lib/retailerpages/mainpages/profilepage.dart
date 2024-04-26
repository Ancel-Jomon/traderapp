import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:traderapp/retailerpages/mainpages/profileedit.dart';

class RetProfilePage extends StatefulWidget {
  const RetProfilePage({super.key});
  @override
  State<RetProfilePage> createState() => _RetProfilePageState();
}

class _RetProfilePageState extends State<RetProfilePage> {
  final TextEditingController _controller1 =
      TextEditingController(text: '4883743483');

  String name = '';
  String phoneNumber = '';
  String address = '';
  String place = '';
  String email = '';
  String yelan = 'Edit Profile';
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    GestureDetector(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height /
                                    2, // Half of the screen height
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      'https://upload.wikimedia.org/wikipedia/commons/d/d7/Cristiano_Ronaldo_playing_for_Al_Nassr_FC_against_Persepolis%2C_September_2023_%28cropped%29.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          'https://upload.wikimedia.org/wikipedia/commons/d/d7/Cristiano_Ronaldo_playing_for_Al_Nassr_FC_against_Persepolis%2C_September_2023_%28cropped%29.jpg',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_a_photo_rounded),
                      onPressed: () {},
                    ),
                  ],
                ),
                const Text(
                  'Cristiano Ronaldo',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'ID: 123456',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controller1,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    suffixIcon: Icon(Icons.edit),
                  ),
                  onChanged: (value) {
                    setState(() {
                      phoneNumber = value;
                    });
                  },
                  enabled: _isPressed,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    suffixIcon: Icon(Icons.edit),
                  ),
                  onChanged: (value) {
                    setState(() {
                      address = value;
                    });
                  },
                  enabled: _isPressed,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Place',
                    suffixIcon: Icon(Icons.edit),
                  ),
                  onChanged: (value) {
                    setState(() {
                      place = value;
                    });
                  },
                  enabled: _isPressed,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    suffixIcon: Icon(Icons.edit),
                  ),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  enabled: _isPressed,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                      ),
                      child: Text("$yelan", style: TextStyle(fontSize: 20)),
                      onPressed: () {
                        setState(
                          () {
                            _isPressed = !_isPressed;
                            if (_isPressed) {
                              yelan = 'Save Changes';
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Row(
                                    children: <Widget>[
                                      CircularProgressIndicator(),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Text('Editing Profile'),
                                      ),
                                    ],
                                  ),
                                  duration: Duration(seconds: 1),
                                ),
                              );

                              Future.delayed(const Duration(seconds: 1), () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Profile Updated'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              });
                              yelan = 'Edit Profile';
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
