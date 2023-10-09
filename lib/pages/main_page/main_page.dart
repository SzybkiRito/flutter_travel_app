import 'package:flutter/material.dart';
import 'package:travel_planning_app/custom_widgets/navbar/custom_bottom_navigation_bar.dart';
import 'package:travel_planning_app/custom_widgets/navbar/custom_top_navigation_bar.dart';
import 'package:travel_planning_app/pages/home_page/home_page.dart';
import 'package:travel_planning_app/pages/trip_creation_page/trip_creation_page.dart';
import 'package:travel_planning_app/pages/user_profile_page/user_profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedTab = 0;
  int _previousSelectedTab = 0;
  final RegExp _pageNameDivider = RegExp(r'([a-z])([A-Z])');
  final List<Widget> _screens = const [
    HomePage(),
    TripCreationPage(),
    UserProfilePage(),
  ];

  void _navigateToScreen(int index) {
    setState(() {
      _previousSelectedTab = _selectedTab;
      _selectedTab = index;
    });
  }

  String _getScreenName(int index) {
    return _screens[index].toStringShort().split('Page').join('').replaceAllMapped(
          _pageNameDivider,
          (match) => '${match.group(1)} ${match.group(2)}',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopNavgationBar(
        title: _selectedTab == 0 ? "Travel planning" : _getScreenName(_selectedTab),
        onLeadingIconButtonTap: () {
          _navigateToScreen(_previousSelectedTab);
        },
        onTrailingIconButtonTap: () {},
        isBackButtonVisible: _selectedTab != 0,
      ),
      bottomNavigationBar: CustomBottonNavigationBar(
        selectedTab: _selectedTab,
        navigateToScreen: _navigateToScreen,
      ),
      body: _screens[_selectedTab],
    );
  }
}
