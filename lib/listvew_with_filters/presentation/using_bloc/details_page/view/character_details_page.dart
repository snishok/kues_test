import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kues/listvew_with_filters/domain/entity/character.dart';
import 'package:kues/listvew_with_filters/presentation/using_bloc/cart_page/bloc/cart_bloc.dart';
import 'package:kues/listvew_with_filters/presentation/using_bloc/cart_page/bloc/cart_event.dart';
import 'package:kues/listvew_with_filters/presentation/using_bloc/details_page/bloc/character_details_bloc.dart';
import 'package:kues/listvew_with_filters/presentation/using_bloc/details_page/bloc/quantity_cubit.dart';

// -----------------------------------------------------------------------------
// Page
// -----------------------------------------------------------------------------
class CharacterDetailsPage extends StatelessWidget {
  const CharacterDetailsPage({super.key});

  static Route<void> route({required Character character}) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (_) => CharacterDetailsBloc(character: character),
          child: const CharacterDetailsPage(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const CharacterDetailsView();
  }
}

// -----------------------------------------------------------------------------
// View
// -----------------------------------------------------------------------------
class CharacterDetailsView extends StatelessWidget {
  const CharacterDetailsView({super.key});

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
            child: const _Content(),
          ),
        )
      ]),
    );
  }
}

// -----------------------------------------------------------------------------
// Content
// -----------------------------------------------------------------------------
class _Content extends StatelessWidget {
  const _Content({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: Builder(
        builder: (ctx) {
          final character = ctx.select(
            (CharacterDetailsBloc b) => b.state.character,
          );

          return Container(
            height: MediaQuery.sizeOf(context).height * 0.82,
              child: Stack(
              children: [

              Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: character.id!,
                child: CachedNetworkImage(
                  imageUrl: character.image!,
                  fit: BoxFit.fitHeight,
                  height: 300,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        character.name ?? '',
                        style: textTheme.displaySmall!.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Origin: ${character.origin?.name ?? ''}',
                        style: textTheme.bodyMedium!.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      // const SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  border: Border(
                    top: BorderSide(width: 1.0, color: Colors.black12),
                    bottom: BorderSide(width: 1.0, color: Colors.black12),
                    left: BorderSide(width: 1.0, color: Colors.black12),
                    right: BorderSide(width: 1.0, color: Colors.black12),
                  ),
                ),
                height: 80,
                child: GridView.custom(
                  physics: NeverScrollableScrollPhysics(),
                  primary: false,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
                  childrenDelegate: SliverChildListDelegate(
                    [
                      _buildNutritionInfo('325','kcal'),
                      _buildNutritionInfo('420','grams'),
                      _buildNutritionInfo('21','proteins'),
                      _buildNutritionInfo('19','fats'),
                      _buildNutritionInfo('65','carbs'),
                    ],
                  ),
                )
              ),
              SizedBox(
                height: 32,
              ),
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add in Poke',
                    style: textTheme.bodyLarge!.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              ),

            ],
          ),
          Positioned.fill(
          child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      // Quantity Selector
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            _buildQuantityButton(Icons.remove, () {
                              context.read<QuantityCubit>().decrement();
                            }),
                            BlocBuilder<QuantityCubit, int>(
                              builder: (context, quantity) {
                                return Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
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
                            _buildQuantityButton(Icons.add, () {
                              context.read<QuantityCubit>().increment();
                            }),
                          ],
                        ),
                      ),

                      // Add to Cart Button
                      BlocBuilder<QuantityCubit, int>(
                        builder: (context, quantity) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              context.read<CartBloc>().add(AddToCart(character));
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Add to cart',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '\$${(47.00 * quantity).toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),),
          ),
          ],),);
        },
      ),
    );
  }

  Widget _buildNutritionInfo(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
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
}

// -----------------------------------------------------------------------------
// Episode
// -----------------------------------------------------------------------------
class EpisodeItem extends StatelessWidget {
  const EpisodeItem({super.key, required this.ep});

  final String ep;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final name = ep.split('/').last;

    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          color: colorScheme.surfaceVariant,
        ),
        height: 80,
        width: 80,
        child: Center(
          child: Text(
            name,
            style: textTheme.bodyLarge!.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
