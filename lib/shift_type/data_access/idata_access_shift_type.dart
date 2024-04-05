import '/shift_type/models/shift_type.dart';

abstract class iDataAccessShiftType{
  void dbConnect();
  Future<ShiftType> readShiftType(String shiftId);

}