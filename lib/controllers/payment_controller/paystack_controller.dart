import 'package:cartafri/features/payment/payment_models/initiate_transaction.dart';
import 'package:cartafri/features/payment/payment_models/paystack_auth_response.dart';
import 'package:cartafri/features/payment/payment_models/transaction.dart';
import 'package:cartafri/features/payment/payment_services/paystack_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaystackController extends StateNotifier<bool> {
  final Ref _ref;
  final PaystackService _paystackService;

  PaystackController(
      {required Ref ref, required PaystackService paystackService})
      : _ref = ref,
        _paystackService = paystackService,
        super(false);

// initialize paystack transaction
  Future<PaystackAuthResponse> initializeTransaction(
      InitiateModel initiateModel) async {
    return _paystackService.initializeTransaction(initiateModel: initiateModel);
  }

// verify transaction
  Future verifyTransaction(
      String reference,
      Function(Object) onSuccessfulTransaction,
      Function(Object) onFailedTransaction) async {
    return _paystackService.verifyTransaction(
        reference, onSuccessfulTransaction, onFailedTransaction);
  }

  // get of transaction
  Future<List<Transaction>> listTransaction() async {
    return _paystackService.listTransaction();
  }
}

// paystack controller provider
final paystackControllerProvider =
    StateNotifierProvider<PaystackController, bool>((ref) => PaystackController(
        ref: ref, paystackService: ref.read(paystackServiceProvider)));

// provider for initializing paystack transaction
final initiateTransactionProvider =
    FutureProvider.autoDispose.family((ref, InitiateModel initiateModel) {
  final paystackControl = ref.watch(paystackControllerProvider.notifier);
  return paystackControl.initializeTransaction(initiateModel);
});

final verifyTransactionController =
    FutureProvider.family.autoDispose((ref, Map<String, dynamic> data) {
  final paystackControl = ref.watch(paystackControllerProvider.notifier);
  return paystackControl.verifyTransaction(data["reference"],
      data["onSuccessfulTransaction"], data["onFailedTransaction"]);
});

final listTranssactionProvider =
    FutureProvider.family.autoDispose((ref, String string) {
  final paystackControl = ref.watch(paystackControllerProvider.notifier);
  return paystackControl.listTransaction();
});
