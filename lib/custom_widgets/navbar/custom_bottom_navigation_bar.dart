import 'package:flutter/material.dart';

class CustomBottonNavigationBar extends StatelessWidget {
  const CustomBottonNavigationBar({
    super.key,
    required this.selectedTab,
    required this.navigateToScreen,
  });
  final int selectedTab;
  final void Function(int) navigateToScreen;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedTab,
      onTap: navigateToScreen,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
            color: Colors.black,
          ),
          activeIcon: Icon(
            Icons.home,
            color: Colors.black,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.file_copy_outlined,
            color: Colors.black,
          ),
          activeIcon: Icon(
            Icons.file_copy,
            color: Colors.black,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle_outlined,
            color: Colors.black,
          ),
          activeIcon: Icon(
            Icons.account_circle,
            color: Colors.black,
          ),
          label: '',
        ),
      ],
    );
  }
}
