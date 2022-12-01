enum SkillType {
  normal("Đánh thường"),
  passive("Nội tại"),
  active("Chủ động");

  final String toVietNamString;
  const SkillType(this.toVietNamString);
}

class Skill {
  final String name;
  final int cost;
  final int cooldown;
  final String describe;
  final List<String>? levelUp;
  final SkillType type;
  final Skill? bonus;

  Skill(
      {required this.name,
      required this.describe,
      required this.cost,
      required this.type,
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
      cooldown: json['cooldown'],
      type: SkillType.values.byName(json['type']),
    );
  }
}
