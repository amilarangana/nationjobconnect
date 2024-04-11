import '../../user_profile/models/njc_user.dart';

class UserCredentials{
  final String accessToken;
  final String idToken;
   NJCUser? user;

  UserCredentials(this.accessToken, this.idToken, this.user);

  factory UserCredentials.fromJson(Map<String, dynamic> map){
    return UserCredentials(
      map['access_token'] as String, 
      map['id_token'] as String,
      NJCUser.fromJson(map['user']));
  }

  Map<String, dynamic> toJson(){
    return {
      'access_token' : accessToken,
      'id_token' : idToken,
      'user':user
    };
  }
    
}