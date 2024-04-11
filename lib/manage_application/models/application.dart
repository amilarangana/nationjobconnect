import 'package:nation_job_connect/nations/models/nation.dart';
import 'package:nation_job_connect/shift_type/models/shift_type.dart';

class Application{
  final String vacancyId;
  final Nation nation;
  final ShiftType shiftType;
  final DateTime endTime;
  final DateTime time;
  final double wage;
  final String userId;
  final String userName;
  final String fbLink;

  Application(this.vacancyId, this.nation, this.shiftType, this.endTime, this.wage,
  this.time, this.userId, this.userName, this.fbLink );

  Map<String, dynamic> toUserJson() {
    return {
      'vacancy_id' : vacancyId,
      'nation': nation.toShortJson(),
      'time': time,
      'shift_type' : shiftType.toJson(),
      'end_time' : endTime,
      'wage' : wage,
      'status' : 0
    };
  }

  Map<String, dynamic> toNationJson() {
    return {
      'user_id': userId,
      'fb_profile' : fbLink,
      'name' : userName,
      'status' : 0
    };
  }
}