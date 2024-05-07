import 'package:ace_chat_app/screens/main_screens/contacts_home/new_contact_sheet.dart';
import 'package:ace_chat_app/screens/main_screens/contacts_home/widgets/contact_card.dart';
import 'package:ace_chat_app/widgets/custom_text_field.dart';
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
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) => const ContactCard(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
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
