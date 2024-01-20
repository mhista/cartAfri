import 'package:cartafri/core/constants/firestore_constants.dart';
import 'package:cartafri/core/failure.dart';
import 'package:cartafri/core/functionality/firebase_provider.dart';
import 'package:cartafri/core/type_defs.dart';
import 'package:cartafri/features/products/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final productRepositoryProvider = Provider(
  (ref) => ProductRepository(
    firestore: ref.watch(fireStoreProvider),
  ),
);

class ProductRepository {
  final FirebaseFirestore _firestore;
  ProductRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

// GET THE PRODUCT COLLECTION
  CollectionReference get _products =>
      _firestore.collection(FireStoreConstants.productCollections);
// CREATE THE PRODUCTS IN FIREBASE
  FutureVoid createProducts(Product product) async {
    try {
      return right(_products
          .doc(product.id)
          .set(product.toMap(), SetOptions(merge: true)));
    } on FirebaseException catch (e) {
      return left(Failure(e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

// UPLOAD PRODUCT PHOTO
  FutureVoid uploadProductPhoto(Product product) async {
    try {
      return right(_products.doc(product.id).update(product.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // GET ALL PRODUCTS IN THE PRODUCT COLLECTION
  Stream<List<Product>> getProducts() {
    return _products.snapshots().map((event) {
      List<Product> products = [];
      for (var doc in event.docs) {
        products.add(Product.fromMap(doc.data() as Map<String, dynamic>));
      }
      return products;
    });
  }

  Stream<Product> getProductDetail(String id) {
    return _products
        .doc(id)
        .snapshots()
        .map((event) => Product.fromMap(event.data() as Map<String, dynamic>));
  }
}
