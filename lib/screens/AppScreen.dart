import 'package:cartafri/core/constants/constants.dart';
import 'package:cartafri/core/commons/reusables.dart';
import 'package:cartafri/screens/account-settings.dart';
import 'package:cartafri/screens/cart.dart';
import 'package:cartafri/screens/home.dart';
import 'package:cartafri/screens/login_screen.dart';
import 'package:cartafri/screens/search_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var allItems = List.generate(50, (index) => 'item $index');
  var item = [];
  var searchHistory = [];
  int currentPageIndex = 0;
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            top: 12.0,
            right: 8.0,
          ),
          child: [
            AppHomePage(),
            ColumnWidget(children: SearchPageWidget().widgetList()),
            CartPage(),
            LoginPage()
          ][currentPageIndex],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: const Icon(
          Icons.shopping_cart_outlined,
          color: kButtonColor,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        animationDuration: const Duration(seconds: 2),
        selectedIndex: currentPageIndex,
        destinations: const [
          BottomBarIcons(
            iconData: Icons.home,
            label: 'Home',
            selectedIcon: Icons.home_outlined,
          ),
          BottomBarIcons(
            iconData: Icons.search,
            label: 'Search',
            selectedIcon: Icons.search,
          ),
          BottomBarIcons(
            iconData: Icons.feed_outlined,
            label: 'Feeds',
            selectedIcon: Icons.feed,
          ),
          BottomBarIcons(
            iconData: Icons.person,
            label: 'Accounts',
            selectedIcon: Icons.person_2_outlined,
          )
        ],
      ),
    );
  }
}

class ColumnWidget extends StatelessWidget {
  const ColumnWidget({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: children);
  }
}
