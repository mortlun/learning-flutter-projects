class Group {
  String id;
  String name;

  Group(this.id, this.name);

  Group.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];

  Group.fromSnapshot(String id, Map<String, dynamic> json)
      : id = id,
        name = json["name"];

  Map<String, dynamic> toJson() => {"name": this.name};
}
