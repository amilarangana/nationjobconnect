import '/my_shifts/models/my_application.dart';

abstract class iDataAccessMyShifts{
  void dbConnect();
  Stream<List<MyApplication>> getMyShifts(String userId);
}