import 'package:nation_job_connect/vacant_shifts/models/vacant_shift.dart';

abstract class iDataAccess{
  void dbConnect();
  void sendApplication();
  Stream<List<VacantShift>> getVacancies();
}