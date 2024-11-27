import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kues/listvew_with_filters/domain/entity/character.dart';
import 'package:kues/listvew_with_filters/domain/usecase/get_all_characters.dart';
import 'package:kues/listvew_with_filters/presentation/shared/character_list_item.dart';
import 'package:kues/listvew_with_filters/presentation/shared/character_list_item_loading.dart';
import 'package:kues/listvew_with_filters/presentation/using_bloc/cart_page/data/cart_repo.dart';
import 'package:kues/listvew_with_filters/presentation/using_bloc/cart_page/view/cart_view.dart';
import 'package:kues/listvew_with_filters/presentation/using_bloc/details_page/bloc/character_details_bloc.dart';
import 'package:kues/listvew_with_filters/presentation/using_bloc/details_page/bloc/quantity_cubit.dart';
import 'package:kues/listvew_with_filters/presentation/using_bloc/details_page/view/character_details_page.dart';
import 'package:kues/listvew_with_filters/presentation/using_bloc/list_page/bloc/character_page_bloc.dart';

// -----------------------------------------------------------------------------
// Page
// -----------------------------------------------------------------------------
class CharacterPage extends StatelessWidget {
  const CharacterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharacterPageBloc(
        getAllCharacters: context.read<GetAllCharacters>(),
      )..add(const FetchNextPageEvent()),
      child: const CharacterView(),
    );
  }
}

// -----------------------------------------------------------------------------
// View
// -----------------------------------------------------------------------------
class CharacterView extends StatelessWidget {
  const CharacterView({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((CharacterPageBloc b) => b.state.status);
    return status == CharacterPageStatus.initial
        ? const Center(child: CircularProgressIndicator())
        : const _Content();
  }
}

// -----------------------------------------------------------------------------
// Content
// -----------------------------------------------------------------------------
class _Content extends StatefulWidget {
  const _Content({super.key});

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  final _scrollController = ScrollController();

  CharacterPageBloc get pageBloc => context.read<CharacterPageBloc>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext ctx) {
    final list = ctx.select((CharacterPageBloc b) => b.state.characters);
    final hasEnded = ctx.select((CharacterPageBloc b) => b.state.hasReachedEnd);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize:
        const Size.fromHeight(50.0), // here the desired height
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              // Handle menu button press
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CartPage()),
              );
            },
          ),
          centerTitle: true,
          title: Container(
            padding:
            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(32),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "100a Ealing Rd",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  "•",
                  style: TextStyle(
                      color: Colors.white, fontSize: 14),
                ),
                SizedBox(width: 8),
                Text(
                  "24 mins",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {
                // Handle search button press
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: ListView.builder(
          key: const ValueKey('character_page_list_key'),
          controller: _scrollController,
          itemCount: hasEnded ? list.length : list.length + 1,
          itemBuilder: (context, index) {
            if (index >= list.length) {
              return !hasEnded
                  ? const CharacterListItemLoading()
                  : const SizedBox();
            }
            final item = list[index];
            return index == 0
                ? Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 24, right: 16,top: 8, bottom: 8),
                  alignment: Alignment.topLeft,
                  child: Text('Hits Of the Week', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20),),
                ),

                CarouselSlider(
                  options: CarouselOptions(
                      onPageChanged: (value, _) {
                        setState(() {
                          _currentIndex = value;
                        });
                      },
                      viewportFraction: 1,
                      enlargeCenterPage: false, height: 300),
                  items: list
                      .take(4)
                      .map((item) => Container(
                    color: Colors.white,
                    child: Center(
                      child: Container(
                        height: 300,
                        width: 400,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: const LinearGradient(
                            colors: [Colors.white, Colors.white],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: buildCarouselSliderStack(item),
                      ),
                    ),
                  ),)
                      .toList(),
                ),
                buildCarouselIndicator(),

                /*const CharacterListItemHeader(titleText: 'All Characters'),*/
                const SizedBox(
                  height: 16,
                ),
            Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: CharacterListItem(item: item, onTap: _goToDetails),
            ),
              ],
            )
                : Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: CharacterListItem(item: item, onTap: _goToDetails),
            );
          },
        ),
      ),
    );
  }

  Widget buildCarouselSliderStack(Character item) {
   return Stack(
      children: [
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(24),
              height: 260,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(16),
                gradient: LinearGradient(
                    colors: [
                      const Color(0xFF87C6FE),
                      const Color(0xFFCBCAFF),
                    ],
                    begin:
                    const FractionalOffset(
                        0.0, 0.0),
                    end: const FractionalOffset(
                        1.0, 1.0),
                    stops: [0.0, 0.9],
                    tileMode: TileMode.clamp),
              ),
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
                children: [
                  Text(
                    item.name ?? '',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets
                        .symmetric(
                        horizontal: 12,
                        vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius:
                      BorderRadius.circular(
                          32),
                    ),
                    child: const Text(
                      '\$12.40',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 180.0,
              height: 180.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: new CachedNetworkImageProvider(
                      item.image ?? 'https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCarouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for(int i = 0; i < 4; i++)
          AnimatedContainer(
              width: MediaQuery.sizeOf(context).width / 5,
              height: 4,
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
                color: _currentIndex == i ? Colors.black : Colors.black12,
              ), duration: const Duration(milliseconds: 400),
            ),
      ],
    );

  }

  final cartRepository = CartRepository();

  void _goToDetails(Character character) {
    /* CartItem temp = CartItem(id: '1', name: 'name', price: 10, quantity: 1);
    context.read<CartBloc>().add(AddToCart(temp));
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => CartBloc(_getAllCartItem),
        child: CartPage(),
      ),
      backgroundColor: Colors.transparent,
    );*/
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => FractionallySizedBox(
          heightFactor: 0.9,
          child: MultiBlocProvider(
            providers: [
              /*BlocProvider(
                    create: (context) =>  context.read<CartBloc>(),
                  ),*/
              BlocProvider(
                create: (context) => CharacterDetailsBloc(character: character),
              ),
              BlocProvider(
                create: (context) => QuantityCubit(),
              ),
            ],
            child: CharacterDetailsPage(),
          )),
      backgroundColor: Colors.transparent,
    );
    /*final route = CharacterDetailsPage.route(character: character);
    Navigator.of(context).push(route);*/
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      pageBloc.add(const FetchNextPageEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
