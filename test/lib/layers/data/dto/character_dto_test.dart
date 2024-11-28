import 'package:kues/listvew_with_filters/data/dto/character_dto.dart';
import 'package:kues/listvew_with_filters/data/dto/location_dto.dart';
import 'package:test/test.dart';

void main() {
  group('CharacterDto', () {
    late String referenceRawJson;
    late CharacterDto referenceDto;

    setUp(() {
      referenceDto = CharacterDto(
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
      );

      referenceRawJson = referenceDto.toRawJson();
    });

    test('should create CharacterDto instance to/from JSON', () {
      final createdDto = CharacterDto.fromRawJson(referenceRawJson);
      final json = createdDto.toRawJson();
      expect(createdDto, referenceDto);
      expect(json, referenceRawJson);
    });
  });
}
