import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nation_job_connect/my_shifts/data_access/idata_access_my_shifts.dart';
import 'package:nation_job_connect/my_shifts/models/my_application.dart';

class FirestoreMyShifts extends iDataAccessMyShifts{

  late FirebaseFirestore db;
  
  @override
  void dbConnect() {
    db = FirebaseFirestore.instance;
  }

  @override
  Stream<List<MyApplication>> getMyShifts(String userId) {
    return db.collection("app-users")
    .doc(userId)
    .collection("applied_shifts")
    .withConverter<MyApplication>(
      fromFirestore: (snapshot, options){
        return MyApplication.fromJson(snapshot.id, snapshot.data()!);
    }, 
      toFirestore: (value, options){
        return value.toJson();
    })
    .snapshots()
    . map((query) => query.docs.map((snapshot) => snapshot.data()).toList());
  }
   
}