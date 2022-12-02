import 'package:onmyoji_wiki/models/skill.dart';

enum ShikiType { n, r, sr, ssr, sp }

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
    List<String> tempLevelUp = [];
    for (int i = 2; i < 10; i++) {
      if (json["level$i"] != null) {
        tempLevelUp.add(json['level$i']);
      } else {
        break;
      }
    }
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
  final String id;
  final String name;
  final List<Skill> skills;
  final Stat stat;
  final ShikiType type;

  Shiki({
    required this.id,
    required this.name,
    required this.skills,
    required this.stat,
    required this.type,
  });

  static List<Skill> getListSkill(List<Map<String, dynamic>> json) {
    List<Skill> result = [];
    for (var element in json) {
      // result.add(Skill.fromJson(element));
    }
    return result;
  }

  factory Shiki.fromJson(
      Map<String, dynamic> jsonShiki, Map<String, dynamic> jsonSkill) {
    return Shiki(
      id: jsonShiki["id"],
      name: jsonShiki["name"],
      skills: getListSkill(jsonShiki['skills']),
      stat: Stat.fromJson(jsonShiki['stat']),
      type: ShikiType.values.byName(jsonShiki["type"]),
    );
  }
}
