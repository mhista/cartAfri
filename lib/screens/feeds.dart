import 'package:cartafri/core/utils/constants/color_constants.dart';
import 'package:cartafri/core/utils/commons/animations.dart';
import 'package:cartafri/core/utils/constants/constants.dart';
import 'package:cartafri/core/utils/commons/error_test.dart';
import 'package:cartafri/core/utils/commons/isLoading.dart';
import 'package:cartafri/core/utils/commons/reusables.dart';
import 'package:cartafri/core/utils/commons/show_add_to_cart_sizes.dart';

import 'package:cartafri/core/utils/commons/snackbar.dart';

import 'package:cartafri/features/order_items/order_item_controller.dart';
import 'package:cartafri/features/products/product_controller.dart';
import 'package:cartafri/features/products/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';

GlobalKey _scaffold = GlobalKey();

class Feeds extends ConsumerWidget {
  const Feeds({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        leading: PrimaryIconButton(
          iconData: Icons.arrow_back,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("FEEDS",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            )),
        actions: const [
          IconAnimation(
            iconData: Icons.favorite_border_outlined,
            startColor: ColorConstants.kButtonColor,
            endColor: Colors.red,
            selectedIconData: Icons.favorite,
          )
        ],
      ),
    );
  }
}
