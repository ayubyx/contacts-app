import 'package:contacts/db/contacts_db.dart';
import 'package:contacts/pages/home_page.dart';
import 'package:contacts/utils/textformfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final int id;
  final String firstName;
  final String lastName;
  final String number;
  const EditPage(
      {super.key,
      required this.firstName,
      required this.lastName,
      required this.number,
      required this.id});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  Contacts db = Contacts();
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController number = TextEditingController();
  @override
  void initState() {
    firstName.text = widget.firstName;
    lastName.text = widget.lastName;
    number.text = widget.number;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue.withOpacity(0.6),
          title: Text(
            "Edit Contact",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close, size: 25),
            color: Colors.white,
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 20),
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () async {
                      await db.updateContact(
                          'contacts',
                          {
                            'firstName': "${firstName.text}",
                            'lastName': "${lastName.text}",
                            'number': "${number.text}",
                          },
                          'id=${widget.id}');
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Home()),
                          (context) => false);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Contact updated succesfully"),
                        showCloseIcon: true,
                      ));
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(color: Colors.white),
                    ))),
          ]),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ContactTextField(
                  controller: firstName,
                  label: "First name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your firstName";
                    }
                    return null;
                  },
                  prefixIcon: Icon(
                    CupertinoIcons.person,
                    color: Colors.grey,
                  )),
              ContactTextField(
                  controller: lastName,
                  label: "Last name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your lastName";
                    }
                    return null;
                  },
                  prefixIcon: Icon(CupertinoIcons.person, color: Colors.grey)),
              ContactTextField(
                controller: number,
                label: "+212 Number",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your number";
                  }
                  return null;
                },
                type: TextInputType.number,
                prefixIcon: Icon(CupertinoIcons.phone, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
