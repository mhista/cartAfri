import 'dart:convert';

import 'package:cartafri/core/utils/constants/color_constants.dart';
import 'package:cartafri/core/utils/commons/animations.dart';
import 'package:cartafri/core/utils/constants/constants.dart';
import 'package:cartafri/core/utils/commons/error_test.dart';
import 'package:cartafri/core/utils/commons/isLoading.dart';
import 'package:cartafri/features/payment/paystack/payastack_utils.dart';
import 'package:cartafri/core/utils/commons/reusables.dart';
import 'package:cartafri/features/auth/controller/authController.dart';
import 'package:cartafri/features/auth/repository/authRepository.dart';
import 'package:cartafri/features/home/search_delegate.dart';
import 'package:cartafri/features/payment/payment_models/initiate_transaction.dart';
import 'package:cartafri/features/products/product_controller.dart';
import 'package:cartafri/features/products/product_model.dart';
import 'package:cartafri/core/utils/theme/pallete.dart';
import 'package:cartafri/screens/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';

class AppHomePage extends ConsumerWidget {
  AppHomePage({super.key});
  final product = product_list;

  void addToFireBase(
      BuildContext context, WidgetRef ref, List<Map<String, dynamic>> product) {
    // print(product);
    final productController = ref.read(productControllerProvider.notifier);
    const uuid = Uuid();
    for (var el in product) {
      productController.createProduct(context,
          id: uuid.v4(),
          title: el['title'],
          price: el['price'],
          company: el['company'],
          size: el['size'],
          imageUrl: el['imageUrl'],
          itemCount: el['itemCount']);
    }
  }

  void paystackInitialization(BuildContext context) {
    final initiateModel = InitiateModel(
      email: 'diweesomchi@gmail.com',
      amount: '1000', //product.price.toString().split(".").join()
      reference: Utills.uniqueReference(),
    ).toJson();

    Map<String, String> queryParameters = {
      "initiateModel": initiateModel,
    };
    Routemaster.of(context).push("/payment", queryParameters: queryParameters);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final theme = ref.watch(themeNotifierProvider.notifier);
    return SafeArea(
      child: CustomScrollView(slivers: [
        // greeting widget
        SliverAppBar(
          expandedHeight: 0,
          centerTitle: false,
          flexibleSpace: FlexibleSpaceBar(
            background: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              title: Text(
                'Hi, ${user.name}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: SearchProductDelegate(ref: ref));
                // addToFireBase(context, ref, product);
              },
              icon: const Icon(Icons.search_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_outlined),
            ),
            IconButton(
              onPressed: () {
                theme.toggleTheme();
              },
              icon: theme.mode == ThemeMode.dark
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.dark_mode),
            )
          ],
        ),
        // categories and see all widget
        SliverAppBar(
          expandedHeight: 0.0,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            background: ListTile(
              leading: const Text(
                'Categories',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              trailing: TextButton(
                onPressed: () {},
                child: const Text('See all'),
              ),
            ),
          ),
        ),
        SliverAppBar(
          stretch: true,
          pinned: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Material(
                  color: Theme.of(context).cardTheme.surfaceTintColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 0.1,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: theme.mode == ThemeMode.dark
                          ? ColorConstants.kCardColorD
                          : ColorConstants.kCardColor,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 1.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            CategoryIconButton(
                              iconData: Icons.shopping_cart_outlined,
                              onPressed: () {},
                              color: ColorConstants.kButtonColor,
                            ),
                            const Text(
                              'Grocery',
                              style: kMediumFont,
                            )
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            CategoryIconButton(
                              iconData: Icons.change_history_outlined,
                              onPressed: () {},
                              bgColor: ColorConstants.kButtonColor,
                              color: ColorConstants.kCardColor,
                            ),
                            const Text('Cloth', style: kMediumFont)
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            CategoryIconButton(
                              iconData: Icons.wine_bar_outlined,
                              onPressed: () {},
                              color: ColorConstants.kButtonColor,
                            ),
                            const Text('Liquor', style: kMediumFont)
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            CategoryIconButton(
                              iconData: Icons.fastfood_outlined,
                              onPressed: () {},
                              bgColor: ColorConstants.kButtonColor,
                              color: ColorConstants.kCardColor,
                            ),
                            const Text('Food', style: kMediumFont)
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
        const ProductListBuilder()
      ]),
    );
  }
}

class ProductListBuilder extends ConsumerWidget {
  const ProductListBuilder({
    super.key,
  });

  void navigateToDetail(BuildContext context, Product product) {
    // Routemaster.of(context).push('/product/${product.id}');
    Navigator.of(context)
        .push(PageTransition2(route: ProductDetail(id: product.id)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(productsProvider).when(
          data: (products) {
            return SliverList.builder(
              itemCount: (products.length / 2).round(),
              itemBuilder: (context, index) {
                final product = products[index];
                final tag = product.id;
                return GestureDetector(
                  onTap: () => navigateToDetail(context, product),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 9.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(
                              height: 100.0,
                              width: 100.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Hero(
                                  tag: tag,
                                  child: Image.asset(product.imageUrl[0],
                                      height: 100.0, fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(
                                            left: 9.0, top: 11.0, bottom: 3.0),
                                        child: Text(product.title,
                                            style: kProductStyle)),
                                    const Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: RowTextReview(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Row(children: [
                                        const Icon(
                                            Icons.store_mall_directory_outlined,
                                            color: ColorConstants.kGreyColor2),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 3.0),
                                          child: Text(product.company),
                                        ),
                                      ]),
                                    )
                                  ]),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(bottom: 8.0),
                                      child: IconAnimation(
                                        iconData: Icons.favorite,
                                        startColor: ColorConstants.kGreyColor,
                                        endColor: Colors.red,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text('\$${product.price}',
                                        style: kProductStyle),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          error: (error, stackTrace) {
            return SliverToBoxAdapter(
              child: ErrorText(
                error: error.toString(),
              ),
            );
          },
          loading: () => const SliverToBoxAdapter(child: Loader()),
        );
  }
}
