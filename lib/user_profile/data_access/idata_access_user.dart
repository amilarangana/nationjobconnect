import 'package:nation_job_connect/user_profile/models/njc_user.dart';

abstract class iDataAccessUser{
  void dbConnect();
  Future<NJCUser?> readUser(String deviceId);
  Future<String> saveUser(NJCUser user);
  
}