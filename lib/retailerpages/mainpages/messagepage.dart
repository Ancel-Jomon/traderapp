import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:traderapp/components/button.dart';
import 'package:traderapp/components/mytextfeild.dart';
import 'package:traderapp/services/firestoreconnectionoptions.dart';

class RetMessagePage extends StatefulWidget {
  const RetMessagePage({super.key});

  @override
  State<RetMessagePage> createState() => _RetMessagePageState();
}

class _RetMessagePageState extends State<RetMessagePage> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Container(
                //color: Colors.amber,
                )),
        const Divider(),
        const ShowUser()
      ],
    );
  }
}

class ShowUser extends StatefulWidget {
  const ShowUser({super.key});

  @override
  State<ShowUser> createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  bool show = false;
  final TextEditingController uidcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('SEARCH USERS'),
          MyTextFeild(hinttext: 'usercode', textController: uidcontroller),
          const SizedBox(
            height: 5,
          ),
          MyButton(
              onPressed: () {
                setState(() {
                  show = true;
                });
              },
              msg: 'search'),
          const SizedBox(
            height: 10,
          ),
          (show == true
              ? showuser(uidcontroller.text, false)
              : const SizedBox.shrink())
        ],
      ),
    ));
  }

  Widget showuser(String id, bool value) {
    return FutureBuilder(
      future: FirestoreConnection().searchuser(id, value),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (snapshot.hasData) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              child: Image(
                                image: (data!['imgurl'] != null
                                    ? NetworkImage(data['imgurl'])
                                    : const AssetImage(
                                        'lib/assets/man.png')) as ImageProvider,
                              ),
                            ),
                            Text('${data['name']}')
                          ],
                        ),
                        MyButton(
                            onPressed: () async {
                            await  FirestoreConnection()
                                  .connect(id, value)
                                  .then((returnvalue) {
                                    log(returnvalue.toString());
                                if (returnvalue == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                     const SnackBar(
                                          content: Text(
                                              'you are already connected')));
                                } else if(returnvalue == false) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                     const SnackBar(
                                          content: Text(
                                              'you are now connected')));
                                }
                                else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                     const SnackBar(
                                          content: Text(
                                              'error')));
                                }
                              });
                            },
                            msg: 'connect')
                      ],
                    ),
                  ),
                ),
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        } else {
          return const Text('user not found');
        }
      },
    );
  }
}
