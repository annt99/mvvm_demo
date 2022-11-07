import 'package:flutter/material.dart';
import 'package:mvvm_demo/core/utils/color_manager.dart';
import 'package:mvvm_demo/core/utils/string_manager.dart';
import 'package:mvvm_demo/core/utils/value_manager.dart';
import 'package:mvvm_demo/presentation/main/home/home_page.dart';
import 'package:mvvm_demo/presentation/main/notifications_page.dart';
import 'package:mvvm_demo/presentation/main/search_page.dart';
import 'package:mvvm_demo/presentation/main/setting_page.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    NotificationsPage(),
    SettingPage()
  ];
  final List<String> _titles = const [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notification,
    AppStrings.setting,
  ];
  var _title = AppStrings.home;
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        _title,
        style: Theme.of(context).textTheme.headline2,
      )),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: ColorManager.lightGray, spreadRadius: 0.5)
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.gray,
          currentIndex: _currentIndex,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: AppStrings.home),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: AppStrings.search),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: AppStrings.notification),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: AppStrings.setting),
          ],
        ),
      ),
    );
  }

  void onTap(int value) {
    setState(() {
      _currentIndex = value;
      _title = _titles[value];
    });
  }
}
