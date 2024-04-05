class ShiftType{
  final String id;
  final String type;

  ShiftType({required this.id, required this.type});

  factory ShiftType.fromJson(String id, Map<String, dynamic> doc){
    return ShiftType(id: id, type: doc['name']);
  }

  factory ShiftType.fromShortJson(Map<String, dynamic> doc){
    return ShiftType(id: doc['id'], type: doc['name']);
  }

  Map<String, dynamic> toJson(){
    return{
      'id' : id,
      'name' : type
    };
  }
}