import 'package:ace_chat_app/cubit/user_cubit/user_cubit.dart';
import 'package:ace_chat_app/firebase/fire_auth.dart';
import 'package:ace_chat_app/screens/home/tabs_screen/bottom_nav.dart';
import 'package:ace_chat_app/screens/main_screens/chat_home/chats_home_screen.dart';
import 'package:ace_chat_app/screens/main_screens/contacts_home/contacts_home_screen.dart';
import 'package:ace_chat_app/screens/main_screens/groups_home/groups_home_screen.dart';
import 'package:ace_chat_app/screens/main_screens/settings_home/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeScreen = 0;
  PageController pageController = PageController();

  void swipeSelectScreen(int id) {
    setState(() {
      activeScreen = id;
    });
  }

  void clickSelectScreen(int id) {
    setState(() {
      swipeSelectScreen(id);
      pageController.jumpToPage(id);
    });
  }

  @override
  void initState() {
    FireAuth().updateOnline(true);
    SystemChannels.lifecycle.setMessageHandler(
      (message) {
        if (message.toString() == 'AppLifecycleState.resumed') {
          FireAuth().updateOnline(true);
        } else if (message.toString() == 'AppLifecycleState.paused' ||
            message.toString() == 'AppLifecycleState.inactive') {
          FireAuth().updateOnline(false);
        }
        return Future.value(message);
      },
    );
    UserCubit.get(context).getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: swipeSelectScreen,
        children: const [
          ChatsHomeScreen(),
          GroupsHomeScreen(),
          ContactsHomeScreen(),
          SettingsScreen()
        ],
      ),
      bottomNavigationBar: BuildBottomNavBar(
        selectScreen: clickSelectScreen,
        activeScreen: activeScreen,
      ),
    );
  }
}
