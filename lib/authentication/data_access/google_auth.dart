import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nation_job_connect/authentication/models/user_credentials.dart';
import 'package:nation_job_connect/user_profile/models/njc_user.dart';

import '/authentication/data_access/idata_access_auth.dart';

class GoogleAuth extends IDataAccessAuth{
  @override
  Future<UserCredentials?> signIn() async{
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      var googleUserCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      var googleCredential = googleUserCredential.credential;
      var user = googleUserCredential.user;
      NJCUser? njcUser;
      UserCredentials? userCredentials;

      if (user != null) {
        njcUser = NJCUser(uId: user.uid, name: user.displayName, email: user.email, 
        phoneNo: user.phoneNumber, photoUrl: user.photoURL, isCurrentMember: false);
      }
      //Fill UserCredentials object using google credentials.....
      if (googleCredential !=null) {
        
        userCredentials = UserCredentials(
            googleCredential.accessToken!, 
            googleCredential.providerId, 
            njcUser
        );
      }
      
      return userCredentials;
      

      // return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      // TODO
      print('exception->$e');
    }
    return null;
  }

  @override
  Future<bool> signOut() async{
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
  
}