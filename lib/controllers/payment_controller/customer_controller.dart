import 'package:cartafri/core/utils/commons/snackbar.dart';
import 'package:cartafri/features/auth/controller/authController.dart';
import 'package:cartafri/features/payment/payment_models/customers.dart';
import 'package:cartafri/features/payment/payment_services/customer_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaystackCustomerController extends StateNotifier<bool> {
  final Ref _ref;
  final CustomerService _customerService;

  PaystackCustomerController(
      {required Ref ref, required CustomerService customerService})
      : _ref = ref,
        _customerService = customerService,
        super(false);

  Future<Customer?> getOrCreateCustomer(BuildContext context,
      {required String email, required String phone}) async {
    state = true;
    Customer customer;
    final user = _ref.read(userProvider);
    final name = user!.name.split(' ');
    customer = Customer(
        first_name: name[0], last_name: name[1], email: email, phone: phone);
    final res = await _customerService.getOrCreateCustomer(customer, user.uid);
    state = false;
    res.fold(
      (l) => showSnackbar2(context, l.message),
      (r) => customer = r,
    );
    return customer;
  }

  Future<Customer> getCusteomer(BuildContext context) async {
    Customer customer = Customer();

    final user = _ref.read(userProvider);
    final res = await _customerService.getCustomer(user!.uid);
    res.fold(
      (l) => showSnackbar2(context, l.message),
      (r) => customer = customer,
    );
    return customer;
  }
}

final paystackCustomerController =
    StateNotifierProvider<PaystackCustomerController, bool>((ref) {
  return PaystackCustomerController(
    customerService: ref.watch(customerServiceProvider),
    ref: ref,
  );
});
