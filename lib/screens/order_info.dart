import 'package:cartafri/core/utils/constants/color_constants.dart';
import 'package:cartafri/core/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class OrderInfoPage extends ConsumerWidget {
  const OrderInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMM, yyyy').format(now);
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            'Order Information',
            style: kOrderTextStyle,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4.0,
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      // isThreeLine: true,
                      title: const Text(
                        'Order No: 4568',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text('Placed on $formattedDate'),
                      trailing: Material(
                        color: const Color.fromARGB(255, 196, 195, 195),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'IN PROGRESS',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    kSizedBox,
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Paid'),
                    ),
                    kSizedBox,
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text('Status : On the way'),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('STATUS', style: kOrderTextStyle),
            ),
            Expanded(
              child: ListView(
                children: [
                  StatusWidget(
                    formattedDate: formattedDate,
                    status: 'Order placed on $formattedDate',
                    hasDivider: true,
                    dividerHeight: 30,
                    hasInfo: false,
                    statusCompleted: true,
                    stage: null,
                  ),
                  StatusWidget(
                    formattedDate: formattedDate,
                    status: 'Payment Confirmed $formattedDate',
                    hasDivider: true,
                    dividerHeight: 30,
                    hasInfo: false,
                    statusCompleted: true,
                  ),
                  StatusWidget(
                    formattedDate: formattedDate,
                    status: 'Processed on 02 Feb, 2024',
                    hasDivider: true,
                    dividerHeight: 30,
                    hasInfo: false,
                    statusCompleted: true,
                  ),
                  StatusWidget(
                    formattedDate: formattedDate,
                    status: 'On the way',
                    hasDivider: true,
                    dividerHeight: 60,
                    hasInfo: true,
                    statusCompleted: false,
                    stage: 4,
                  ),
                  StatusWidget(
                    formattedDate: formattedDate,
                    status: 'Expected delivery, 06 Feb, 2024',
                    hasDivider: false,
                    dividerHeight: 30,
                    hasInfo: false,
                    statusCompleted: false,
                    stage: 5,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    super.key,
    required this.formattedDate,
    required this.status,
    required this.hasDivider,
    required this.dividerHeight,
    required this.hasInfo,
    required this.statusCompleted,
    this.stage,
  });
  final String status;
  final bool hasDivider;
  final double dividerHeight;
  final String formattedDate;
  final bool hasInfo;
  final bool statusCompleted;
  final int? stage;

  @override
  Widget build(BuildContext context) {
    final String text = lorem(paragraphs: 1, words: 14);
    return Column(
      children: [
        ListTile(
          visualDensity: const VisualDensity(horizontal: -4),
          leading: Chip(
            backgroundColor: ColorConstants.kButtonColor2,
            padding: const EdgeInsets.all(0.0),
            // labelPadding: EdgeInsets.all(16.0),
            label: statusCompleted
                ? const Icon(
                    Icons.done,
                    color: Colors.white,
                    size: 12,
                  )
                : Text(
                    stage.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
            shape: const CircleBorder(),
            side: const BorderSide(
                width: 0.1,
                strokeAlign: BorderSide.strokeAlignOutside,
                color: Colors.grey),
          ),
          title: Text(
            status,
            style: kOrderTextStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              hasDivider
                  ? SizedBox(
                      height: dividerHeight,
                      child: const VerticalDivider(
                        color: Colors.black,
                      ),
                    )
                  : Container(),
              hasInfo
                  ? const Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Text(
                          'jennifer picked your order, you can contact her anytime.',
                          // softWrap: true,
                        ),
                      ),
                    )
                  : const Text(''),
            ],
          ),
        ),
      ],
    );
  }
}
