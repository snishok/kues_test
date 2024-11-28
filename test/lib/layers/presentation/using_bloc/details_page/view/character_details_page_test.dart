import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kues/listvew_with_filters/presentation/using_bloc/details_page/bloc/character_details_bloc.dart';
import 'package:kues/listvew_with_filters/presentation/using_bloc/details_page/view/character_details_page.dart';

import '../../../../../../fixtures/fixtures.dart';

void main() {
  testWidgets('CharacterDetailsPage should render correctly',
      (WidgetTester tester) async {
    final character = characterList1.first;

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: CharacterDetailsBloc(character: character),
          child: const CharacterDetailsPage(),
        ),
      ),
    );

    // Find items on the page
    expect(find.text('Details'), findsOneWidget);
    expect(find.text(character.name!), findsOneWidget);
  });
}
