import 'package:cartafri/app_config/constants.dart';
import 'package:cartafri/app_config/reusables.dart';
import 'package:cartafri/functionality/Image_selector.dart';
import 'package:flutter/material.dart';

class ItemDetail extends StatefulWidget {
  const ItemDetail({Key? key}) : super(key: key);

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  final item = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: PrimaryIconButton(
            iconData: Icons.arrow_back,
            onPressed: () {},
          ),
          title: Text('Product Detail',
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
                padding: const EdgeInsets.all(7.0),
                child: Text('\$ 1,500.00',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Brief product detail',
                    style: TextStyle(fontSize: 15)),
              ),
              Center(child: ColumnTextReview()),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: kYellow2,
                ),
                onPressed: () {},
                child: Text(
                  '4.5(27)',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: kYellow),
                ),
              ),
              SizedBox(height: 10),
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
                        return Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Expanded(
                                child: Text('Product Detail',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                              Expanded(
                                child: GridView.builder(
                                    itemCount: 10,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 5,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Chip(
                                        label: Text(index.toString()),
                                      );
                                    }),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Text('ADD TO CART', style: kMediumFont)),
            ],
          ),
        ));
  }
}
