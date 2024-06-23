import 'package:ace_chat_app/cubit/theme_cubit/theme_cubit.dart';
import 'package:ace_chat_app/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuildBottomNavBar extends StatelessWidget {
  const BuildBottomNavBar({
    Key? key,
    required this.selectScreen,
    required this.activeScreen,
  }) : super(key: key);

  final void Function(int) selectScreen;
  final int activeScreen;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        // highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
      child: BottomNavigationBar(
        elevation: 10,
        onTap: selectScreen,
        currentIndex: activeScreen,
        selectedItemColor: ThemeCubit.get(context).mainColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: screenWidth(context) * 0.028,
        selectedFontSize: screenWidth(context) * 0.028,
        iconSize: screenWidth(context) * 0.085,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_text_fill),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_2_fill),
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.gear_alt_fill),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
