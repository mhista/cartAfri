import 'package:cartafri/core/functionality/firebase_provider.dart';
import 'package:cartafri/features/orders/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import 'package:cartafri/core/constants/firestore_constants.dart';
import 'package:cartafri/core/failure.dart';
import 'package:cartafri/core/type_defs.dart';

class OrderRepository {
  final FirebaseFirestore _firestore;

  OrderRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;
  // A REFERENCE TO THE ORDER COLLECTION
  CollectionReference get _order =>
      _firestore.collection(FireStoreConstants.orderCollections);

  // CREATING AN ORDER
  FutureVoid createOrder(Orders order) async {
    try {
      return right(
          _order.doc(order.id).set(order.toMap(), SetOptions(merge: true)));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // GETTING THE ORDERS
  Stream<Orders> getUserOrders(Orders order) {
    return _order
        .doc(order.id)
        .snapshots()
        .map((event) => Orders.fromMap(event.data() as Map<String, dynamic>));
  }

  // DELETE ORDER
  FutureVoid deleteOrder(Orders order) async {
    try {
      return right(_order.doc(order.id).delete());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // UPDATE ORDER
  FutureVoid updateOrder(Orders order) async {
    try {
      return right(_order.doc(order.id).update(order.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}

final orderRepositoryProvider =
    Provider((ref) => OrderRepository(firestore: ref.watch(fireStoreProvider)));
