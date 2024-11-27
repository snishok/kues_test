import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kues/listvew_with_filters/domain/usecase/get_all_characters.dart';
import 'package:kues/listvew_with_filters/domain/usecase/get_all_characters.dart';
import 'package:kues/listvew_with_filters/presentation/using_bloc/list_page/view/character_page.dart';

import 'cart_page/bloc/cart_bloc.dart';
import 'cart_page/data/cart_repo.dart';
import 'list_page/bloc/character_page_bloc.dart';

class AppUsingBloc extends StatelessWidget {
  const AppUsingBloc({super.key, required this.getAllCharacters});

  final GetAllCharacters getAllCharacters;

  @override
  Widget build(BuildContext context) {
    // 1 - Inject all uses cases on the top of the widget's tree
    // 2 - Use them as BLOC/Cubit dependencies as needed
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: getAllCharacters),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartRepository = CartRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartBloc(cartRepository)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CharacterPage(),
      ),
    );
  }
}
