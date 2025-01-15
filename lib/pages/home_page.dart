import 'package:contacts/db/contacts_db.dart';
import 'package:contacts/pages/add_contact.dart';
import 'package:contacts/pages/edit_contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Contacts db = Contacts();
  List contacts = [];
  bool isLoading = true;
  Future<void> readData() async {
    List<Map> data = await db.readContact('contacts');
    contacts.addAll(data);
    isLoading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.6),
        title: Text("Contacts", style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddContact()));
        },
        child: Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.white,
            ))
          : contacts.isEmpty
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/call-icon.png",
                      height: 90,
                      color: Colors.white,
                    ),
                    Text(
                      "No Contacts Yet, Try To Add New Person",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ))
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: contacts.length,
                  itemBuilder: (context, i) {
                    return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Card(
                            child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => EditPage(
                                      id: contacts[i]['id'],
                                      firstName: contacts[i]['firstName'],
                                      lastName: contacts[i]['lastName'],
                                      number:
                                          contacts[i]['number'].toString()))),
                          child: ListTile(
                              tileColor: Colors.blue.withOpacity(0.1),
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Text(
                                  "${contacts[i]['firstName'][0]}",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(
                                "${contacts[i]['firstName']}" +
                                    " " +
                                    "${contacts[i]['lastName']}",
                                style: TextStyle(color: Colors.black),
                              ),
                              subtitle: Text("${contacts[i]['number']}"),
                              trailing: IconButton(
                                  onPressed: () async {
                                    int response = await db.deleteContact(
                                        'contacts', "id=${contacts[i]['id']}");
                                    if (response > 0) {
                                      setState(() {
                                        contacts.removeWhere((e) =>
                                            e['id'] == contacts[i]['id']);
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            "Contact deleted successfully"),
                                        showCloseIcon: true,
                                      ));
                                    }
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ))),
                        )));
                  }),
    );
  }
}
