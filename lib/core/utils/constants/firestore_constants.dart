import 'package:cartafri/features/auth/controller/authController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FireStoreConstants {
  static const userCollections = 'users';
  static const productCollections = 'products';
  static const orderCollections = 'orders';
  static const userOrderItemCollections = 'userOrders';
  static const orderItemCollections = 'orderItems';
  static const userOrderDocuments = 'userOrder';
  static const customerCollections = 'paystackCustomers';
  static const category = "categories";
}
