import 'package:cartafri/core/utils/commons/snackbar.dart';
import 'package:cartafri/features/product_category/category_model.dart';
import 'package:cartafri/features/product_category/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class CategoryController extends StateNotifier<bool> {
  final CategoryRepository _categoryRepository;
  final Ref _ref;

  CategoryController({
    required CategoryRepository categoryRepository,
    required Ref ref,
  })  : _categoryRepository = categoryRepository,
        _ref = ref,
        super(false);

  void createCategory(BuildContext context) async {
    final Categories category = Categories(name: 'bags', id: const Uuid().v4());
    final res = await _categoryRepository.createCategory(category);
    res.fold(
      (l) => showSnackbar2(context, l.message),
      (r) => showSnackbar2(context, 'created'),
    );
  }
}
