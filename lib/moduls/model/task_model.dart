class TaskModel {
  String id;
  String title;
  String description;
  int date;
  bool isDone;
  String userId;

  TaskModel(
      {this.id = "",
      required this.title,
      required this.description,
      required this.date,
      this.isDone = false,
      required this.userId});
  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          title: json["title"],
          description: json["description"],
          date: json["date"],
          isDone: json["isDone"],
          userId: json['userId'],
        );
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "date": date,
      "isDone": isDone,
      "userId": userId,
    };
  }
}
