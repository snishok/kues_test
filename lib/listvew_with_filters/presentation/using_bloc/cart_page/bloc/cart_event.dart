import 'package:equatable/equatable.dart';
import 'package:kues/listvew_with_filters/domain/entity/character.dart';


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


class IncrementQuantity extends CartEvent {
  final Character item;

  IncrementQuantity(this.item);

  @override
  List<Object?> get props => [item];
}

class DecrementQuantity extends CartEvent {
  final Character item;

  DecrementQuantity(this.item);

  @override
  List<Object?> get props => [item];
}
