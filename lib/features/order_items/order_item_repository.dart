import 'package:cartafri/core/constants/firestore_constants.dart';
import 'package:cartafri/core/failure.dart';
import 'package:cartafri/core/functionality/firebase_provider.dart';
import 'package:cartafri/core/type_defs.dart';
import 'package:cartafri/features/order_items/order_item_model.dart';
import 'package:cartafri/features/orders/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

class OrderItemRepository {
  final FirebaseFirestore _firestore;
  OrderItemRepository({required FirebaseFirestore firestore, required Ref ref})
      : _firestore = firestore;
  // A REFERENCE TO THE ORDER COLLECTION
  CollectionReference get _order =>
      _firestore.collection(FireStoreConstants.orderCollections);
  CollectionReference get _orderItem =>
      _firestore.collection(FireStoreConstants.orderItemCollections);
  CollectionReference get _products =>
      _firestore.collection(FireStoreConstants.productCollections);
// CREATES AN ORDER OR UPDATES IT
  FutureEither<OrderItem> createOrUpdateOrderItem(OrderItem orderItem) async {
    try {
      // gets a querysnapshot of all orderitems with the product id and a particular size
      QuerySnapshot orderItemQuery = await _orderItem
          .where('product.id', isEqualTo: orderItem.product.id)
          .where('userId', isEqualTo: orderItem.userId)
          .where('size', isEqualTo: orderItem.size)
          .limit(1)
          .get();
      // checks if the query is not empty and gets the first ducument
      if (orderItemQuery.docs.isNotEmpty) {
        DocumentSnapshot item = orderItemQuery.docs.first;
        // updates it
        await item.reference.update({'quantity': FieldValue.increment(1)});
        await _products
            .doc(orderItem.product.id)
            .update({'quantity': FieldValue.increment(-1)});
        OrderItem itemer =
            OrderItem.fromMap(item.data() as Map<String, dynamic>);
        // returns the updated item
        return right(itemer);
      } else {
        // creates a new order item
        await _orderItem
            .doc(orderItem.id)
            .set(orderItem.toMap(), SetOptions(merge: true));
        OrderItem itemer = OrderItem.fromMap(_orderItem
            .doc(orderItem.userId)
            .snapshots()
            .first as Map<String, dynamic>);
        return right(itemer);
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

// GET ALL ORDERITEMS
  Stream<List<OrderItem>> getOrderItem() {
    try {
      return _orderItem
          .where('ordered', isEqualTo: false)
          .snapshots()
          .map((QuerySnapshot snapshot) {
        List<OrderItem> orderItems = [];
        for (var doc in snapshot.docs) {
          OrderItem item =
              OrderItem.fromMap(doc.data() as Map<String, dynamic>);
          orderItems.add(item);
        }
        return orderItems;
      });
    } on FirebaseException catch (e) {
      throw e.message!;
    }
  }

  Stream<double> getTotal() {
    try {
      return _orderItem
          .where('ordered', isEqualTo: false)
          .snapshots()
          .map((QuerySnapshot snapshot) {
        double total = 0;
        for (var doc in snapshot.docs) {
          OrderItem item =
              OrderItem.fromMap(doc.data() as Map<String, dynamic>);
          total = total + item.product.price;
        }
        return total;
      });
    } on FirebaseException catch (e) {
      throw e.message!;
    }
  }
//
}

final orderItemRepositoryProvider = Provider((ref) =>
    OrderItemRepository(firestore: ref.watch(fireStoreProvider), ref: ref));
