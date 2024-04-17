import 'package:nation_job_connect/nations/models/nation.dart';

abstract class iDataAccessNation{
  void dbConnect();
  Future<Nation> readNationsList(String nationId);
  Future<List<Nation>> getNationsList();
 
}