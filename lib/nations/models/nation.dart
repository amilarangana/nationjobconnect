class Nation{
  final String id;
  final String name;
  final String description;

  Nation({required this.id, required this.name, required this.description});

  factory Nation.fromJson(String id, Map<String, dynamic> doc){
    return Nation(id : id,  name: doc['name'] as String, description: doc['description'] as String);
  }

  factory Nation.fromShortJson(Map<String, dynamic> doc){
    return Nation(id : doc['id'] as String,  name: doc['name'] as String, description: "");
  }
  
  Map<String, dynamic> toJson(){
    return {
      'id' : id,
      'name' : name,
      'description' : description
    };
  }

  Map<String, dynamic> toShortJson(){
    return {
      'id' : id,
      'name' : name
      
    };
  }
}