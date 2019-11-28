class Character {
  Character({this.id, this.name, this.description});

  int id;
  String name;
  String description;

  Character.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.description = map['description'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
    };
  }

  @override
  String toString() {
    return 'Grade{id: $id, name: $name, description: $description}';
  }
}