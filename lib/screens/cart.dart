import 'package:cartafri/app_config/constants.dart';
import 'package:cartafri/app_config/reusables.dart';
import 'package:cartafri/functionality/Image_selector.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final carts = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const AppBarTitle(
          title: 'CART',
        )),
        body: Column(
          children: [
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 9.0),
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
                          const Text(
                            'Product Name',
                            style: kProductStyle,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Row(
                            children: [
                              Text('\$24.00'),
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
