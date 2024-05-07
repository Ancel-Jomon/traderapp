import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:traderapp/models/current_userdetails.dart';
import 'package:traderapp/models/supplier.dart';
import 'package:traderapp/models/user.dart';
import 'package:traderapp/services/firestoreuseroptions.dart';

class ProfilePage extends StatefulWidget {
  final userdata = FirebaseAuth.instance.currentUser;
  ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // MyUser user=getCurrentUser();

  //  final TextEditingController _controller4 =
  // TextEditingController(text: '4883743483');
  //  final TextEditingController _controller5 =
  // TextEditingController(text: '4883743483');
  XFile? image;
  Uint8List? file;
  String? url;
  String yelan = 'Edit Profile';
  bool iseditable = false;
  bool? value;
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController addresscontroller = TextEditingController();
  final TextEditingController phnocontroller = TextEditingController();
  final TextEditingController companycontroller = TextEditingController();

  late MyUser user;
  

  @override
  void dispose() {
    // TODO: implement dispose
    namecontroller.dispose();
    addresscontroller.dispose();
    phnocontroller.dispose();
    companycontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<CurrentUserDraft>(context).getCurrentUser();
    namecontroller.text = user.name;
    addresscontroller.text = user.address ?? '';
    phnocontroller.text = user.phno ?? '';
    companycontroller.text = user.company ?? '';
    final ImageProvider def = image != null
        ? MemoryImage(file!)
        : (user.imgurl != null
            ? NetworkImage(user.imgurl!)
            : const AssetImage(
                'lib/assets/man.png',
              )) as ImageProvider;
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
                                    image: def,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: CircleAvatar(radius: 50, backgroundImage: def),
                    ),
                    IconButton(
                        icon: const Icon(Icons.add_a_photo_rounded),
                        onPressed: uploadimage),
                  ],
                ),
                // const Text(
                //   'Cristiano Ronaldo',
                //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                // ),
                const SizedBox(height: 10),
                Text(
                  'ID: ${widget.userdata!.uid}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: namecontroller,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    //suffixIcon: Icon(Icons.edit),
                  ),
                  enabled: iseditable,
                ),
                TextFormField(
                  controller: companycontroller,
                  decoration: const InputDecoration(
                    labelText: 'company',
                    //suffixIcon: Icon(Icons.edit),
                  ),
                  enabled: iseditable,
                ),
                TextFormField(
                  controller: addresscontroller,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    //suffixIcon: Icon(Icons.edit),
                  ),
                  enabled: iseditable,
                ),
                TextFormField(
                  controller: phnocontroller,
                  decoration: const InputDecoration(
                    labelText: 'Phno',
                    //suffixIcon: Icon(Icons.edit),
                  ),
                  enabled: iseditable,
                ),
                TextFormField(
                  controller: TextEditingController(text: widget.userdata!.email ),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    //suffixIcon: Icon(Icons.edit),
                  ),
                  enabled: false,
                ),
                const SizedBox(height: 20),
                TweenAnimationBuilder(
                  tween: ColorTween(
                      begin: Colors.blue,
                      end: iseditable ? Colors.green : Colors.blue),
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
                      child: Text(yelan, style: const TextStyle(fontSize: 20)),
                      onPressed: () {
                        setState(
                          () {
                            iseditable = !iseditable;
                            value=true;
                            if (iseditable) {
                              yelan = 'Save Changes';
                            } else {
                              updateuserinfo(
                                  namecontroller.text,
                                  companycontroller.text,
                                  phnocontroller.text,
                                  addresscontroller.text,user.imgurl);
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

  void updateuserinfo(String name, company, phno, address,imgurl) async {
    showsnackbar(value);
    Supplier userdata = Supplier(
        supplierName: name, scompany: company, sphno: phno, saddress: address,simgurl: imgurl);
    
    final obj = FirestoreWriteUser();
    if (image != null) {
     url=  await obj.uploadprofileimage(image!);
    }
   
    if (imgurl != null && url != null) {
      // if there is img in database and new image is uplaoded delete old image
      obj.deleteprofileimage(imgurl);
      userdata.imgurl = url;
    } else if (imgurl == null && url != null) {
      //if no image in database add the new image
      userdata.imgurl = url;
    }
   

    obj.updateprofile(userdata.toFirestore());
    await FirestoreReadUser().readUserInfo().then((ctuser) {
      showsnackbar(false);
      Provider.of<CurrentUserDraft>(context, listen: false)
          .loadCurrentUser(ctuser);
    });
  }

  void showsnackbar(bool? value) {
    if (value==true) {
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
    } else if(value==false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile Updated'),
          duration: Duration(seconds: 1),
        ));
    }

    
  }

  uploadimage() async {
    XFile? img = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (img != null) {
      Uint8List filex = await img.readAsBytes();
      setState(() {
        file = filex;
        image = img;
      });

    }
  }
}
