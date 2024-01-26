import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cartafri/core/utils/snackbar.dart';
import 'package:cartafri/features/auth/controller/authController.dart';
import 'package:cartafri/features/order_items/order_item_model.dart';
import 'package:cartafri/features/order_items/order_item_repository.dart';
import 'package:cartafri/features/orders/order_controller.dart';
import 'package:cartafri/features/orders/order_repository.dart';
import 'package:uuid/uuid.dart';

class OrderItemContoller extends StateNotifier<bool> {
  final OrderItemRepository _orderItemRepository;
  final Ref _ref;

  OrderItemContoller({
    required OrderItemRepository orderItemRepository,
    required Ref ref,
  })  : _orderItemRepository = orderItemRepository,
        _ref = ref,
        super(false);

  // UPDATE THE ORDERITEM

  Stream<OrderItem> getOrderItem(String itemId) =>
      _orderItemRepository.getOrderItem(itemId);
}

final orderItemController =
    StateNotifierProvider<OrderItemContoller, bool>((ref) {
  return OrderItemContoller(
      orderItemRepository: ref.watch(orderItemRepositoryProvider), ref: ref);
});

final getorderItemProvider =
    StreamProvider.family.autoDispose((ref, String itemId) {
  final itemController = ref.watch(orderItemController.notifier);
  return itemController.getOrderItem(itemId);
});
