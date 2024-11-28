import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kues/listvew_with_filters/domain/entity/character.dart';

typedef OnCharacterListItemTap = void Function(Character character);

class CharacterListItem extends StatelessWidget {
  const CharacterListItem({
    super.key,
    required this.item,
    this.onTap,
  });

  final Character item;
  final OnCharacterListItemTap? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(item),
      child: Card(
        margin: const EdgeInsets.all(16),
        elevation: 0,
        color: Colors.transparent,
        child: SizedBox(
          height: 124,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _ItemPhoto(item: item),
              _ItemDescription(item: item),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Helpers
// -----------------------------------------------------------------------------

class _ItemDescription extends StatelessWidget {
  const _ItemDescription({super.key, required this.item});

  final Character item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 8),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            color: Colors.white
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  item.name ?? '',
                  style: textTheme.bodyMedium!.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      height: 35,
                      padding:  const EdgeInsets.only(left: 16, right: 16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:  Text(
                        '\$  ${item.cost ?? ''}',
                        style: textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${item.kcal ?? ''} Kcal',
                      style: textTheme.labelLarge!.copyWith(
                        color: Colors.black26,
                      ),
                    ),
                  ],
                )

                // const SizedBox(height: 4),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemPhoto extends StatelessWidget {
  const _ItemPhoto({super.key, required this.item});

  final Character item;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      child: SizedBox(
        height: 122,
        child: Hero(
          tag: item.id!,
          child: CachedNetworkImage(
            height: 122,
            width: 122,
            imageUrl: item.image!,
            fit: BoxFit.cover,
            errorWidget: (ctx, url, err) => const Icon(Icons.error),
            placeholder: (ctx, url) => const Icon(Icons.image),
          ),
        ),
      ),
    );
  }
}
