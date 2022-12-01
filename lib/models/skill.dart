enum SkillType {
  normal("Đánh thường"),
  passive("Nội tại"),
  active("Chủ động");

  final String toVietNamString;
  const SkillType(this.toVietNamString);
}

class Note{
  final String name;
  final String describe;

  Note({required this.name, required this.describe});
  factory Note.fromJson(Map<String, dynamic> json){
    return Note(name: json["name"], describe: json["describe"]);
  }
}

class Skill {
  final String name;
  final int cost;
  final int cooldown;
  final String describe;
  final List<String> levelUp;
  final SkillType type;
  final Skill? bonus;
  final List<Note> note;

  Skill(
      {required this.name,
      required this.describe,
      required this.cost,
      required this.type,
      this.bonus,
      this.levelUp = const [],
      this.note = const [],
      this.cooldown = 0});

  factory Skill.fromJson(Map<String, dynamic> json) {
    List<String> tempLevelUp = [];
    List<Note> note = [];
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
    if(json["note"] != null){
      for (var element in json["note"]) {
        note.add(Note.fromJson(element));
      }
    }
    return Skill(
      name: json['name'],
      describe: json['describe'],
      levelUp: tempLevelUp,
      cost: json['cost'],
      bonus: bonus,
      cooldown: json['cooldown'],
      type: SkillType.values.byName(json['type']),
      note: note,
    );
  }
}
