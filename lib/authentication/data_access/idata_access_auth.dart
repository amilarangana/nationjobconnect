import 'package:nation_job_connect/authentication/models/user_credentials.dart';

abstract class IDataAccessAuth{
  Future<UserCredentials?> signIn();
  Future<bool> signOut();
}