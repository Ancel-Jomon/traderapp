import 'package:flutter/material.dart';
import 'package:traderapp/retailerpages/mainpages/profileedit.dart';

class RetProfilePage extends StatelessWidget {
  const RetProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
             const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/d/d7/Cristiano_Ronaldo_playing_for_Al_Nassr_FC_against_Persepolis%2C_September_2023_%28cropped%29.jpg'),
              ),
             const SizedBox(height: 10),
             const Text(
                'ronaldo',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
             const SizedBox(height: 10),
            const  Text(
                'ID: 123456',
                style: TextStyle(fontSize: 16),
              ),
            const  SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileEdit(),
                    ),
                  );
                },
                child: const Text('Edit Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
