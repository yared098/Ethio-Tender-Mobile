import 'package:ettmobile/core/repository/product_repository.dart';
import 'package:flutter/material.dart';


class ProductViewModel extends ChangeNotifier {
  final ProductRepository repository;
  List<Map<String, dynamic>> _products = [];

  ProductViewModel(this.repository);

  List<Map<String, dynamic>> get products => _products;

  Future<void> fetchProducts() async {
    _products = await repository.getProducts();
    notifyListeners();
  }

  Future<void> addProduct(Map<String, dynamic> product) async {
    await repository.addProduct(product);
    await fetchProducts();
  }
}
