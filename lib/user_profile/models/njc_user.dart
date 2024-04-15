class NJCUser{
  late String? id;
  final String uId;
  final String? name;
  final String? email;
  final String? phoneNo;
  final String? photoUrl;
  String? fbProfile;
  String? memberShipNo;
  String? nation;
  bool isCurrentMember;

  NJCUser({required this.uId, this.email, this.phoneNo, this.photoUrl, this.id,  this.name, this.fbProfile, 
  this.memberShipNo, this.nation, required this.isCurrentMember});

  factory NJCUser.fromJson(Map<String, dynamic> doc){
    return NJCUser(
      id: doc['id'] as String, 
      email: doc['email'] != null? doc['email'] as String: null,
      phoneNo: doc['phone_no']!= null ? doc['phone_no'] as String : null,
      photoUrl: doc['photo_url'] !=null? doc['photo_url'] as String : null,
      name: doc['name'] as String, 
      fbProfile: doc['fb_profile']!=null? doc['fb_profile'] as String : null,
      // memberShipNo: doc['nation_membership_no']!=null? doc['nation_membership_no'] as String : null,
      // nation: doc['nation'] !=null ? doc['nation'] as String : null,
      isCurrentMember: doc['is_current_member'] as bool,
      uId: doc['u_id'] as String);
  }

  factory NJCUser.fromFBJson(String id, Map<String, dynamic> doc){
    return NJCUser(
      id: id, 
      email: doc['email'] != null? doc['email'] as String: null,
      phoneNo: doc['phone_no']!= null ? doc['phone_no'] as String : null,
      photoUrl: doc['photo_url'] !=null? doc['photo_url'] as String : null,
      name: doc['name'] as String, 
      fbProfile: doc['fb_profile']!=null? doc['fb_profile'] as String : null,
      memberShipNo: doc['nation_membership_no']!=null? doc['nation_membership_no'] as String : null,
      nation: doc['nation'] !=null ? doc['nation'] as String : null,
      isCurrentMember: doc['is_current_member'] as bool,
      uId: doc['u_id'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name' : name,
      'email' : email,
      'phone_no' : phoneNo,
      'photo_url' : photoUrl,
      'u_id' : uId,
      'fb_profile' : fbProfile,
      'nation_membership_no' : memberShipNo,
      'nation' : nation,
      'is_current_member' : isCurrentMember
    };
  }
}