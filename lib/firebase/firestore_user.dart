import 'package:cloud_firestore/cloud_firestore.dart';
import '/user_profile/data_access/idata_access_user.dart';
import '../user_profile/models/njc_user.dart';

class FirestoreUser extends iDataAccessUser{

  late FirebaseFirestore db;

  @override
  void dbConnect() {
    db = FirebaseFirestore.instance;
  }

  @override
  Future<NJCUser?> readUser(String uId) async {
    var querySnapshot = 
      await db.collection("app-users")
              .where('u_id', isEqualTo: uId)
              .get();
      if (querySnapshot.size > 0) {
        return NJCUser.fromFBJson(querySnapshot.docs[0].id, querySnapshot.docs[0].data());
      }else{
        return null;
      }
  }

  @override
  Future<String> saveUser(NJCUser user) {
      return db
        .collection('app-users')
        .add(user.toJson()).then((ref) => ref.id);
  }
}