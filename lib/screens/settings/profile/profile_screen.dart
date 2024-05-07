import 'package:ace_chat_app/screens/settings/profile/widgets/profile_card.dart';
import 'package:ace_chat_app/shared/constants.dart';
import 'package:ace_chat_app/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameCont = TextEditingController();
  TextEditingController aboutCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  bool nameEditable = false;
  bool aboutEditable = false;

  @override
  void initState() {
    nameCont.text = 'Mohammed Tharwat';
    aboutCont.text = 'Flutter Developer';
    emailCont.text = 'mohammedtharwat21@gmail.com';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const CircleAvatar(
                      radius: 70,
                    ),
                    Positioned(
                      bottom: -10,
                      right: -10,
                      child: IconButton.filled(
                        onPressed: () {},
                        icon: const Icon(Icons.camera_alt),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight(context) * .025,
              ),
              ProfileCard(
                title: 'Name',
                controller: nameCont,
                enabled: nameEditable,
                icon: FontAwesomeIcons.user,
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      nameEditable = !nameEditable;
                    });
                  },
                  icon: Icon(
                    nameEditable ? Icons.check_circle_outline : Icons.edit,
                  ),
                ),
              ),
              ProfileCard(
                title: 'About',
                controller: aboutCont,
                enabled: aboutEditable,
                icon: FontAwesomeIcons.info,
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      aboutEditable = !aboutEditable;
                    });
                  },
                  icon: Icon(
                    aboutEditable ? Icons.check_circle_outline : Icons.edit,
                  ),
                ),
              ),
              ProfileCard(
                title: 'Email',
                controller: emailCont,
                enabled: false,
                icon: Icons.alternate_email,
              ),
              SizedBox(
                height: screenHeight(context) * .05,
              ),
              AppButton(
                text: 'Save',
                function: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}