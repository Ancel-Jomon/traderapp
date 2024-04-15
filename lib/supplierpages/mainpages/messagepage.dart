import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:traderapp/components/button.dart';
import 'package:traderapp/components/mytextfeild.dart';
import 'package:traderapp/services/firestoreconnectionoptions.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
   bool show = false;

  final TextEditingController uidcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Container(
                //color: Colors.amber,
                )),
        const Divider(),
        Expanded(
            child: SingleChildScrollView(
              child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
              const Text('SEARCH USERS'),
              MyTextFeild(hinttext: 'usercode', textController: uidcontroller),
              const SizedBox(
                height: 5,
              ),
              MyButton(onPressed: () {
                setState(() {
                  show=true;
                });
              }, msg: 'search'),
              const SizedBox(
                height: 10,
              ),
              (show == true ?  showuser(uidcontroller.text, true) : const SizedBox.shrink())
                        ],
                      ),
            ))
      ],
    );
  }

  Widget showuser(String id, bool value) {
    return FutureBuilder(
      future: FirestoreConnection().searchuser(id, value),
      builder: (context, snapshot) {
        final data=snapshot.data;
        if (snapshot.hasData) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding:  const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                         Row(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              child: Image(
                                image:( data!['imgurl']!=null ? NetworkImage(data['imgurl']) :const AssetImage('lib/assets/man.png')) as ImageProvider,
                              ),
                            ),
                            Text('${data['name']}')
                          ],
                        ),
                        MyButton(onPressed: () {}, msg: 'connect')
                      ],
                    ),
                  ),
                ),
              );
            default:
            return const   Center(child: CircularProgressIndicator());
          }
        } else {
          return const Text('user not found');
        }
      },
    );
  }
}
