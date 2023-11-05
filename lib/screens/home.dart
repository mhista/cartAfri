import 'package:cartafri/app_config/constants.dart';
import 'package:cartafri/app_config/reusables.dart';
import 'package:cartafri/functionality/Image_selector.dart';
import 'package:flutter/material.dart';

class HomePageWidget {
  HomePageWidget({this.productImages});

  final ImagePicker? productImages;
  final carts = ImagePicker();

  List<Widget> widgetList() => [
        ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
            title: Text('Hi, Diwe!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
            subtitle: Text('what would you buy today?',
                style: TextStyle(fontWeight: FontWeight.w300)),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications_none_outlined))),
        Material(
          borderRadius: BorderRadius.circular(12.0),
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    ElevatedIconButton(
                      iconData: Icons.shopping_cart_outlined,
                      onPressed: () {},
                      color: kButtonColor,
                      bgColor: kCardColor,
                    ),
                    Text('Grocery')
                  ],
                )),
                Expanded(
                    child: Column(
                  children: [
                    ElevatedIconButton(
                      iconData: Icons.change_history_outlined,
                      onPressed: () {},
                      bgColor: kButtonColor,
                      color: kCardColor,
                    ),
                    Text('Cloth')
                  ],
                )),
                Expanded(
                    child: Column(
                  children: [
                    ElevatedIconButton(
                      iconData: Icons.wine_bar_outlined,
                      onPressed: () {},
                      color: kButtonColor,
                      bgColor: kCardColor,
                    ),
                    Text('Liquor')
                  ],
                )),
                Expanded(
                    child: Column(
                  children: [
                    ElevatedIconButton(
                        iconData: Icons.fastfood_outlined,
                        onPressed: () {},
                        bgColor: kButtonColor,
                        color: kCardColor),
                    Text('Food')
                  ],
                )),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 10),
            itemCount: carts.getLength(),
            itemBuilder: (context, position) {
              return Card(
                elevation: 3.0,
                color: kCardColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 9.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 90.0,
                        width: 100.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(carts?.getImageList()[position],
                              height: 1000.0, fit: BoxFit.fill),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 9.0, top: 11.0, bottom: 3.0),
                                    child: Text('Product Name',
                                        style: kProductStyle)),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Row(
                                    children: [
                                      StarIcon(starType: Icons.star),
                                      StarIcon(starType: Icons.star),
                                      StarIcon(starType: Icons.star),
                                      StarIcon(starType: Icons.star),
                                      StarIcon(starType: Icons.star_border),
                                      Text(' 4.5', style: kProductStyle),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Row(children: [
                                    Icon(Icons.store_mall_directory_outlined,
                                        color: kGreyColor2),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3.0),
                                      child: Text('Shop Name'),
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
                                  icon: Icon(Icons.favorite, color: kGreyColor),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('\$15,000', style: kProductStyle),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              );
              ;
            },
          ),
        )
      ];
}
