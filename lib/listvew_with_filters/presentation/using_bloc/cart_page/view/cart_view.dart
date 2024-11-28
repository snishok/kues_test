import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kues/listvew_with_filters/presentation/using_bloc/cart_page/bloc/cart_bloc.dart';
import 'package:kues/listvew_with_filters/presentation/using_bloc/cart_page/bloc/cart_event.dart';
import 'package:kues/listvew_with_filters/presentation/using_bloc/cart_page/bloc/cart_state.dart';
import 'package:kues/listvew_with_filters/presentation/using_bloc/cart_page/bloc/quantity_cubit.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: _appBar(),
      ),
      body: _cartBody(context),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: IconButton(
        icon: Icon(icon, size: 18),
        onPressed: onPressed,
      ),
    );
  }

  Widget _appBar() {
    return Container(
        width: 200.0,
        height: 200.0,
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 4,
                width: 32.0,
                margin: const EdgeInsets.only(top: 16, bottom: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                ),
              ),
            ),
            Container(
              height: 32.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
              ),
            ),
          ],
        ));
  }

  Widget _cartBody(var context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.white,
            child: ListView(children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                  ),
                  child: Container(
                    child: Column(children: [
                      deliveryInfoWidget(context),
                      Container(
                        child: BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            if (state.items.isEmpty) {
                              return Center(child: Text('Your cart is empty'));
                            }

                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.items.length,
                              itemBuilder: (context, index) {
                                final item = state.items[index];
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Image Section
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          item.image.toString(),
                                          // Replace with actual image URL
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      // Text and Counter Section
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width * 0.4,
                                              child: Text(
                                                item.name!,
                                                style: textTheme.bodyLarge!
                                                    .copyWith(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              children: [
                                                // Minus Button
                                                Container(
                                                  width: 32,
                                                  height: 32,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      context
                                                          .read<CartBloc>()
                                                          .add(
                                                              DecrementQuantity(
                                                                  item));
                                                      // Handle decrement
                                                    },
                                                    icon: Icon(Icons.remove),
                                                    color: Colors.black,
                                                    iconSize: 20,
                                                    padding: EdgeInsets.zero,
                                                    constraints:
                                                        BoxConstraints(),
                                                  ),
                                                ),
                                                // Quantity Text
                                                Text(
                                                  '  ' +
                                                      item.quantity.toString() +
                                                      '  ',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                // Plus Button
                                                Container(
                                                  width: 32,
                                                  height: 32,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      context
                                                          .read<CartBloc>()
                                                          .add(
                                                              IncrementQuantity(
                                                                  item));
                                                    },
                                                    icon: Icon(Icons.add),
                                                    color: Colors.black,
                                                    iconSize: 20,
                                                    padding: EdgeInsets.zero,
                                                    constraints:
                                                        BoxConstraints(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Price Section
                                      Container(
                                        height: 90,
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          '\$${(double.parse(item.cost!) * item.quantity!).toStringAsFixed(2)}',
                                          style: textTheme.bodyLarge!
                                              .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      )

                                    ],
                                  ),
                                );
                                /*ListTile(
                      title: Text(item.name!),
                      subtitle: Text('${item.quantity} x \$${item.quantity}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              context
                                  .read<CartBloc>()
                                  .add(DecrementQuantity(item));
                            },
                          ),
                          Text(item.quantity.toString()),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              context
                                  .read<CartBloc>()
                                  .add(IncrementQuantity(item));
                            },
                          ),
                        ],
                      ),
                    )*/
                                ;
                              },
                            );
                          },
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Divider(
                          color: Colors.black12,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 8),
                              child: Icon(Icons.restaurant,
                                  size: 24, color: Colors.black),
                            ),
                            Text(
                              "Cutlery",
                              style: textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<CartQuantityCubit>()
                                        .decrement();
                                  },
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(Icons.remove,
                                        size: 20, color: Colors.black),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                BlocBuilder<CartQuantityCubit, int>(
                                  builder: (context, quantity) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        '$quantity',
                                        style: textTheme.bodyLarge!.copyWith(
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 6),
                                GestureDetector(
                                  onTap: () {
                                    context.read<CartQuantityCubit>().increment();
                                  },
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(Icons.add,
                                        size: 20, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Divider(
                          color: Colors.black12,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 20, bottom: 220, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Delivery",
                                  style: textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                const Text(
                                  '\$0.00',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Free delivery from \$30',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ]),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    context.read<CartBloc>().add(ClearCart());
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    color: Colors.white,
                    height: 200,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                child: Text(
                                  "Payment method",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                padding: EdgeInsets.only(left: 8)),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Image.asset(
                                      'assets/images/img.png',
                                      // Replace with your Apple Pay logo asset
                                      height: 25,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    "Apple pay",
                                    style: textTheme.labelLarge!.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.chevron_right, color: Colors.black),
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Pay",
                                    style: textTheme.bodyLarge!.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "24 min",
                                        style: textTheme.labelMedium!.copyWith(
                                          fontWeight:  FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "• \$${state.totalPrice.toStringAsFixed(2)}",
                                        style: textTheme.bodyLarge!.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  Widget cartItem(var item, var context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image Section
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              'https://via.placeholder.com/80', // Replace with actual image URL
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          // Text and Counter Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Poke with chicken and corn',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    // Minus Button
                    IconButton(
                      onPressed: () {
                        context.read<CartBloc>().add(DecrementQuantity(item));
                        // Handle decrement
                      },
                      icon: Icon(Icons.remove),
                      color: Colors.black,
                      iconSize: 20,
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                    // Quantity Text
                    Text(
                      item.quantity.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    // Plus Button
                    IconButton(
                      onPressed: () {
                        context.read<CartBloc>().add(IncrementQuantity(item));
                      },
                      icon: Icon(Icons.add),
                      color: Colors.black,
                      iconSize: 20,
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Price Section
          Text(
            '\$47.00',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget deliveryInfoWidget(var context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: 0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'We will deliver in',
            style: textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Text(
                '24 minutes',
                style: textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                ' to the address',
                style: textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '100a Ealing Rd',
                style: textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Add functionality to change address
                },
                child: Text(
                  'Change address',
                  style: textTheme.bodyMedium!.copyWith(
                    color: Colors.black26,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
