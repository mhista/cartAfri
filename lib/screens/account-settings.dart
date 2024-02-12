import 'package:cartafri/core/utils/constants/color_constants.dart';
import 'package:cartafri/core/utils/constants/constants.dart';
import 'package:cartafri/core/utils/commons/reusables.dart';
import 'package:cartafri/core/functionality/account_properties.dart';
import 'package:cartafri/features/auth/repository/authRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  final accountTiles = ListTileProperties(size: 19.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: 'Profile'),
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
                  return const Divider(height: 1);
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
                    child: const Text('Terms of Use', style: kSmallFont)),
              ),
              const Text('and', style: kSmallFont),
              TextButton(
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () {},
                  child: const Text('Privacy policy', style: kSmallFont)),
            ]),
            ExpandedButton(
              onpress: () {
                ref.read(authRepositoryProvider).signout();
              },
              text: const Text('Sign Out'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
              child: Divider(
                height: 0.5,
              ),
            ),

            TextButton(
                style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                ),
                onPressed: () {},
                child: const Text('@ 2023 CartAfri, Built by SomTech',
                    style: kMediumFont)),
            const Spacer(flex: 1)
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
      onTap: () {
        Routemaster.of(context)
            .push("/account/${accountTiles.getRoute(index)}");
      },
      focusColor: ColorConstants.kButtonColorOpaque,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      leading: accountTiles.getIcon(index),
      title: Text(accountTiles.getTitle(index), style: kMediumFont),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
    );
  }
}
