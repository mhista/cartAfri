import 'package:cartafri/core/constants/constants.dart';
import 'package:cartafri/core/utils/error_test.dart';
import 'package:cartafri/core/utils/isLoading.dart';
import 'package:cartafri/core/utils/reusables.dart';
import 'package:cartafri/core/utils/snackBar.dart';
import 'package:cartafri/features/order_items/order_item_controller.dart';
import 'package:cartafri/features/order_items/order_item_model.dart';
import 'package:cartafri/features/products/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';

GlobalKey _scaffold = GlobalKey();

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  final product = product_list;

  void increaseItemCount(Product product, int size) async {
    ref.read(orderItemController.notifier).createOrUpdateOrderItem(context,
        id: const Uuid().v4(), product: product, quantity: 1, size: size);
    if (product.itemCount == 0) {
      showSnackbar2(context, 'out of stock');
    } else {
      showSnackbar2(context, 'Item updated');
    }
  }

  void decreaseItemCount(OrderItem item) async {
    ref
        .read(orderItemController.notifier)
        .decreaseOrderItem(context, orderItem: item);
    showSnackbar2(context, '1 Item removed');
    // Routemaster.of(context).pop();
  }

  void navigateToCheckout() => Routemaster.of(context).push('/checkout');
  @override
  build(BuildContext context) {
    return Scaffold(
        key: _scaffold,
        appBar: AppBar(
            title: const AppBarTitle(
          title: 'CART',
        )),
        body: Column(
          children: [
            ref.watch(getorderItemProvider).when(
                data: (data) {
                  if (data.isEmpty) {
                    return const Center(child: Text('No current Order'));
                  }
                  return Column(
                    children: [
                      SizedBox(
                        height: 400,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 10),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final item = data[index];
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 9.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 100.0,
                                      width: 100.0,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            item.product.imageUrl[0],
                                            height: 1000.0,
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16.0, top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        textDirection: TextDirection.ltr,
                                        children: [
                                          Text(
                                            item.product.title,
                                            style: kProductStyle,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              // Text('\$${item.price}'),
                                              Text(item.product.price
                                                  .toString()),
                                              const SizedBox(width: 10.0),
                                              const Text('\$34.00',
                                                  style: kProductStyle),
                                            ],
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                RoundIconButton(
                                                  iconChild: Icons.remove,
                                                  onPressed: () {
                                                    decreaseItemCount(item);
                                                  },
                                                  fillColor:
                                                      const Color(0x734065f4),
                                                ),
                                                // SizedBox(
                                                //   width:10
                                                // ),
                                                Text(item.quantity.toString()),
                                                RoundIconButton(
                                                  iconChild: Icons.add,
                                                  onPressed: () {
                                                    increaseItemCount(
                                                        item.product,
                                                        item.size);
                                                  },
                                                  fillColor:
                                                      const Color(0xff4065f4),
                                                ),
                                              ])
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        leading: const Icon(Icons.money_rounded),
                        title: const Text('Promo Code'),
                        trailing: CustomFilledButton(
                          text: 'Find',
                          onPress: () {},
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            ref.watch(getOrderTotal).when(
                                data: (data) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'SubTotal',
                                        ),
                                        Text(
                                          '\$${data.toStringAsFixed(2)}',
                                          style: kProductStyle,
                                        ),
                                      ],
                                    ),
                                error: (error, stackTrace) =>
                                    ErrorText(error: error.toString()),
                                loading: () => const Loader()),
                            const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Delivery',
                                  ),
                                  Text(
                                    '\$18.30',
                                    style: kProductStyle,
                                  ),
                                ]),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tax & Fee',
                                ),
                                Text(
                                  '\$6.50',
                                  style: kProductStyle,
                                ),
                              ],
                            ),
                            const Text('----------------------------',
                                style: TextStyle(
                                  fontSize: 20,
                                  letterSpacing: 5,
                                )),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: kProductStyle,
                                ),
                                Text(
                                  '\$99.50',
                                  style: kProductStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: CustomFilledButton(
                          text: 'CHECKOUT',
                          onPress: () {
                            navigateToCheckout();
                          },
                        ),
                      ),
                    ],
                  );
                },
                error: (error, stackTrace) => ErrorText(
                      error: error.toString(),
                    ),
                loading: () => const Loader()),
          ],
        ));
  }
}
