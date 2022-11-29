enum ShikiType { n, ssn, r, sr, ssr, sp }

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

class Skill {
  final String name;
  final int cost;
  final int cooldown;
  final String describe;
  final List<String>? levelUp;
  final Skill? bonus;

  Skill(
      {required this.name,
      required this.describe,
      required this.cost,
      this.bonus,
      this.levelUp,
      this.cooldown = 0});

  factory Skill.fromJson(Map<String, dynamic> json) {
    List<String> tempLevelUp = [];
    Skill? bonus;
    for (int i = 2; i < 10; i++) {
      if (json["level$i"] != null) {
        tempLevelUp.add(json['level$i']);
      } else {
        break;
      }
    }
    if (json["bonus"] != null) {
      bonus = Skill.fromJson(json["bonus"]);
    }
    return Skill(
        name: json['name'],
        describe: json['describe'],
        levelUp: tempLevelUp,
        cost: json['cost'],
        bonus: bonus,
        cooldown: json['cooldown']);
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

  static List<Skill> getListSkill(Map<String, dynamic> json) {
    List<Skill> result = [];
    for (int i = 1; i < 10; i++) {
      if (json["skill$i"] != null) {
        result.add(Skill.fromJson(json["skill$i"]));
      } else {
        break;
      }
    }
    return result;
  }
}
