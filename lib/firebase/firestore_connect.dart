import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nation_job_connect/vacant_shifts/data_access/idata_access.dart';
import 'package:nation_job_connect/vacant_shifts/models/vacant_shift.dart';

class FirebaseConnect implements iDataAccess{

  late FirebaseFirestore db;

  @override
  void dbConnect() {
    db = FirebaseFirestore.instance;
  }

  @override
  Stream<List<VacantShift>> getVacancies() {
    return db.collection("vacant_shifts")
    .withConverter<VacantShift>(
      fromFirestore: (snapshot, options){
        return VacantShift.fromJson(snapshot.id, snapshot.data()!);
    }, 
      toFirestore: (value, options){
        return value.toJson();
    })
    .snapshots()
    . map((query) => query.docs.map((snapshot) => snapshot.data()).toList());
  
  }

  @override
  void sendApplication() {
    // TODO: implement sendApplication
  }

}