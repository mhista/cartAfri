import 'package:cartafri/core/commons/animations.dart';
import 'package:cartafri/core/constants/constants.dart';
import 'package:cartafri/core/commons/reusables.dart';
import 'package:cartafri/models/product_model.dart';
import 'package:cartafri/screens/product_detail.dart';
import 'package:flutter/material.dart';

class AppHomePage extends StatelessWidget {
  AppHomePage({super.key});
  final product = product_list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        // greeting widget
        SliverAppBar(
          expandedHeight: 0,
          centerTitle: false,
          flexibleSpace: FlexibleSpaceBar(
            background: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              title: const Text(
                'Hi, Diwe!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none_outlined),
              ),
            ),
          ),
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
            preferredSize: const Size.fromHeight(50),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Material(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        width: 0.1,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: Colors.grey),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 1.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12.0),
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
            ]),
          ),
        ),
        SliverList.builder(
          itemCount: product.length,
          itemBuilder: (context, index) {
            final item = product[index];
            final tag = (item['image'] as List<String>)[0];
            return GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ProductDetail(product: item, tag: tag);
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
                            child: Hero(
                              tag: tag,
                              child: Image.asset(tag,
                                  height: 1000.0, fit: BoxFit.cover),
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
                                    child: Text(item['title'] as String,
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
                                        color: kGreyColor2),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3.0),
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
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: IconAnimation(
                                    iconData: Icons.favorite,
                                    startColor: kGreyColor,
                                    endColor: Colors.red,
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
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
        )
      ]),
    );
  }
}
