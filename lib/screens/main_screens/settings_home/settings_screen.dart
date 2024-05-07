import 'package:ace_chat_app/screens/main_screens/settings_home/widgets/settings_card.dart';
import 'package:ace_chat_app/screens/settings/profile/profile_screen.dart';
import 'package:ace_chat_app/screens/settings/qr_code/qr_code_screen.dart';
import 'package:ace_chat_app/shared/constants.dart';
import 'package:ace_chat_app/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                radius: 28,
              ),
              title: const Text('Mohammed Tharwat'),
              trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QRCodeScreen(),
                      ));
                },
                icon: const Icon(Icons.qr_code),
              ),
            ),
            SizedBox(
              height: screenHeight(context) * .025,
            ),
            SettingsCard(
              title: 'Profile',
              icon: Icons.person,
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ));
              },
            ),
            SettingsCard(
              title: 'Theme',
              icon: Icons.color_lens_outlined,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: SingleChildScrollView(
                      child: BlockPicker(
                        pickerColor: Colors.indigo,
                        onColorChanged: (value) {},
                      ),
                    ),
                    actions: [
                      AppButton(
                          text: 'Done',
                          function: () {
                            Navigator.pop(context);
                          })
                    ],
                  ),
                );
              },
            ),
            SettingsCard(
              title: 'Dark Mode',
              icon: CupertinoIcons.moon,
              trailing: Switch(
                value: true,
                onChanged: (value) {},
              ),
            ),
            SizedBox(
              height: screenHeight(context) * .05,
            ),
            const SettingsCard(
              title: 'Sign Out',
              trailing: Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
