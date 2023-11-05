import 'package:cartafri/app_config/constants.dart';
import 'package:cartafri/app_config/reusables.dart';
import 'package:cartafri/screens/home.dart';
import 'package:cartafri/screens/home_page.dart';
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
            ColumnWidget(children: HomePageWidget().widgetList()),
            ColumnWidget(children: SearchPageWidget().widgetList()),
            ColumnWidget(children: HomePageWidget().widgetList()),
            ColumnWidget(children: SearchPageWidget().widgetList())
          ][currentPageIndex],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.shopping_cart_outlined,
          color: kButtonColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        backgroundColor: kCardColor,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        animationDuration: Duration(seconds: 2),
        indicatorColor: kButtonColorOpaque,
        selectedIndex: currentPageIndex,
        destinations: [
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
            iconData: Icons.manage_accounts,
            label: 'Accounts',
            selectedIcon: Icons.manage_accounts_outlined,
          )
        ],
        backgroundColor: kCardColor,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
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
