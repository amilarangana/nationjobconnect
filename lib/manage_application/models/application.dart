import 'package:nation_job_connect/nations/models/nation.dart';
import 'package:nation_job_connect/shift_type/models/shift_type.dart';

class Application{
  final String vacancyId;
  final Nation nation;
  final ShiftType shiftType;
  final double shiftHours;
  final DateTime time;
  final String userId;
  final String userName;
  final String fbLink;
  final String deviceId;

  Application(this.vacancyId, this.nation, this.shiftType, this.shiftHours, 
  this.time, this.userId, this.userName, this.fbLink, this.deviceId );

  Map<String, dynamic> toUserJson() {
    return {
      'vacancy_id' : vacancyId,
      'nation': nation.toShortJson(),
      'time': time,
      'shift_type' : shiftType.toJson(),
      'no_of_hours' : shiftHours,
      'status' : 0
    };
  }

  Map<String, dynamic> toNationJson() {
    return {
      'user_id': userId,
      'device_id': deviceId,
      'fb_profile' : fbLink,
      'name' : userName,
      'status' : 0
    };
  }
}