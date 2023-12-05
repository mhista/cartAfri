import 'package:cartafri/core/constants/constants.dart';
import 'package:cartafri/core/commons/reusables.dart';
import 'package:cartafri/features/functionality/account_properties.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final accountTiles = ListTileProperties(size: 19.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(title: 'Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            // Column(
            //   children:  List.generate(50, (index) => ),
            // ),
            Expanded(
              flex: 8,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(height: 1);
                },
                itemBuilder: (context, index) {
                  return AccountListTile(
                      accountTiles: accountTiles, index: index);
                },
                itemCount: accountTiles.getTileLength(),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: TextButton(
                    style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    onPressed: () {},
                    child: Text('Terms of Use', style: kSmallFont)),
              ),
              Text('and', style: kSmallFont),
              TextButton(
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () {},
                  child: Text('Privacy policy', style: kSmallFont)),
            ]),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0))),
                  child: const Text('Sign Out')),
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
              child: Divider(
                height: 0.5,
              ),
            ),

            TextButton(
                style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                ),
                onPressed: () {},
                child: Text('@ 2023 CartAfri, Built by SomTech',
                    style: kMediumFont)),
            Spacer(flex: 1)
          ],
        ),
      ),
    );
  }
}

class AccountListTile extends StatelessWidget {
  const AccountListTile({
    super.key,
    required this.accountTiles,
    required this.index,
    this.needDivider,
  });

  final ListTileProperties accountTiles;
  final int index;
  final bool? needDivider;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      focusColor: kButtonColorOpaque,
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      leading: accountTiles.getIcon(index),
      title: Text(accountTiles.getTitle(index), style: kMediumFont),
      trailing: Icon(Icons.arrow_forward_ios, size: 14),
    );
  }
}
