import 'package:cartafri/app_config/constants.dart';
import 'package:cartafri/app_config/reusables.dart';
import 'package:cartafri/functionality/Image_selector.dart';
import 'package:flutter/material.dart';

class CartPage {
  CartPage({this.cartImage});
  final ImagePicker? cartImage;
  final carts = ImagePicker();

  List<Widget> widgetList() => [
        Container(
            margin: EdgeInsets.only(left: 9.0, top: 11.0, bottom: 3.0),
            child: Text('Product Name', style: kProductStyle)),
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
                                      Text('\$39.99', style: kProductStyle),
                                      Text('\$25.00', style: kProductStyle),
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
                      Expanded(
                        child: Row(children: [
                          RoundIconButton(
                              IconChild: Icons.add, onPressed: () {}),
                          Text('2'),
                          RoundIconButton(
                              IconChild: Icons.remove, onPressed: () {}),
                        ]),
                      ),
                    ],
                  ),
                ),
              );
              ;
            },
          ),
        ),
        Expanded(
          child: ListTile(
            leading: Icon(Icons.money_rounded),
            title: Text('Promo Code'),
          ),
        )
      ];
}
