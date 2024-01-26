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

  // UPDATE AN ORDERITEM IN AN ORDER
  void createOrUpdateOrderItem(
    BuildContext context, {
    required String id,
    required String productId,
    required int quantity,
    required int size,
  }) async {
    OrderItem orderItem;
    orderItem = OrderItem(
        id: id,
        productId: productId,
        quantity: quantity,
        size: size,
        userId: _ref.read(userProvider)!.uid);
    // state = true;
    final res = await _orderItemRepository.createOrUpdateOrderItem(orderItem);
    res.fold((l) {
      return null;
    }, (item) => orderItem = item);
    final result = await _orderRepository.createOrUpdateOrder(
        id: _ref.read(userProvider)!.uid,
        orderItem: res.foldRight(orderItem, (acc, b) => b));
    state = false;
    result.fold((l) => showSnackbar2(context, l.message),
        (r) => showSnackbar2(context, 'Item added to cart'));
  }

  // GET THE UNORDER ORDER
  Stream<Orders?> getUserCurrentOrder() {
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

final getCurrentOrderProvider = StreamProvider.autoDispose((ref) {
  final orderController = ref.watch(orderControllerProvider.notifier);
  return orderController.getUserCurrentOrder();
});
final getpreviousOrdersProvider = StreamProvider.autoDispose((ref) {
  final orderController = ref.watch(orderControllerProvider.notifier);
  return orderController.getUserPreviousOrders();
});
