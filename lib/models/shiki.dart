import 'package:onmyoji_wiki/models/skill.dart';

enum ShikiType {
  n(1),
  r(2),
  sr(3),
  ssr(4),
  sp(5);

  final int fromJson;
  const ShikiType(this.fromJson);
}

class Stat {
  final int attack;
  final int def;
  final int hp;
  final int spd;
  final int effectHit;
  final int effectRes;
  final int crit;
  final int critDame;

  Stat({
    required this.attack,
    required this.def,
    required this.hp,
    required this.spd,
    required this.effectHit,
    required this.effectRes,
    required this.crit,
    required this.critDame,
  });

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      attack: json["attack"],
      def: json["def"],
      hp: json["hp"],
      spd: json["spd"],
      effectHit: json["effectHit"],
      effectRes: json["effectRes"],
      crit: json["crit"],
      critDame: json["critDame"],
    );
  }
}

class Shiki {
  final int id;
  final String name;
  final List<Skill>? skills;
  final Stat? stat;
  final ShikiType type;
  final String? image;

  Shiki({
    required this.id,
    required this.name,
    required this.type,
    this.skills,
    this.stat,
    this.image,
  });

  factory Shiki.fromJson(
      Map<String, dynamic> json, List<Skill> listSkill) {
    return Shiki(
      id: json["id"],
      name: json["name"],
      skills: listSkill,
      stat: Stat.fromJson(json['Stat']),
      type: ShikiType.values.firstWhere((element) => element.fromJson == json['type']),
      image: json["image"],
    );
  }
}
