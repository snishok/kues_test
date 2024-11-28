import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kues/listvew_with_filters/presentation/using_bloc/cart_page/bloc/cart_bloc.dart';
import 'package:kues/listvew_with_filters/presentation/using_bloc/cart_page/bloc/cart_event.dart';
import 'package:kues/listvew_with_filters/presentation/using_bloc/cart_page/bloc/cart_state.dart';
import 'package:kues/listvew_with_filters/presentation/using_bloc/cart_page/bloc/quantity_cubit.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(children: [
        Container(
          margin: const EdgeInsets.only(top: 16, bottom: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
          height: 4,
          width: 32,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            ),
            child: Container(
              child: Column(children: [
                deliveryInfoWidget(),
                Expanded(
                  child: BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      if (state.items.isEmpty) {
                        return Center(child: Text('Your cart is empty'));
                      }

                      return ListView.builder(
                        itemCount: state.items.length,
                        itemBuilder: (context, index) {
                          final item = state.items[index];
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Image Section
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    item.image.toString(), // Replace with actual image URL
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
                                          Container(
                                            width: 32,
                                            height: 32,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: IconButton(
                                              onPressed: () {
                                                context
                                                    .read<CartBloc>()
                                                    .add(DecrementQuantity(item));
                                                // Handle decrement
                                              },
                                              icon: Icon(Icons.remove),
                                              color: Colors.black,
                                              iconSize: 20,
                                              padding: EdgeInsets.zero,
                                              constraints: BoxConstraints(),
                                            ),
                                          ),
                                          // Quantity Text
                                          Text(
                                            '  '+item.quantity.toString()+'  ',
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
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: IconButton(
                                              onPressed: () {
                                                context
                                                    .read<CartBloc>()
                                                    .add(IncrementQuantity(item));
                                              },
                                              icon: Icon(Icons.add),
                                              color: Colors.black,
                                              iconSize: 20,
                                              padding: EdgeInsets.zero,
                                              constraints: BoxConstraints(),
                                            ),
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
                    )*/;
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.restaurant, size: 24, color: Colors.black),
                          SizedBox(width: 12),
                          Text(
                            "Cutlery",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.read<CartQuantityCubit>().decrement();
                            },
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.remove, size: 20, color: Colors.black),
                            ),
                          ),
                          SizedBox(width: 12),
                          BlocBuilder<CartQuantityCubit, int>(
                            builder: (context, quantity) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  '$quantity',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 12),
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
                              child: Icon(Icons.add, size: 20, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "\$0.00",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Free delivery from \$30",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
              ]),
            ),
          ),
        )
      ]),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Container(
            color: Colors.white,
            height: 200,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                        padding: EdgeInsets.only(left: 16)),
                    SizedBox(height: 10),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset(
                              'assets/images/img.png',
                              // Replace with your Apple Pay logo asset
                              height: 30,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            "Apple pay",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.chevron_right, color: Colors.black),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pay",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "24 min ",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                " • \$47.00",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ) /*Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${state.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<CartBloc>().add(ClearCart());
                  },
                  child: Text('Checkout'),
                ),
              ],
            ),
          )*/
              ;
        },
      ),
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

  Widget cartItem(var item, var context){
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
                          context
                              .read<CartBloc>()
                              .add(DecrementQuantity(item));
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
                        context
                            .read<CartBloc>()
                            .add(IncrementQuantity(item));
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
  Widget deliveryInfoWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'We will deliver in',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Text(
                '24 minutes',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                ' to the address:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '100a Ealing Rd',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Add functionality to change address
                },
                child: Text(
                  'Change address',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black12,
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
