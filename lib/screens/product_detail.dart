import 'package:cartafri/app_config/constants.dart';
import 'package:cartafri/app_config/reusables.dart';
import 'package:cartafri/functionality/Image_selector.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, required this.product});
  final Map<String, dynamic> product;
  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final item = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: PrimaryIconButton(
            iconData: Icons.arrow_back,
            onPressed: () {},
          ),
          title: Text(widget.product['title'].toString(),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              )),
          actions: [
            PrimaryIconButton(
              iconData: Icons.favorite_border,
              onPressed: () {},
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(item?.getFirstImage(),
                      height: 200.0, width: 200, fit: BoxFit.fill),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(7.0),
                child: Text('\$${widget.product['price'] as double}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Brief product detail',
                    style: TextStyle(fontSize: 15)),
              ),
              const Center(child: ColumnTextReview()),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: kYellow2,
                ),
                onPressed: () {},
                child: const Text(
                  '4.5(27)',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: kYellow),
                ),
              ),
              const SizedBox(height: 10),
              CustomFilledButton(
                text: 'BUY NOW',
                onPress: () {},
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Material(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: SizedBox(
                            height: 350,
                            child: Column(
                              children: [
                                SizedBox(height: 30.0),
                                FittedBox(
                                  child: Text('Select a Size',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ),
                                SizedBox(height: 10.0),
                                SizedBox(
                                  height: 170,
                                  child: GridView.builder(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 10.0),
                                      itemCount: 10,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 5,
                                        crossAxisSpacing: 0.0,
                                        mainAxisSpacing: 0.0,
                                        childAspectRatio: 1.0,
                                      ),
                                      itemBuilder: (context, index) {
                                        return Chip(
                                          padding: EdgeInsets.all(16.0),
                                          // labelPadding: EdgeInsets.all(16.0),
                                          label: Text(index.toString()),
                                          shape: CircleBorder(),
                                          side: BorderSide(
                                              width: 0.1,
                                              strokeAlign:
                                                  BorderSide.strokeAlignOutside,
                                              color: Colors.grey),
                                        );
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            CategoryIconButton(
                                                elevation: 0.0,
                                                color: Colors.white,
                                                bgColor: kButtonColor,
                                                iconData:
                                                    Icons.open_in_new_outlined,
                                                onPressed: () {}),
                                            SizedBox(height: 7),
                                            Text('Size Guide',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                        Material(
                                            color: Colors.grey,
                                            child: SizedBox(
                                                height: 70, width: 0.5)),
                                        Column(
                                          children: [
                                            CategoryIconButton(
                                                elevation: 0.0,
                                                color: Colors.white,
                                                bgColor: kButtonColor,
                                                iconData: Icons
                                                    .emoji_emotions_outlined,
                                                onPressed: () {}),
                                            SizedBox(height: 7),
                                            Text("Can't find?",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold))
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
                  },
                  child: const Text('ADD TO CART', style: kMediumFont)),
            ],
          ),
        ));
  }
}
