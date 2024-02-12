import 'package:cartafri/core/functionality/firebase_provider.dart';
import 'package:cartafri/core/utils/commons/failure.dart';
import 'package:cartafri/core/utils/commons/type_defs.dart';
import 'package:cartafri/core/utils/constants/firestore_constants.dart';
import 'package:cartafri/features/product_category/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

class CategoryRepository {
  final FirebaseFirestore _firestore;
  final Ref _ref;
  const CategoryRepository(
      {required FirebaseFirestore firestore, required Ref ref})
      : _firestore = firestore,
        _ref = ref;

  CollectionReference get _category =>
      _firestore.collection(FireStoreConstants.category);

  FutureVoid createCategory(Categories category) async {
    try {
      return right(_category
          .doc(category.id)
          .set(category.toMap(), SetOptions(merge: true)));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<Categories>> getCagories() {
    return _category.snapshots().map((event) {
      List<Categories> categories = [];
      for (var doc in event.docs) {
        Categories category =
            Categories.fromMap(doc.data() as Map<String, dynamic>);
        categories.add(category);
      }
      return categories;
    });
  }
}

final categoryProviderRepository = Provider((ref) =>
    CategoryRepository(firestore: ref.watch(fireStoreProvider), ref: ref));
