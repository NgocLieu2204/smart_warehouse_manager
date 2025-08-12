import 'package:equatable/equatable.dart';
import 'package:smart_warehouse_manager/models/product_model.dart';
class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}
 
class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  const ProductLoaded(this.products);

  @override
  List<Object?> get props => [products];
}


class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);
}