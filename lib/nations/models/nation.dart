class Nation {
  final String id;
  final String name;
  final String description;
  final String logo;

  @override
  bool operator ==(Object other) => other is Nation && other.name == name;

  @override
  int get hashCode => name.hashCode;

  Nation(
      {required this.id,
      required this.name,
      required this.description,
      required this.logo});

  factory Nation.fromJson(String id, Map<String, dynamic> doc) {
    return Nation(
        id: id,
        name: doc['name'] as String,
        description: doc['description'] as String,
        logo: doc['logo'] as String);
  }

  factory Nation.fromShortJson(Map<String, dynamic> doc) {
    return Nation(
        id: doc['id'] as String,
        name: doc['name'] as String,
        description: "",
        logo: doc['logo'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description, 'logo': logo};
  }

  Map<String, dynamic> toShortJson() {
    return {'id': id, 'name': name, 'logo': logo};
  }
}
