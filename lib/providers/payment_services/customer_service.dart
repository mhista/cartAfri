import 'dart:convert';

import 'package:cartafri/core/utils/commons/failure.dart';
import 'package:cartafri/core/functionality/firebase_provider.dart';
import 'package:cartafri/core/utils/commons/type_defs.dart';
import 'package:cartafri/core/utils/constants/API_constants.dart';
import 'package:cartafri/core/utils/constants/firestore_constants.dart';
import 'package:cartafri/features/payment/payment_models/api_response.dart';
import 'package:cartafri/features/payment/payment_models/customers.dart';
import 'package:cartafri/features/payment/payment_models/paystack_auth_response.dart';
import 'package:cartafri/features/payment/payment_services/api_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

class CustomerService {
  final ApiService _apiService;
  final FirebaseFirestore _firestore;

  CustomerService(
      {required ApiService apiService, required FirebaseFirestore firestore})
      : _apiService = apiService,
        _firestore = firestore;

  CollectionReference get _customer =>
      _firestore.collection(FireStoreConstants.customerCollections);

  // get or create a customer on firebase and paystack
  FutureEither<Customer> getOrCreateCustomer(
      Customer customer, String id) async {
    ApiResponse response;
    try {
      QuerySnapshot customerQuery = await _customer
          .where('id', isEqualTo: id)
          .where("email", isEqualTo: customer.email)
          .limit(1)
          .get();
      if (customerQuery.docs.isNotEmpty) {
        DocumentSnapshot customerDocument = customerQuery.docs.first;
        Customer customerdoc =
            Customer.fromMap(customerDocument.data() as Map<String, dynamic>);
        debugPrint(customerdoc.toString());
        return right(customerdoc);
      } else {
        response = await _apiService.post(
            url: APIConstants.createCustomers, data: customer.toJson());
        if (response.statusCode == 200) {
          final cust = customer.copyWith(
              integration: response.data!["integration"],
              domain: response.data!["domain"],
              customerCode: response.data!["customer_code"],
              id: response.data!["id"],
              identified: response.data!["identified"]);

          await _customer.doc(id).set(cust.toMap(), SetOptions(merge: true));
        }

        Customer customerr = await _customer
            .doc(id)
            .snapshots()
            .map((event) =>
                Customer.fromMap(event.data() as Map<String, dynamic>))
            .first;
        return right(customerr);
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(
        Failure('error occured'),
      );
    }
  }

  FutureEither<Customer> getCustomer(String id) async {
    try {
      Customer customerr = await _customer
          .doc(id)
          .snapshots()
          .map(
              (event) => Customer.fromMap(event.data() as Map<String, dynamic>))
          .first;
      return right(customerr);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(
        Failure('error occured'),
      );
    }
  }
}

final customerServiceProvider = Provider((ref) {
  return CustomerService(
      apiService: ref.watch(apiServiceProvider),
      firestore: ref.watch(fireStoreProvider));
});
