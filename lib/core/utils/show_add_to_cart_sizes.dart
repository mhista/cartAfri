import 'package:cartafri/core/constants/constants.dart';
import 'package:cartafri/core/utils/reusables.dart';
import 'package:cartafri/features/products/product_model.dart';
import 'package:cartafri/screens/product_detail.dart';
import 'package:flutter/material.dart';

Future<dynamic> showAddToCartSizeOptions(
    BuildContext context, Product product) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      final productSize = (product.size).length;
      return Material(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(12),
        ),
        child: SizedBox(
          height: 350,
          child: Column(
            children: [
              const SizedBox(height: 30.0),
              const FittedBox(
                child: Text('Select a Size',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                height: 170,
                child: ChipBuilder(productSize: productSize, product: product),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          CategoryIconButton(
                              elevation: 0.0,
                              color: Colors.white,
                              bgColor: kButtonColor,
                              iconData: Icons.open_in_new_outlined,
                              onPressed: () {}),
                          const SizedBox(height: 7),
                          const Text('Size Guide',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold))
                        ],
                      ),
                      const Material(
                          color: Colors.grey,
                          child: SizedBox(height: 70, width: 0.5)),
                      Column(
                        children: [
                          CategoryIconButton(
                              elevation: 0.0,
                              color: Colors.white,
                              bgColor: kButtonColor,
                              iconData: Icons.emoji_emotions_outlined,
                              onPressed: () {}),
                          const SizedBox(height: 7),
                          const Text("Can't find?",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ]),
              )
            ],
          ),
        ),
      );
    },
  );
}
