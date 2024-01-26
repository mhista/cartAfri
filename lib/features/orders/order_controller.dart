import 'package:cartafri/core/type_defs.dart';
import 'package:cartafri/core/utils/snackBar.dart';
import 'package:cartafri/features/auth/controller/authController.dart';
import 'package:cartafri/features/order_items/order_item_model.dart';
import 'package:cartafri/features/order_items/order_item_repository.dart';
import 'package:cartafri/features/orders/order_model.dart';
import 'package:cartafri/features/orders/order_repository.dart';
import 'package:cartafri/features/products/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class OrderController extends StateNotifier<bool> {
  final OrderRepository _orderRepository;
  final Ref _ref;
  final OrderItemRepository _orderItemRepository;

  OrderController(
      {required OrderRepository orderRepository,
      required Ref ref,
      required OrderItemRepository orderItemRepository})
      : _orderRepository = orderRepository,
        _ref = ref,
        _orderItemRepository = orderItemRepository,
        super(false);

  // GET THE UNORDER ORDER
  Stream<Orders?> getUserCurrentOrder(String uid) {
    final userId = _ref.read(userProvider)!.uid;
    return _orderRepository.getUserCurrentOrder(userId);
  }

  // GET THE UNORDER ORDER
  Stream<List<Orders?>> getUserPreviousOrders() {
    final userId = _ref.read(userProvider)!.uid;
    return _orderRepository.getUserPreviousOrders(userId);
  }

  // DELETE ORDER
  void deleteOrderItemFromOrder(
      BuildContext context, Orders order, OrderItem orderItem) async {
    state = true;
    final res =
        await _orderRepository.deleteOrderItemFromOrder(orderItem, order);
    state = false;
    res.fold((l) => showSnackbar2(context, l.message),
        (r) => showSnackbar2(context, 'order deleted'));
  }

  // DELETE ORDER
  void deleteOrder(BuildContext context, Orders order, String userId) async {
    state = true;
    final res = await _orderRepository.deleteOrder(order, userId);
    state = false;
    res.fold((l) => showSnackbar2(context, l.message),
        (r) => showSnackbar2(context, 'order deleted'));
  }
}

// final orderProvider = StateProvider<Orders?>((ref) => null);
/*
ALL ORDER CONTROLLERS
 */
final orderControllerProvider = StateNotifierProvider<OrderController, bool>(
    (ref) => OrderController(
        orderItemRepository: ref.read(orderItemRepositoryProvider),
        orderRepository: ref.read(orderRepositoryProvider),
        ref: ref));

final getCurrentOrderProvider =
    StreamProvider.autoDispose.family((ref, String uid) {
  final orderController = ref.watch(orderControllerProvider.notifier);
  return orderController.getUserCurrentOrder(uid);
});
final getpreviousOrdersProvider = StreamProvider.autoDispose((ref) {
  final orderController = ref.watch(orderControllerProvider.notifier);
  return orderController.getUserPreviousOrders();
});

final orderProvider = StateProvider<Orders?>((ref) => null);
