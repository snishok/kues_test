import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'quantity_state.dart';

class CartQuantityCubit extends Cubit<int> {
  CartQuantityCubit() : super(1); // Initial quantity set to 1

  // Method to increment quantity
  void increment() => emit(state + 1);

  // Method to decrement quantity (with a minimum of 1)
  void decrement() {
    if (state > 1) {
      emit(state - 1);
    }
  }
}

