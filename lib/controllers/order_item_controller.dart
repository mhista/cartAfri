import 'package:cartafri/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cartafri/core/utils/commons/snackbar.dart';
import 'package:cartafri/controllers/authController.dart';
import 'package:cartafri/models/order_item_model.dart';
import 'package:cartafri/providers/order_item_repository.dart';
import 'package:cartafri/controllers/order_controller.dart';
import 'package:cartafri/providers/order_repository.dart';

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
    final res = await _orderItemRepository.createOrUpdateOrderItem(orderItem);
    res.fold((l) {
      return showSnackbar2(context, l.message);
    },
        // ignore: void_checks
        (item) {
      _ref.watch(orderItemProvider.notifier).update((state) => item);
      return orderItem = item;
    });

    final result = await _orderRepository.createOrUpdateOrder(
        id: _ref.read(userProvider)!.uid,
        orderItem: res.foldRight(orderItem, (acc, b) => b));
    state = false;

    result.fold((l) => showSnackbar2(context, l.message), (order) {
      _ref.watch(orderProvider.notifier).update((state) => order);
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
      showSnackbar2(context, 'Item removed');
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
final orderItemProvider = StateProvider<OrderItem?>((ref) => null);
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
