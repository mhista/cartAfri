// import 'dart:ffi';

import 'package:cartafri/core/functionality/firebase_provider.dart';
import 'package:cartafri/features/auth/controller/authController.dart';
import 'package:cartafri/features/order_items/order_item_model.dart';
import 'package:cartafri/features/orders/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import 'package:cartafri/core/constants/firestore_constants.dart';
import 'package:cartafri/core/failure.dart';
import 'package:cartafri/core/type_defs.dart';
import 'package:uuid/uuid.dart';

class OrderRepository {
  final FirebaseFirestore _firestore;
  final Ref _ref;

  OrderRepository({required FirebaseFirestore firestore, required Ref ref})
      : _firestore = firestore,
        _ref = ref;
  // A REFERENCE TO THE ORDER COLLECTION
  CollectionReference get _order =>
      _firestore.collection(FireStoreConstants.orderCollections);
  // A REFERENCE TO THE USERS ORDER DOCUMENT
  DocumentReference get _userOrderDocument => _firestore
      .collection(FireStoreConstants.orderCollections)
      .doc(_ref.read(userProvider)!.uid);
  // A REFERENCE TO THE USERS COLLECTION OF OTHERS
  CollectionReference get _userOrderCollections => _firestore
      .collection(FireStoreConstants.orderCollections)
      .doc(FireStoreConstants.userOrderDocuments)
      .collection(FireStoreConstants.userOrderItemCollections);
  CollectionReference get _orderItem =>
      _firestore.collection(FireStoreConstants.orderItemCollections);

// CREATE OR UPDATE ORDER 2
  FutureVoid createOrder(Orders order) async {
    try {
      return right(_order.doc(order.id).set(order, SetOptions(merge: true)));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

// CREATE ORDER
  FutureEither<Orders> createOrUpdateOrder(
      {required String id, OrderItem? orderItem}) async {
    try {
      print(orderItem);
      Orders order = Orders(
          id: const Uuid().v4(),
          userId: id,
          startDate: DateTime.now(),
          orderedDate: null,
          ordered: false,
          shippingAddress: null,
          billingAddress: null,
          orderItems: []);

      // GET THE ORDER QUERY SNAPSHOT
      QuerySnapshot getDocument = await _userOrderCollections
          .where(
            'userId',
            isEqualTo: id,
          )
          .where('ordered', isEqualTo: false)
          .limit(1)
          .get();
      // CHECKS IF IT IS NOT EMPTY
      if (getDocument.docs.isNotEmpty) {
        // GETS A QUERY SNAPSHOT OF THE ORDER ITEM AND RETRIEVES ITS FIRST ITEM
        // QuerySnapshot orderItemQuery = await _orderItem
        //     .where('productId', isEqualTo: orderItem!.productId)
        //     .where('userId', isEqualTo: orderItem.userId)
        //     .where('size', isEqualTo: orderItem.size)
        //     .limit(1)
        //     .get();
        Orders orderr = Orders.fromMap(
            getDocument.docs.first.data() as Map<String, dynamic>);
        // CHECKS IF THE ORDERITEM IS IN THE ORDER ALREADY
        if (orderr.orderItems.contains(orderItem!.id)) {
          print(orderItem);
          // RETURNS THE ORDER.
          Orders orderr = Orders.fromMap(
              getDocument.docs.first.data() as Map<String, dynamic>);
          return right(orderr);
        } else {
          // ADDS THE ORDERITEM TO THE ORDERS
          getDocument.docs.first.reference.update(
            {
              'orderItems': FieldValue.arrayUnion([
                {orderItem.id: orderItem.id}
              ])
            },
          );
          return right(orderr);
        }
      } else {
        // CREATES A NEW ORDER, AND UPDATES THE ORDERITEM FIELD
        await _userOrderCollections.doc(order.id).set(order.toMap());
        await _userOrderCollections.doc(order.id).update({
          'orderItems': FieldValue.arrayUnion([
            {orderItem!.id: orderItem.id}
            // orderItem!.toMap()
          ])
        });
        Orders orderr = await getUserCurrentOrder(id)
            .map((event) => Orders.fromMap(event as Map<String, dynamic>))
            .first;
        return right(orderr);
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // GETTING THE CURRENT ORDER
  Stream<OrderItem> getUserCurrentOrder(String id) {
    return _order
        .where('userId', isEqualTo: id)
        .where('ordered', isEqualTo: false)
        .snapshots()
        .map((event) {
      List<Orders> orders = [];
      for (var e in event.docs) {
        orders.add(Orders.fromMap(e.data() as Map<String, dynamic>));
      }
      return orders.firstOrNull;
    });
  }

  // GETTING THE ORDERED ORDERS
  Stream<List<Orders?>> getUserPreviousOrders(String userId) {
    try {
      return _order
          .where('userId', isEqualTo: userId)
          .where('ordered', isEqualTo: true)
          .snapshots()
          .map((QuerySnapshot snapshot) {
        List<Orders> orderedOrders = [];
        for (var doc in snapshot.docs) {
          orderedOrders.add(Orders.fromMap(doc.data() as Map<String, dynamic>));
        }
        return orderedOrders;
      });
    } on FirebaseException catch (e) {
      throw e.message!;
    }
  }

  // DELETE ORDER
  FutureVoid deleteOrder(Orders order, String userId) async {
    try {
      return right(_order
          .where('userId', isEqualTo: userId)
          .where('ordered', isEqualTo: false)
          .get()
          .then((QuerySnapshot snapshot) => snapshot.docs.forEach((doc) {
                _order.doc(order.id).delete();
              })));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

// REMOVE AN ORDERITEM USING ITS ID
  FutureVoid deleteOrderItemFromOrder(OrderItem orderItem, Orders order) async {
    try {
      final userOrder = await _order
          .where('userId', isEqualTo: order.userId)
          .where('ordered', isEqualTo: false)
          .get()
          .then((QuerySnapshot snapshot) => snapshot.docs.firstOrNull);
      return right(await _order.doc(userOrder?.id).update({
        'orderItems': FieldValue.arrayRemove([orderItem])
      }));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}

final orderRepositoryProvider = Provider((ref) =>
    OrderRepository(firestore: ref.watch(fireStoreProvider), ref: ref));
