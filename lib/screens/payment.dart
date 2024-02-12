import 'package:cartafri/core/utils/constants/constants.dart';
import 'package:cartafri/core/utils/commons/isLoading.dart';
import 'package:cartafri/core/utils/commons/shared_textfield.dart';
import 'package:cartafri/core/utils/commons/reusables.dart';
import 'package:cartafri/features/payment/payment_controller/customer_controller.dart';
import 'package:cartafri/features/payment/payment_controller/paystack_controller.dart';
import 'package:cartafri/features/payment/paystack/keys.dart';
import 'package:cartafri/features/payment/paystack/make_payment.dart';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  final String amount;

//  /for notiifying the user about the failed transaction
  const PaymentScreen({required this.amount, super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final PaystackPlugin plugin = PaystackPlugin();

  @override
  void initState() {
    plugin.initialize(publicKey: SecretKey.publicKey);
    debugPrint(widget.amount);
    super.initState();
  }

  saveCustomer(BuildContext context, WidgetRef ref) async {
    final cust = ref
        .watch(paystackCustomerController.notifier)
        .getOrCreateCustomer(context,
            email: _emailController.text, phone: _phoneController.text);
    await cust.then((value) {
      debugPrint(value.toString());
      MakePayment(
              context: context,
              amount: int.parse(widget.amount),
              email: value!.email!)
          .chargeCardAndMakePayment();
      Routemaster.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(paystackCustomerController);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Payment',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const AuthIcons(
                authIcon: Icons.currency_exchange,
                size: 50,
              ),
              kSizedBox,
              const Text('', style: kTextStyleSpacing),
              kSizedBox,
              InputTextWidget(
                hintText: 'Email Address',
                iconData: Icons.mail_outline,
                textInputType: TextInputType.emailAddress,
                controller: _emailController,
              ),
              kSizedBox,
              InputTextWidget(
                hintText: 'Phone',
                iconData: Icons.phone_android,
                textInputType: TextInputType.phone,
                controller: _phoneController,
              ),
              kSizedBox,
              ExpandedButton(
                onpress: () {
                  saveCustomer(context, ref);
                },
                text: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: isLoading
                      ? const Loader()
                      : const Text(
                          'Proceed To Payment',
                          style: kTextStyleSpacing,
                        ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// // send the information to paystack to initialize and generate authorized transaction url so we need  async widgets
//     final initatedData = ref.watch(initiateTransactionProvider(InitiateModel(
//       email: "diweesomchi@gmail.com",
//       amount: "1000",
//       reference: const Uuid().v4(),
//       metadata: '',
//     )));
//     return initatedData.when(
//         data: (data) {
//           return PopScope(
//             canPop: true,
//             onPopInvoked: ((didPop) async {
//               // chechk if user has already finished transaction or abandoned it
//               if (didPop) {
//                 if (data.authorization_url != null) {
//                   ref
//                       .read(paystackControllerProvider.notifier)
//                       .verifyTransaction(data.reference!,
//                           onCompletedTransaction, onFailedTransaction)
//                       .then((value) => Routemaster.of(context).pop());
//                 } else {
//                   Routemaster.of(context).pop();
//                 }
//               }
//             }),
//             //  Render the url received rom paystack
//             child: Scaffold(
//               appBar: AppBar(
//                   leading: IconButton(
//                     // user might want to leave the page without completeing the transaction. we need to let the user know the transaction status
//                     // web hook will be used here, as the event of the trnsaction may take longer than expected
//                     onPressed: () {
//                       if (data.authorization_url != null) {
//                         ref
//                             .read(paystackControllerProvider.notifier)
//                             .verifyTransaction(data.reference!,
//                                 onCompletedTransaction, onFailedTransaction)
//                             .then((value) => Routemaster.of(context).pop());
//                       } else {
//                         Routemaster.of(context).pop();
//                       }
//                     },
//                     icon: const Icon(Icons.close),
//                   ),
//                   title: const AppBarTitle(
//                     title: 'Pay with Paystack',
//                   )),
//               body: WebViewWidget(controller: _controller),
//             ),
//           );
//         },
//         error: (error, stackTrace) => ErrorText(error: error.toString()),
//         loading: () => const Loader());
//   }