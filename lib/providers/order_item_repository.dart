import 'package:cartafri/core/utils/constants/firestore_constants.dart';
import 'package:cartafri/core/utils/commons/failure.dart';
import 'package:cartafri/core/functionality/firebase_provider.dart';
import 'package:cartafri/core/utils/commons/type_defs.dart';
import 'package:cartafri/features/order_items/order_item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

class OrderItemRepository {
  final FirebaseFirestore _firestore;
  OrderItemRepository({required FirebaseFirestore firestore})
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

        OrderItem itemer =
            OrderItem.fromMap(item.data() as Map<String, dynamic>);

        if (itemer.product.itemCount >= 1) {
          await _products
              .doc(orderItem.product.id)
              .update({'itemCount': FieldValue.increment(-1)});
          // updates it
          await item.reference.update({
            'quantity': FieldValue.increment(1),
            'product.itemCount': FieldValue.increment(-1)
          });
          return right(itemer);
        }
        return right(itemer);
      } else {
        // creates a new order item
        await _orderItem
            .doc(orderItem.id)
            .set(orderItem.toMap(), SetOptions(merge: true));
        await _products
            .doc(orderItem.product.id)
            .update({'itemCount': FieldValue.increment(-1)});
        await _orderItem
            .doc(orderItem.id)
            .update({'product.itemCount': FieldValue.increment(-1)});
        OrderItem itemerr = await _orderItem
            .doc(orderItem.id)
            .snapshots()
            .map((event) =>
                OrderItem.fromMap(event.data() as Map<String, dynamic>))
            .first;

        return right(itemerr);
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

// DECREASES OR DELETES AN ORDER ITEM
  FutureEither<OrderItem> decreaseOrderItem(orderItem) async {
    try {
      // gets a querysnapshot of all orderitems with the product id and a particular size
      QuerySnapshot orderItemQuery = await _orderItem
          .where('product.id', isEqualTo: orderItem.product.id)
          .where('userId', isEqualTo: orderItem.userId)
          .where('size', isEqualTo: orderItem.size)
          .limit(1)
          .get();
      OrderItem itemer;
      // checks if the query is not empty and gets the first ducument
      if (orderItemQuery.docs.isNotEmpty) {
        DocumentSnapshot item = orderItemQuery.docs.first;
        // updates it
        itemer = OrderItem.fromMap(item.data() as Map<String, dynamic>);
        if (itemer.quantity >= 1) {
          await _products
              .doc(orderItem.product.id)
              .update({'itemCount': FieldValue.increment(1)});
          // updates it
          await item.reference.update({
            'quantity': FieldValue.increment(-1),
            'product.itemCount': FieldValue.increment(1)
          });
          // returns the updated item
          return right(itemer);
        }
      }
      OrderItem itemerr = await _orderItem
          .doc(orderItem.id)
          .snapshots()
          .map((event) =>
              OrderItem.fromMap(event.data() as Map<String, dynamic>))
          .first;

      return right(itemerr);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

// GET ALL ORDERITEMS
  Stream<List<OrderItem>> getOrderItems(user) {
    try {
      return _orderItem
          .where('ordered', isEqualTo: false)
          .where('userId', isEqualTo: user)
          .snapshots()
          .map((QuerySnapshot snapshot) {
        List<OrderItem> orderItems = [];
        for (var doc in snapshot.docs) {
          OrderItem item =
              OrderItem.fromMap(doc.data() as Map<String, dynamic>);
          if (item.quantity < 1) {
            _orderItem.doc(item.id).delete();
            continue;
          }
          orderItems.add(item);
        }
        return orderItems;
      });
    } on FirebaseException catch (e) {
      throw e.message!;
    }
  }

// GETS THE ORDER ITEM TOTAL
  Stream<double> getTotal(user) {
    try {
      return _orderItem
          .where('ordered', isEqualTo: false)
          .where('userId', isEqualTo: user)
          .snapshots()
          .map((QuerySnapshot snapshot) {
        double total = 0;
        for (var doc in snapshot.docs) {
          OrderItem item =
              OrderItem.fromMap(doc.data() as Map<String, dynamic>);
          total = total + item.product.price * item.quantity;
        }
        return total;
      });
    } on FirebaseException catch (e) {
      throw e.message!;
    }
  }
//
}

final orderItemRepositoryProvider = Provider(
    (ref) => OrderItemRepository(firestore: ref.watch(fireStoreProvider)));
