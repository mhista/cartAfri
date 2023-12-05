import 'package:cartafri/core/constants/constants.dart';
import 'package:cartafri/core/commons/reusables.dart';
import 'package:cartafri/features/functionality/Image_selector.dart';
import 'package:cartafri/main.dart';
import 'package:cartafri/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  final carts = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider.notifier).cart;
    return Scaffold(
        appBar: AppBar(
            title: const AppBarTitle(
          title: 'CART',
        )),
        body: Column(
          children: [
            SizedBox(
              height: 200,
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final item = cart[index];
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
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  carts.getFirstImage(),
                                  height: 1000.0,
                                  fit: BoxFit.fill,
                                )),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 16.0, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              textDirection: TextDirection.ltr,
                              children: [
                                Text(
                                  item.title,
                                  style: kProductStyle,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text('\$${item.price}'),
                                    SizedBox(width: 10.0),
                                    Text('\$34.00', style: kProductStyle),
                                  ],
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      RoundIconButton(
                                        iconChild: Icons.remove,
                                        onPressed: () {},
                                        fillColor: const Color(0x734065f4),
                                      ),
                                      // SizedBox(
                                      //   width:10
                                      // ),
                                      const Text('2'),
                                      RoundIconButton(
                                        iconChild: Icons.add,
                                        onPressed: () {},
                                        fillColor: const Color(0xff4065f4),
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
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SubTotal',
                      ),
                      Text(
                        '\$86.50',
                        style: kProductStyle,
                      ),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery',
                        ),
                        Text(
                          '\$18.30',
                          style: kProductStyle,
                        ),
                      ]),
                  Row(
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
                  Text('----------------------------',
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 5,
                      )),
                  Row(
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
                onPress: () {},
              ),
            ),
          ],
        ));
  }
}
