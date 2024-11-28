import 'package:flutter/foundation.dart';
import 'package:kues/listvew_with_filters/data/dto/character_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

const cachedCharacterListKey = 'CACHED_CHARACTER_LIST_PAGE';

abstract class LocalStorage {
  Future<bool> saveCharactersPage({
    required int page,
    required List<CharacterDto> list,
  });

  List<CharacterDto> loadCharactersPage({required int page});
}

class LocalStorageImpl implements LocalStorage {
  final SharedPreferences _sharedPref;

  LocalStorageImpl({
    required SharedPreferences sharedPreferences,
  }) : _sharedPref = sharedPreferences;

  @override
  List<CharacterDto> loadCharactersPage({required int page}) {
    final key = getKeyToPage(page);
    final jsonList = _sharedPref.getStringList(key);
    List<CharacterDto>? test = [];
    test.add(new CharacterDto(
      id: 1,
      name: 'Poke with chicken and corn',
      desc: 'Fresh and crisp vegetable medley bursting with vibrant flavors. Tossed with a light dressing for the perfect balance. A wholesome delight for your healthy cravings!',
      kcal: '800',
      grams: '400',
      proteins: '300',
      fats: '50',
      carb: '50',
      cost: '62.00',
      image: 'https://jzgmnvzpovllorpsichi.supabase.co/storage/v1/object/public/images/test_images/Food-Plate.png',
      quantity: 1
    ));
    test.add(new CharacterDto(
        id: 5,
        name: 'Vegetable salad',
        desc: 'Fresh and crisp vegetable medley bursting with vibrant flavors. Tossed with a light dressing for the perfect balance. A wholesome delight for your healthy cravings!',
        kcal: '231',
        grams: '100',
        proteins: '30',
        fats: '10',
        carb: '10',
        cost: '43.00',
        image: 'https://jzgmnvzpovllorpsichi.supabase.co/storage/v1/object/public/images/test_images/Salad2.png',
        quantity: 1
    ));
    test.add(new CharacterDto(
        id: 3,
        name: 'Indian Chutney',
        desc: 'Fresh and crisp vegetable medley bursting with vibrant flavors. Tossed with a light dressing for the perfect balance. A wholesome delight for your healthy cravings!',
        kcal: '185',
        grams: '50',
        proteins: '5',
        fats: '10',
        carb: '35',
        cost: '42.00',
        image: 'https://jzgmnvzpovllorpsichi.supabase.co/storage/v1/object/public/images/test_images/Indian-Chutney.png',
        quantity: 1
    ));
    test.add(new CharacterDto(
        id: 4,
        name: 'Pizza Tuscan Sun Delight',
        desc: 'Indulge in the perfect harmony of gooey cheese, rich tomato sauce, and golden, crispy crust. Topped with the freshest ingredients for an irresistible burst of flavor. A slice of heaven in every bite!',
        kcal: '923',
        grams: '300',
        proteins: '20',
        fats: '250',
        carb: '100',
        cost: '35.00',
        image: 'https://jzgmnvzpovllorpsichi.supabase.co/storage/v1/object/public/images/test_images/Pizza.png',
        quantity: 1
    ));
    test.add(new CharacterDto(
        id: 2,
        name: 'Grilled Chicken',
        desc: 'Savor the smoky perfection of tender, juicy grilled chicken, seared to golden excellence. Infused with a blend of herbs and spices for a mouthwatering flavor. A protein-packed delight that’s both healthy and delicious!',
        kcal: '600',
        grams: '400',
        proteins: '250',
        fats: '40',
        carb: '110',
        cost: '36.00',
        image: 'https://jzgmnvzpovllorpsichi.supabase.co/storage/v1/object/public/images/test_images/Grilled-Chicken.png',
        quantity: 1
    ));
    return test ?? [];
  }

  @override
  Future<bool> saveCharactersPage({
    required int page,
    required List<CharacterDto> list,
  }) {
    final jsonList = list.map((e) => e.toRawJson()).toList();
    final key = getKeyToPage(page);
    return _sharedPref.setStringList(key, jsonList);
  }

  @visibleForTesting
  static String getKeyToPage(int page) {
    return '${cachedCharacterListKey}_$page';
  }
}
