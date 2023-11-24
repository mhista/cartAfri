import 'package:cartafri/app_config/constants.dart';
import 'package:cartafri/app_config/reusables.dart';
import 'package:cartafri/functionality/Image_selector.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  ProductDetail({super.key, required this.product});
  final Map<String, dynamic> product;

  final item = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: PrimaryIconButton(
            iconData: Icons.arrow_back,
            onPressed: () {},
          ),
          title: Text(product['title'].toString(),
              style: const TextStyle(
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
                padding: const EdgeInsets.all(7.0),
                child: Text('\$${product['price'] as double}',
                    style: const TextStyle(
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
                        final productSize =
                            (product['size'] as List<int>).length;
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
                                  child: ChipBuilder(
                                      productSize: productSize,
                                      product: product),
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
                                            const SizedBox(height: 7),
                                            const Text('Size Guide',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                        const Material(
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
                                            const SizedBox(height: 7),
                                            const Text("Can't find?",
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

class ChipBuilder extends StatefulWidget {
  ChipBuilder({
    super.key,
    required this.productSize,
    required this.product,
  });

  final int productSize;
  final Map<String, dynamic> product;

  @override
  State<ChipBuilder> createState() => _ChipBuilderState();
}

class _ChipBuilderState extends State<ChipBuilder> {
  int selectedSize = 0;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        itemCount: widget.productSize,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (context, index) {
          final size = (widget.product['size'] as List<int>)[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedSize = size;
              });
            },
            child: Chip(
              backgroundColor: selectedSize == size ? kButtonColor : null,
              padding: const EdgeInsets.all(16.0),
              // labelPadding: EdgeInsets.all(16.0),
              label: Text(size.toString()),
              shape: const CircleBorder(),
              side: const BorderSide(
                  width: 0.1,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: Colors.grey),
            ),
          );
          ;
        });
  }
}
