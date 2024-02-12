import 'dart:convert';

import 'package:cartafri/core/utils/constants/API_constants.dart';
import 'package:cartafri/features/payment/payment_models/api_response.dart';
import 'package:cartafri/features/payment/payment_models/initiate_transaction.dart';
import 'package:cartafri/features/payment/payment_models/paystack_auth_response.dart';
import 'package:cartafri/features/payment/payment_models/transaction.dart';
import 'package:cartafri/features/payment/payment_services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaystackService {
  final ApiService _apiService;

  PaystackService({required ApiService apiService}) : _apiService = apiService;

  // initialize Transaction
  Future<PaystackAuthResponse> initializeTransaction({
    required InitiateModel initiateModel,
  }) async {
    ApiResponse response;
    try {
      response = await _apiService.post(
          url: APIConstants.initializeTransaction,
          data: jsonEncode({
            "email": initiateModel.email,
            "currency": initiateModel.currency,
            "amount": initiateModel.amount,
            "reference": initiateModel.reference,
            "channels": [
              "card",
              "bank",
              "ussd",
              "qr",
              "mobile_money",
              "bank_transfer",
              "eft"
            ],
          }));
      if (response.statusCode == 200) {
        PaystackAuthResponse paystackAuthResponse;
        paystackAuthResponse =
            PaystackAuthResponse.fromMap(response.data as Map<String, dynamic>);
        return paystackAuthResponse;
      } else {
        debugPrint(response.error.toString());
        throw response.error.toString();
      }
    } catch (e) {
      debugPrint(e.toString());

      throw e.toString();
    }
  }

  // verify Transaction after customer makes payment
  Future verifyTransaction(
      String reference,
      Function(Object) onSuccessfulTransaction,
      Function(Object) onFailedTransaction) async {
    ApiResponse response;
    try {
      response =
          await _apiService.get(url: APIConstants.verifyTransaction(reference));
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        if (data["gateway_response"] == "Successful") {
          onSuccessfulTransaction(data);
        } else {
          // notify customser
          onFailedTransaction(data);
        }
      } else {
        // notify customer of error
        onFailedTransaction({"message": "Transaction Failed"});
      }
    } catch (e) {
      onFailedTransaction({"message": "Transaction Failed"});
    }
  }

  // get list of transactions
  Future<List<Transaction>> listTransaction() async {
    ApiResponse response;
    try {
      response = await _apiService.get(url: APIConstants.listTransactions);
      if (response.statusCode == 200) {
        final data = response.data as List;
        if (data.isEmpty) return [];
        return data
            .map((e) => Transaction.fromMap(e as Map<String, dynamic>))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}

final paystackServiceProvider = Provider((ref) {
  return PaystackService(apiService: ref.read(apiServiceProvider));
});
