import 'package:equatable/equatable.dart';
import 'package:kues/listvew_with_filters/domain/entity/location.dart';

class Character with EquatableMixin {
  Character({
    this.id,
    this.name,
    this.desc,
    this.kcal,
    this.grams,
    this.proteins,
    this.fats,
    this.carb,
    this.cost,
    this.image,
    this.quantity,
  });

  final int? id;
  final String? name;
  final String? desc;
  final String? kcal;
  final String? grams;
  final String? proteins;
  final String? fats;
  final String? carb;
  final String? cost;
  final String? image;
  final int? quantity;

  @override
  List<Object?> get props => [
        id,
        name,
    desc,
    kcal,
    grams,
    proteins,
    fats,
    carb,
    cost,
    image,
        quantity,
      ];


  Character copyWith({int? quantity}) {
    return Character(
      id: id,
      name: name,
      desc: desc,
      kcal: kcal,
      grams: grams,
      proteins: proteins,
      fats: fats,
      carb: carb,
      cost: cost,
      image: image,
      //price: price,
      quantity: quantity ?? this.quantity,
    );
  }
}
