import 'package:ace_chat_app/cubit/user_cubit/user_cubit.dart';
import 'package:ace_chat_app/screens/home/tabs_screen/bottom_nav.dart';
import 'package:ace_chat_app/screens/main_screens/chat_home/chats_home_screen.dart';
import 'package:ace_chat_app/screens/main_screens/contacts_home/contacts_home_screen.dart';
import 'package:ace_chat_app/screens/main_screens/groups_home/groups_home_screen.dart';
import 'package:ace_chat_app/screens/main_screens/settings_home/settings_screen.dart';
import 'package:flutter/material.dart';

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
