import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kues/listvew_with_filters/domain/entity/character.dart';
import 'package:kues/listvew_with_filters/presentation/using_bloc/cart_page/data/cart_repo.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;

  CartBloc(this.repository) : super(CartState()) {
    on<AddToCart>((event, emit) {
      repository.addItem(event.item);
      emit(CartState(
        items: repository.items,
        totalPrice: repository.totalPrice,
      ));
    });

    on<RemoveFromCart>((event, emit) {
      repository.removeItem(event.itemId);
      emit(CartState(
        items: repository.items,
        totalPrice: repository.totalPrice,
      ));
    });

    on<ClearCart>((event, emit) {
      repository.clearCart();
      emit(CartState(
        items: repository.items,
        totalPrice: repository.totalPrice,
      ));
    });

    on<IncrementQuantity>((event, emit) {
      final currentState = state;
        final updatedCart = currentState.items.map((item) {
          if (item.id == event.item.id) {
            return item.copyWith(quantity: item.quantity! + 1);
          }
          return item;
        }).toList();
      repository.clearCart();
      for (var item in updatedCart) {
        repository.addItem(item);
      }
        emit(CartState(
          items: repository.items,
          totalPrice: repository.totalPrice,
        ));
    });

    on<DecrementQuantity>((event, emit) {
      final currentState = state;
        final updatedCart = currentState.items.map((item) {
          if (item.id == event.item.id && item.quantity! > 1) {
            return item.copyWith(quantity: item.quantity! - 1);
          }
          return item;
        }).toList();
      repository.clearCart();
      for (var item in updatedCart) {
          repository.addItem(item);
      }

        emit(CartState(
          items: repository.items,
          totalPrice: repository.totalPrice,
        ));
    });
  }
}

