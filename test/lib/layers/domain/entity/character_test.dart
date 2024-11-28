import 'package:kues/listvew_with_filters/domain/entity/character.dart';
import 'package:test/test.dart';

void main() {
  group('Character', () {
    test('Two instances with the same properties should be equal', () {
      final character1 = Character(
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

      final character2 = Character(
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

      expect(character1, equals(character2));
    });

    test('Two instances with different properties should be different', () {
      final character1 = Character(
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

      final character2 = Character(
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

      expect(character1, isNot(equals(character2)));
    });
  });
}
