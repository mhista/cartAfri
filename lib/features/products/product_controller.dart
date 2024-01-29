import 'package:cartafri/core/utils/snackBar.dart';
import 'package:cartafri/features/products/product_model.dart';
import 'package:cartafri/features/products/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class ProductContoller extends StateNotifier<bool> {
  final ProductRepository _productRepository;

  ProductContoller(
      {required ProductRepository productRepository, required Ref ref})
      : _productRepository = productRepository,
        super(false);

// CREATE A PRODUCT
  void createProduct(
    BuildContext context, {
    required String id,
    required String title,
    required double price,
    required String company,
    required List size,
    required List imageUrl,
    required int itemCount,
  }) async {
    state = true;
    // final uid = _ref.read(userProvider)?.uid ?? '';
    Product product = Product(
        id: id,
        title: title,
        price: price,
        company: company,
        size: size,
        imageUrl: imageUrl,
        itemCount: itemCount);
    final res = await _productRepository.createProducts(product);
    state = false;
    res.fold(
      (l) => showSnackbar2(context, l.message),
      (r) {
        showSnackbar2(context, 'product created');
        Routemaster.of(context).pop();
      },
    );
  }

  //CONTROLLER FO GETTING ALL PRODUCTS
  Stream<List<Product>> getProducts() => _productRepository.getProducts();
  Stream<Product> getProductDetail(String id) =>
      _productRepository.getProductDetail(id);
  // FutureVoid uploadProductPhoto() async{
  //   return _productRepository.uploadProductPhoto(product)
  // }
}
/*
ALL PROVIDER RELATED OOPERATIONS
 */

final productControllerProvider = StateNotifierProvider<ProductContoller, bool>(
  (ref) {
    final productRepository = ref.watch(productRepositoryProvider);
    return ProductContoller(productRepository: productRepository, ref: ref);
  },
);

final productsProvider = StreamProvider((ref) {
  final productController = ref.watch(productControllerProvider.notifier);
  return productController.getProducts();
});

final productDetailProvider =
    StreamProvider.family.autoDispose((ref, String id) {
  final productContoller = ref.watch(productControllerProvider.notifier);
  return productContoller.getProductDetail(id);
});
