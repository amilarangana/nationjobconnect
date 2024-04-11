import 'package:nation_job_connect/authentication/data_access/idata_access_auth.dart';
import 'package:nation_job_connect/authentication/models/user_credentials.dart';

class AppleAuth extends IDataAccessAuth{
  @override
  Future<UserCredentials?> signIn() {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<bool> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

}