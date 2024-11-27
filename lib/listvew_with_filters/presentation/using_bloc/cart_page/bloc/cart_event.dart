import 'package:equatable/equatable.dart';
import 'package:kues/listvew_with_filters/domain/entity/character.dart';
import '../data/cart_item.dart';


abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddToCart extends CartEvent {
  final Character item;

  AddToCart(this.item);

  @override
  List<Object?> get props => [item];
}

class RemoveFromCart extends CartEvent {
  final String itemId;

  RemoveFromCart(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class ClearCart extends CartEvent {}
