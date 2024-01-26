import 'package:cartafri/features/orders/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cartafri/core/utils/snackbar.dart';
import 'package:cartafri/features/auth/controller/authController.dart';
import 'package:cartafri/features/order_items/order_item_model.dart';
import 'package:cartafri/features/order_items/order_item_repository.dart';
import 'package:cartafri/features/orders/order_controller.dart';
import 'package:cartafri/features/orders/order_repository.dart';
import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';

class OrderItemController extends StateNotifier<bool> {
  final OrderRepository _orderRepository;
  final Ref _ref;
  final OrderItemRepository _orderItemRepository;

  OrderItemController(
      {required OrderRepository orderRepository,
      required Ref ref,
      required OrderItemRepository orderItemRepository})
      : _orderRepository = orderRepository,
        _ref = ref,
        _orderItemRepository = orderItemRepository,
        super(false);

  // UPDATE THE ORDERITEM
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
    state = true;
    // CREATES OR UPDATES THE ORDERITEM AND RETRIEVES IT
    final res = await _orderItemRepository.createOrUpdateOrderItem(orderItem);
    res.fold((l) {
      return null;
    }, (item) => orderItem = item);
    // ADDS THE ORDERITEMS ID TO THE USERS CURRENT ORDER
    final result = await _orderRepository.createOrUpdateOrder(
        id: _ref.read(userProvider)!.uid,
        orderItem: res.foldRight(orderItem, (acc, b) => b));
    state = false;
    result.fold((l) => showSnackbar2(context, l.message), (order) {
      _ref.read(orderProvider.notifier).update((state) => order);
      showSnackbar2(context, 'Item added to cart');
      Routemaster.of(context).pop();
    });
  }

//GET THE ORDERITEMS IN AN ORDER
  Stream<List<OrderItem>> getOrderItem(String item) {
    final userId = _ref.read(userProvider)!.uid;
    final order = _ref.read(orderProvider)!.orderItems;
    return _orderItemRepository.getOrderItem(userId, order);
  }
}

// ASSIGNING PROVIDERS
final orderItemController =
    StateNotifierProvider<OrderItemController, bool>((ref) {
  return OrderItemController(
      orderItemRepository: ref.watch(orderItemRepositoryProvider),
      ref: ref,
      orderRepository: ref.watch(orderRepositoryProvider));
});

final getorderItemProvider =
    StreamProvider.family.autoDispose((ref, String itemId) {
  final itemController = ref.watch(orderItemController.notifier);
  return itemController.getOrderItem(itemId);
});
