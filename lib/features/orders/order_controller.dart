import 'package:cartafri/features/orders/order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderController extends StateNotifier<bool> {
  final OrderRepository _orderRepository;
  final Ref _ref;

  OrderController({required OrderRepository orderRepository, required Ref ref})
      : _orderRepository = orderRepository,
        _ref = ref,
        super(false);
}
