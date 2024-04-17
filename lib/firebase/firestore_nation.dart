import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nation_job_connect/nations/data_access/idata_access_nation.dart';
import 'package:nation_job_connect/nations/models/nation.dart';

class FirestoreNation extends iDataAccessNation{

  late FirebaseFirestore db;

  @override
  void dbConnect() {
    db = FirebaseFirestore.instance;
  }

  @override
  Future<Nation> readNationsList(String nationId) async{
    var documentSnapshot = await db.collection("nations").doc(nationId).get();
    return Nation.fromJson(documentSnapshot.id, documentSnapshot.data()!=null? documentSnapshot.data()!:{});
  }
  
  @override
  Future<List<Nation>> getNationsList() async{
    
    var querySnapshot = 
    await db.collection("nations")
    .get();

    List<Nation> list = [];
     for (var element in querySnapshot.docs) { 
      list.add(Nation.fromJson(element.id, element.data()));
     }
     return list;
  }
}