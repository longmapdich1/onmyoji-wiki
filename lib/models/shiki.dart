enum ShikiType { n, ssn, r, sr, ssr, sp }

class Stat {
  final int attack;
  final int def;
  final int hp;
  final int spd;
  final int effectHit;
  final int effectRes;
  final double crit;
  final double critDame;

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
}

class Skill {
  final String name;
  final String describe;
  final List<String>? levelUp;

  Skill({required this.name, required this.describe, this.levelUp});

  factory Skill.fromJson(Map<String, dynamic> json) {
    List<String> tempLevelUp = [];
    for (int i = 2; i < 10; i++) {
      if (json["level$i"] != null) {
        tempLevelUp.add(json['level$i']);
      } else {
        break;
      }
    }
    return Skill(
      name:  json['name'],
      describe: json['describe'],
      levelUp: tempLevelUp,
    );
  }
}

class Shiki {
  final String id;
  final String name;
  final List<Skill> skills;
  final Stat stat;
  final ShikiType type;
  final List<String> stories;

  Shiki(
      {required this.id,
      required this.name,
      required this.skills,
      required this.stat,
      required this.type,
      required this.stories});
}
