import 'package:cartafri/core/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class OrdersPage extends ConsumerWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMM, yyyy').format(now);
    String formattedTime = DateFormat('hh:mm').format(now);
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            'Orders',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        body: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return OrdersWidget(
                  formattedDate: formattedDate, formattedTime: formattedTime);
            }));
  }
}

class OrdersWidget extends StatelessWidget {
  const OrdersWidget({
    super.key,
    required this.formattedDate,
    required this.formattedTime,
  });

  final String formattedDate;
  final String formattedTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: const BorderSide(
              width: 1.0,
            )),
        elevation: 0.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                // isThreeLine: true,
                title: const Text(
                  'Order 4568',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                subtitle: const Text('\$ 54.99'),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${formattedDate} $formattedTime'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 100.0,
                      width: 100.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset('images/bag (5).jpg',
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      height: 100.0,
                      width: 100.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset('images/cos (8).jpg',
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      height: 100.0,
                      width: 100.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset('images/homes (3).jpg',
                            fit: BoxFit.cover),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
