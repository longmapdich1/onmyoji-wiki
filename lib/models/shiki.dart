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

  Stat(
      {required this.attack,
      required this.def,
      required this.hp,
      required this.spd,
      required this.effectHit,
      required this.effectRes,
      required this.crit, 
      required this.critDame,});
}

class Skill {
  final String name;
  final String describe;

  Skill({required this.name, required this.describe});
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
