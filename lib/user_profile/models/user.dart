class User{
  late String? id;
  final String deviceId;
  final String name;
  final String fbProfile;

  User({this.id, required this.deviceId, required this.name, required this.fbProfile});

  factory User.fromJson(String id, Map<String, dynamic> doc){
    return User(
      id: id, 
      deviceId: doc['device_id'] as String, 
      name: doc['name'] as String, 
      fbProfile: doc['fb_profile'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'name' : name,
      'device_id' : deviceId,
      'fb_profile' : fbProfile
    };
  }
}