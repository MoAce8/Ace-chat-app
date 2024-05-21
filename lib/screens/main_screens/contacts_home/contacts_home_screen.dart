import 'package:ace_chat_app/models/user_model.dart';
import 'package:ace_chat_app/screens/main_screens/contacts_home/new_contact_sheet.dart';
import 'package:ace_chat_app/screens/main_screens/contacts_home/widgets/contact_card.dart';
import 'package:ace_chat_app/widgets/custom_text_field.dart';
import 'package:ace_chat_app/widgets/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ContactsHomeScreen extends StatefulWidget {
  const ContactsHomeScreen({Key? key}) : super(key: key);

  @override
  State<ContactsHomeScreen> createState() => _ContactsHomeScreenState();
}

class _ContactsHomeScreenState extends State<ContactsHomeScreen> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? AppTextField(
                label: 'Enter contact name',
                controller: searchController,
                autofocus: true,
                onChanged: (s) {
                  setState(() {
                    searchController.text = s!;
                  });
                },
              )
            : const Text('My Contacts'),
        actions: [
          isSearching
              ? IconButton(
                  onPressed: () {
                    if (searchController.text.isEmpty) {
                      isSearching = false;
                    }
                    setState(() {
                      searchController.clear();
                    });
                  },
                  icon: const Icon(Icons.clear),
                )
              : IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                )
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<UserModel> users = snapshot.data!.docs
                  .map((e) => UserModel.fromJson(e.data()))
                  .toList();
              List contacts = users
                  .where((element) =>
                      element.id == FirebaseAuth.instance.currentUser!.uid)
                  .first
                  .contacts;
              List myContacts = users
                  .where((element) => contacts.contains(element.id))
                  .where(
                    (element) => element.name
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase()),
                  )
                  .toList()
                ..sort(
                  (a, b) =>
                      a.name.toLowerCase().compareTo(b.name.toLowerCase()),
                );
              return ListView.builder(
                itemCount: myContacts.length,
                itemBuilder: (context, index) =>
                    ContactCard(user: myContacts[index]),
              );
            } else {
              return const LoadingIndicator();
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            )),
            context: context,
            builder: (context) => const NewContactSheet(),
          );
        },
        child: const Icon(Icons.message),
      ),
    );
  }
}
