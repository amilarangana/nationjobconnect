import 'package:cloud_firestore/cloud_firestore.dart';
import '/user_profile/data_access/idata_access_user.dart';
import '/user_profile/models/user.dart';

class FirestoreUser extends iDataAccessUser{

  late FirebaseFirestore db;

  @override
  void dbConnect() {
    db = FirebaseFirestore.instance;
  }

  @override
  Future<User?> readUser(String deviceId) async {
    var querySnapshot = 
      await db.collection("app-users")
              .where('device_id', isEqualTo: deviceId)
              .get();
      if (querySnapshot.size > 0) {
        return User.fromJson(querySnapshot.docs[0].id, querySnapshot.docs[0].data());
      }else{
        return null;
      }
  }

  @override
  Future<String> saveUser(User user) {
      return db
        .collection('app-users')
        .add(user.toJson()).then((ref) => ref.id);
  }
}