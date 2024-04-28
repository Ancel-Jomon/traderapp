import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traderapp/components/button.dart';
import 'package:traderapp/components/mytextfeild.dart';
import 'package:traderapp/models/current_userdetails.dart';
import 'package:traderapp/models/retailer.dart';
import 'package:traderapp/models/supplier.dart';
//import 'package:traderapp/models/user.dart';
//import 'package:traderapp/services/firebaseauthentication.dart';
import 'package:traderapp/services/firestoreoptions.dart';
//import 'package:traderapp/themes.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final TextEditingController name = TextEditingController();

  final TextEditingController company = TextEditingController();

  final TextEditingController phone = TextEditingController();

  final TextEditingController address = TextEditingController();

  final List<String> options = ['None', 'supplier', 'retailer'];

  String? selectedOption = 'None';

  FirestoreAddUser addUser = FirestoreAddUser();

  @override
  void dispose() {
    name.dispose();
    company.dispose();
    phone.dispose();
    address.dispose();
    super.dispose();
  }

  void onPressed(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final uid = user?.uid;

    if (selectedOption == 'supplier') {
      Supplier supplier = Supplier(
          supplierName: name.text,
          scompany: company.text,
          sphno: phone.text,
          saddress: address.text);
      addUser.addUserDetail(supplier, uid);
      Provider.of<CurrentUserDraft>(context).loadCurrentUser(supplier);

      Navigator.pushNamedAndRemoveUntil(context, '/SupHome', (route) => false);
    } else if (selectedOption == 'retailer') {
      Retailer retailer = Retailer(
          retailername: name.text,
          rcompany: company.text,
          rphno: phone.text,
          raddress: address.text);
      addUser.addUserDetail(retailer, uid);
       Provider.of<CurrentUserDraft>(context).loadCurrentUser(retailer);

      Navigator.pushNamedAndRemoveUntil(context, '/RetHome', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: const Text('Enter Your Details'),
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
            child: DropdownButtonFormField(
              dropdownColor: Theme.of(context).colorScheme.tertiary,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
              value: selectedOption,
              items: options.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedOption = value;
                });
              },
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.background))),
            ),
          ),
          MyTextFeild(
            hinttext: 'name',
            textController: name,
          ),
          const SizedBox(
            height: 10,
          ),
          MyTextFeild(
            hinttext: 'company name',
            textController: company,
          ),
          const SizedBox(
            height: 10,
          ),
          MyTextFeild(
            hinttext: 'phone number',
            textController: phone,
          ),
          const SizedBox(
            height: 10,
          ),
          MyTextFeild(
            hinttext: 'address',
            textController: address,
          ),
          const SizedBox(
            height: 10,
          ),
          MyButton(onPressed: () => onPressed(context), msg: 'FINISH')
        ],
      ),
    );
  }
}
