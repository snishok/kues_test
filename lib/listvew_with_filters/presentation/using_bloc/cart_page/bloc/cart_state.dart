import 'package:equatable/equatable.dart';
import 'package:kues/listvew_with_filters/domain/entity/character.dart';


class CartState extends Equatable {
  final List<Character> items;
  final double totalPrice;

  const CartState({
    this.items = const [],
    this.totalPrice = 0.0,
  });

  @override
  List<Object?> get props => [items, totalPrice];
}

