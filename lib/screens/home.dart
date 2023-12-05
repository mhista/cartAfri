import 'package:cartafri/core/constants/constants.dart';
import 'package:cartafri/core/commons/reusables.dart';
import 'package:cartafri/features/functionality/Image_selector.dart';
import 'package:cartafri/models/product_model.dart';
import 'package:cartafri/screens/product_detail.dart';
import 'package:flutter/material.dart';

class AppHomePage extends StatelessWidget {
  AppHomePage({super.key, this.productImages});
  final ImagePicker? productImages;
  final carts = ImagePicker();
  final product = product_list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          title: const Text('Hi, Diwe!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
          subtitle: const Text('what would you buy today?',
              style: TextStyle(fontWeight: FontWeight.w300)),
          trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_outlined))),
      ListTile(
        leading: const Text(
          'Categories',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        trailing: TextButton(
          onPressed: () {},
          child: const Text('See all'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Material(
          shape: RoundedRectangleBorder(
              side: const BorderSide(
                  width: 0.1,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: Colors.grey),
              borderRadius: BorderRadius.circular(12.0)),
          elevation: 1.0,
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    CategoryIconButton(
                      iconData: Icons.shopping_cart_outlined,
                      onPressed: () {},
                      color: kButtonColor,
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
                      bgColor: kButtonColor,
                      color: kCardColor,
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
                      color: kButtonColor,
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
                      bgColor: kButtonColor,
                      color: kCardColor,
                    ),
                    const Text('Food', style: kMediumFont)
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
      Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          itemCount: product.length,
          itemBuilder: (context, index) {
            final item = product[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ProductDetail(product: item);
                }));
              },
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
                            child: Image.asset(carts.getImageList()[index],
                                height: 1000.0, fit: BoxFit.cover),
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
                                    child: Text(item['title'] as String,
                                        style: kProductStyle)),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: RowTextReview(),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(3.0),
                                  child: Row(children: [
                                    Icon(Icons.store_mall_directory_outlined,
                                        color: kGreyColor2),
                                    Padding(
                                      padding: EdgeInsets.only(left: 3.0),
                                      child: Text(item['company'] as String),
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
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.favorite,
                                      color: kGreyColor),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text('\$${item['price'] as double}',
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
        ),
      )
    ]));
  }
}
