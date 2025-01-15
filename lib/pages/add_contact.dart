import 'package:contacts/db/contacts_db.dart';
import 'package:contacts/pages/home_page.dart';
import 'package:contacts/utils/textformfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController number = TextEditingController();
  Contacts contact = Contacts();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue.withOpacity(0.6),
          title: Text(
            "Create Contact",
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
                      if (_formKey.currentState!.validate()) {
                        int response = await contact.addContact('contacts', {
                          'firstName': "${firstName.text}",
                          'lastName': "${lastName.text}",
                          'number': "${number.text}",
                        });
                        firstName.clear();
                        lastName.clear();
                        number.clear();
                        if (response > 0) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Home()),
                              (context) => false);
                        }
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Contact created succesfully"),
                          showCloseIcon: true,
                        ));
                      }
                    },
                    child: Text(
                      "Save",
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
