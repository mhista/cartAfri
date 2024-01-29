import 'package:cartafri/features/orders/order_model.dart';
import 'package:cartafri/features/products/product_model.dart';
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

  // UPDATE OR CREATE THE ORDERITEM
  void createOrUpdateOrderItem(
    BuildContext context, {
    required String id,
    required Product product,
    required int quantity,
    required int size,
  }) async {
    OrderItem orderItem;
    orderItem = OrderItem(
        ordered: false,
        id: id,
        quantity: quantity,
        size: size,
        userId: _ref.read(userProvider)!.uid,
        product: product);
    state = true;
    // CREATES OR UPDATES THE ORDERITEM AND RETRIEVES IT
    final res = await _orderItemRepository.createOrUpdateOrderItem(orderItem);
    res.fold((l) {
      return showSnackbar2(context, l.message);
    }, (item) => orderItem = item);
    // ADDS THE ORDERITEMS ID TO THE USERS CURRENT ORDER
    final result = await _orderRepository.createOrUpdateOrder(
        id: _ref.read(userProvider)!.uid,
        orderItem: res.foldRight(orderItem, (acc, b) => b));
    state = false;
    result.fold((l) => showSnackbar2(context, l.message), (order) {
      // showSnackbar2(context, order.toString());
      _ref.read(orderProvider.notifier).update((state) => order);
    });
  }

// DECREAESE THE SIZE OF THE ORDERITEM
  void decreaseOrderItem(
    BuildContext context, {
    required OrderItem orderItem,
  }) async {
    // OrderItem orderItemm;

    state = true;
    final res = await _orderItemRepository.decreaseOrderItem(orderItem);
    res.fold((l) {
      return showSnackbar2(context, l.message);
    }, (item) => item);
    final result = await _orderRepository.deleteOrderItemFromOrder(
        id: _ref.read(userProvider)!.uid,
        orderItem: res.foldRight(orderItem, (acc, b) => b));
    state = false;
    result.fold((l) => showSnackbar2(context, l.message), (order) {
      showSnackbar2(context, 'Item deleted');
    });
  }

//GET THE ORDERITEMS IN AN ORDER
  Stream<List<OrderItem>> getOrderItem() {
    final user = _ref.read(userProvider)!.uid;
    return _orderItemRepository.getOrderItems(user);
  }

// GET THE ORDERITEM TOTAL
  Stream<double> getTotal() {
    final user = _ref.read(userProvider)!.uid;
    return _orderItemRepository.getTotal(user);
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

final getorderItemProvider = StreamProvider.autoDispose((ref) {
  final itemController = ref.watch(orderItemController.notifier);
  return itemController.getOrderItem();
});
final getOrderTotal = StreamProvider.autoDispose((ref) {
  final itemController = ref.watch(orderItemController.notifier);
  return itemController.getTotal();
});
