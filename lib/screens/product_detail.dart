import 'package:cartafri/core/utils/animations.dart';
import 'package:cartafri/core/constants/constants.dart';
import 'package:cartafri/core/utils/error_test.dart';
import 'package:cartafri/core/utils/isLoading.dart';
import 'package:cartafri/core/utils/reusables.dart';
import 'package:cartafri/core/utils/show_add_to_cart_sizes.dart';
import 'package:cartafri/core/utils/snackBar.dart';
import 'package:cartafri/features/order_items/order_item_controller.dart';
import 'package:cartafri/features/products/product_controller.dart';
import 'package:cartafri/features/products/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';

GlobalKey _scaffold = GlobalKey();

class ProductDetail extends ConsumerWidget {
  const ProductDetail({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(productDetailProvider(id)).when(
        data: (product) => Scaffold(
              key: _scaffold,
              appBar: AppBar(
                leading: PrimaryIconButton(
                  iconData: Icons.arrow_back,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(product.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    )),
                actions: const [
                  IconAnimation(
                    iconData: Icons.favorite_border_outlined,
                    startColor: kButtonColor,
                    endColor: Colors.red,
                    selectedIconData: Icons.favorite,
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
                        child: Hero(
                          tag: product.id,
                          child: Image.asset(product.imageUrl[0],
                              height: 200.0, width: 200, fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text('\$${product.price}',
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
                          showAddToCartSizeOptions(context, product);
                        },
                        child: const Text('ADD TO CART', style: kMediumFont)),
                  ],
                ),
              ),
            ),
        error: (error, stackTrace) {
          return ErrorText(error: error.toString());
        },
        loading: () => const Loader());
  }
}

class ChipBuilder extends ConsumerStatefulWidget {
  const ChipBuilder({
    super.key,
    required this.productSize,
    required this.product,
  });

  final int productSize;
  final Product product;

  @override
  ConsumerState<ChipBuilder> createState() => _ChipBuilderState();
}

class _ChipBuilderState extends ConsumerState<ChipBuilder> {
  int selectedSize = 0;
  // ADD THE PRODUCT TO CART
  void addProductToCart(
      Product product, BuildContext context, int size, int selectedSize) {
    ref.read(orderItemController.notifier).createOrUpdateOrderItem(context,
        id: const Uuid().v4(), product: product, quantity: 1, size: size);
    Routemaster.of(context).pop();

    setState(() {
      selectedSize = 10;
    });
    Routemaster.of(context).push('/cart');
    showSnackbar2(context, 'Item added to cart');
  }

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
          final size = (widget.product.size)[index];
          return GestureDetector(
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
            onTap: () =>
                addProductToCart(widget.product, context, size, selectedSize),
          );
        });
  }
}
