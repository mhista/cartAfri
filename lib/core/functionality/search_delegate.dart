import 'package:cartafri/core/utils/constants/color_constants.dart';
import 'package:cartafri/core/utils/constants/constants.dart';
import 'package:cartafri/core/utils/commons/animations.dart';
import 'package:cartafri/core/utils/commons/error_test.dart';
import 'package:cartafri/core/utils/commons/isLoading.dart';
import 'package:cartafri/core/utils/commons/reusables.dart';
import 'package:cartafri/features/products/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class SearchProductDelegate extends SearchDelegate {
  final WidgetRef ref;

  SearchProductDelegate({required this.ref});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: Colors.blue,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) =>
      ref.watch(searchProductsProvider(query)).when(
          data: (products) => ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  final tag = product.id;
                  return GestureDetector(
                    onTap: () => navigateToDetail(context, product.id),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 9.0),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: SizedBox(
                                height: 100.0,
                                width: 100.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Hero(
                                    tag: tag,
                                    child: Image.asset(product.imageUrl[0],
                                        height: 100.0, fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.only(
                                              left: 9.0,
                                              top: 11.0,
                                              bottom: 3.0),
                                          child: Text(product.title,
                                              style: kProductStyle)),
                                      const Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: RowTextReview(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Row(children: [
                                          const Icon(
                                              Icons
                                                  .store_mall_directory_outlined,
                                              color:
                                                  ColorConstants.kGreyColor2),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 3.0),
                                            child: Text(product.company),
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
                                          startColor: ColorConstants.kGreyColor,
                                          endColor: Colors.red,
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text('\$${product.price}',
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
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader());
}

void navigateToDetail(BuildContext context, String productId) {
  Routemaster.of(context).push('/product/$productId');
}
