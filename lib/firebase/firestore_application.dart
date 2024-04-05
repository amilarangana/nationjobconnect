import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nation_job_connect/manage_application/data_access/idata_access_application.dart';
import 'package:nation_job_connect/manage_application/models/application.dart';

class FirestoreApplication extends iDataAccessApplication{

  late FirebaseFirestore db;

  @override
  void dbConnect() {
    db = FirebaseFirestore.instance;
  }

  @override
  Future<void> removeApplication(String userId, String vacancyId, String myApplicationId) {
      db.collection('app-users')
        .doc(userId)
        .collection('applied_shifts')
        .doc(myApplicationId)
        .delete();

     return db
        .collection('vacant_shifts')
        .doc(vacancyId)
        .collection('applications')
        .where('user_id', isEqualTo:  userId)
        .get().then((snapshot) {
          for (var element in snapshot.docs) {
            element.reference.delete();
          }
        });
  }

  @override
  Future<void> sendApplication(Application application) {
     db.collection('app-users')
        .doc(application.userId)
        .collection('applied_shifts')
        .doc()
        .set(application.toUserJson());

    return db
        .collection('vacant_shifts')
        .doc(application.vacancyId)
        .collection('applications')
        .doc()
        .set(application.toNationJson());
  }
  
}