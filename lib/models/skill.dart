enum SkillType {
  normal("Đánh thường", 1),
  passive("Nội tại", 2),
  active("Chủ động", 3);

  final String toVietNamString;
  final int fromJson;
  const SkillType(this.toVietNamString, this.fromJson);
}

class Note {
  final String name;
  final String describe;

  Note({required this.name, required this.describe});
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(name: json["name"], describe: json["describe"]);
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
  final String image;

  Skill(
      {required this.id,
      required this.name,
      required this.describe,
      required this.cost,
      required this.type,
      required this.image,
      this.bonusId,
      this.levelUp = const [],
      this.note = const [],
      this.cooldown = 0});

  factory Skill.fromJson(Map<String, dynamic> json) {
    List<String> tempLevelUp = [];
    List<Note> note = [];
    if (json["SkillLevelUp"].isNotEmpty) {
      for (int i = 0; i < json["SkillLevelUp"].length; i++) {
        tempLevelUp.add(json["SkillLevelUp"][i]["content"]);
      }
    }

    if (json['LinkSkillAndNote'] != null) {
      for (int i = 0; i< json["LinkSkillAndNote"].length; i++) {
        note.add(Note.fromJson(json["LinkSkillAndNote"][i]["SkillNote"]));
      }
    }
    return Skill(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      describe: json['describe'],
      levelUp: tempLevelUp,
      cost: json['cost'],
      bonusId: json['bonus'],
      cooldown: json['cooldown'],
      type: SkillType.values.firstWhere((element) => element.fromJson == json['type']),
      note: note,
    );
  }
}
