import 'dart:convert';

import 'package:kues/listvew_with_filters/data/dto/location_dto.dart';
import 'package:kues/listvew_with_filters/domain/entity/character.dart';

class CharacterDto extends Character {
  CharacterDto({
    super.id,
    super.name,
    super.kcal,
    super.carb,
    super.desc,
    super.fats,
    super.grams,
    super.proteins,
    super.cost,
    super.image,
    super.quantity,
  });

  // ---------------------------------------------------------------------------
  // JSON
  // ---------------------------------------------------------------------------
  factory CharacterDto.fromRawJson(String str) =>
      CharacterDto.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

  // ---------------------------------------------------------------------------
  // Maps
  // ---------------------------------------------------------------------------
  factory CharacterDto.fromMap(Map<String, dynamic> json) => CharacterDto(
        id: json['id'],
        name: json['name'],
    kcal: json['kcal'],
    carb: json['carb'],
    desc: json['desc'],
    fats: json['fats'],
    grams: json['grams'],
    proteins: json['proteins'],
    cost: json['cost'],
    image: json['image'],
      quantity: 1,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'kcal': kcal,
        'carb': carb,
        'desc': desc,
        'fats': fats,
        'grams': grams,
        'proteins': proteins,
        'cost': cost,
        'image': image,
        'quantity':  1,
      };
}
