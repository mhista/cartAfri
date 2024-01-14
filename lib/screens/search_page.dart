import 'package:cartafri/core/constants/constants.dart';
import 'package:cartafri/core/utils/reusables.dart';
import 'package:cartafri/core/functionality/Image_selector.dart';
import 'package:flutter/material.dart';

class SearchPageWidget {
  SearchPageWidget({this.productImages});
  final ImagePicker? productImages;
  final carts = ImagePicker();
  List<Widget> widgetList() => [
        SearchBar(
            elevation: MaterialStateProperty.all(1.0),
            hintText: 'search',
            leading:
                PrimaryIconButton(iconData: Icons.search, onPressed: () {}),
            trailing: [
              PrimaryIconButton(
                  iconData: Icons.import_export, onPressed: () {}),
              PrimaryIconButton(
                  iconData: Icons.filter_list_outlined, onPressed: () {})
            ]),
        Container(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 5.0),
            child: const Text('Result for "Cosmetics"')),
        Expanded(
          child: GridView.builder(
            itemCount: carts.getLength(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 1.0,
              mainAxisExtent: 240,
            ),
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: Stack(
                            fit: StackFit.passthrough,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(carts?.getImageList()[index],
                                    height: 1000.0, fit: BoxFit.fill),
                              ),
                              Positioned(
                                right: 0.1,
                                top: 2,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.favorite_border),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 16.0),
                          child:
                              const Text('Product Name', style: kProductStyle)),
                      const SizedBox(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RowTextReview(),
                        ),
                      ),
                      const Text('15,000', style: kProductStyle),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ];
}
