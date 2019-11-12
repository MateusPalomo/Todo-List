class Task3 {
  int id;
  String title;
  String description;
  bool isDone;

  Task3({
    this.id,
    this.title,
    this.description,
    this.isDone = false,
  });

  factory Task3.fromMap(Map<String, dynamic> json) => Task3(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isDone: json["isDone"] == 1,
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": id,
      "title": title,
      "description": description,
      "isDone": isDone ? 1 : 0
    };

    if (id != null) map["id"] = id;

    return map;
  }
}
