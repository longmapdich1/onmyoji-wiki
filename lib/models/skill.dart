enum SkillType {
  normal("Đánh thường"),
  passive("Nội tại"),
  active("Chủ động");

  final String toVietNamString;
  const SkillType(this.toVietNamString);
}

class Note {
  final int id;
  final String name;
  final String describe;

  Note({required this.id, required this.name, required this.describe});
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(id: json["id"], name: json["name"], describe: json["describe"]);
  }
}

class Skill {
  final int id;
  final String name;
  final int cost;
  final int cooldown;
  final String describe;
  final List<String> levelUp;
  final SkillType type;
  final int? bonusId;
  final List<Note> note;
  final String? image;

  Skill(
      {required this.id,
      required this.name,
      required this.describe,
      required this.cost,
      required this.type,
      this.bonusId,
      this.image,
      this.levelUp = const [],
      this.note = const [],
      this.cooldown = 0});

  factory Skill.fromJson(
      Map<String, dynamic> json, List<Map<String, dynamic>> jsonLevelUp) {
    List<String> tempLevelUp = [];
    List<Note> note = [];
    if (jsonLevelUp.isNotEmpty) {
      for (int i = 2; i < 10; i++) {
        if (json["level$i"] != null) {
          tempLevelUp.add(json['level$i']);
        } else {
          break;
        }
      }
    }

    if (json['SkillNote'] != null) {
      for (var element in json["SkillNote"]) {
        note.add(Note.fromJson(element));
      }
    }
    return Skill(
      id: json['Skill']['id'],
      name: json['Skill']['name'],
      describe: json['Skill']['describe'],
      levelUp: tempLevelUp,
      cost: json['Skill']['cost'],
      bonusId: json['Skill']['bonus'],
      cooldown: json['Skill']['cooldown'],
      type: SkillType.values.byName(json['Skill']['type']),
      note: note,
    );
  }
}
