import 'package:cartafri/core/utils/constants/color_constants.dart';
import 'package:cartafri/core/utils/commons/reusables.dart';
import 'package:cartafri/screens/account-settings.dart';
import 'package:cartafri/screens/feeds.dart';
import 'package:cartafri/screens/home.dart';

import 'package:cartafri/screens/splashScreens/splash_screen1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  // var allItems = List.generate(50, (index) => 'item $index');
  // var item = [];
  // var searchHistory = [];
  int currentPageIndex = 0;

  // final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

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
            const SplashScreen1(),
            const Feeds(),
            const AccountPage()
          ][currentPageIndex],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Routemaster.of(context).push("/cart");
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: const Icon(
            Icons.shopping_cart_outlined,
            color: ColorConstants.kButtonColor,
          )),
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
