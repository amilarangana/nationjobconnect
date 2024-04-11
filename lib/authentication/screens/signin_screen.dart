import 'package:flutter/material.dart';
import 'package:nation_job_connect/authentication/data_access/google_auth.dart';
import 'package:nation_job_connect/authentication/data_access/idata_access_auth.dart';
import 'package:nation_job_connect/authentication/models/user_credentials.dart';
import 'package:nation_job_connect/authentication/store_credentials/auth_shared_prefs.dart';
import '../../widgets/common/alert_dialog.dart';
import '../../widgets/vacant_shifts/signin_dialog.dart';
import '/firebase/firestore_user.dart';
import '../../resources/utils.dart';
import '../../user_profile/models/njc_user.dart';
import '../../resources/colors.dart';
import '../../widgets/common/no_data.dart';
import '../../widgets/common/waiting.dart';
import '/base/base_screen.dart';
import '/base/basic_screen.dart';

class SigninScreen extends BaseScreen {
  static const routeName = '/signin_screen';
  OnSigninSuccess onSigninSuccess;
  
  SigninScreen({super.key, required this.onSigninSuccess});

  @override
  State<SigninScreen> createState() => _MyShiftScreenState();
}

class _MyShiftScreenState extends BaseState<SigninScreen> with BasicScreen {


  final _dbConnectUser = FirestoreUser();
  final _authShredPrefs = AuthSharedPrefs();

  @override
  void initState() {
    _dbConnectUser.dbConnect();
    _authShredPrefs.init();
    super.initState();
  }
  
  @override
  getExtra() {
   
  }
  
  @override
  Widget screenBody(BuildContext context) {
    IDataAccessAuth authProvider = GoogleAuth();
  
    return Center(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                iconSize: 40,
                icon: Image.asset('assets/images/ic_google.png', width: 40),
                onPressed: () async {
                  var njcUserCredentials = await authProvider.signIn();
                                      if (njcUserCredentials != null && njcUserCredentials.user !=null) {
                                        print(njcUserCredentials.user!.email);
                                          showDialog(context: context,
                                            builder: (BuildContext contextSignIn) =>
                                                  SigninDialog(
                                                    onValidate:(firstName,fbProfile) async {
                                                      Navigator.of(contextSignIn).pop();
                                                        if (firstName.isEmpty ||fbProfile.isEmpty) {
                                                          return showDialog(context: contextSignIn,
                                                            builder: (contextError) => const CustomAlertDialog(
                                                              'Error', "Please fill the required fields"));
                                                        } else {
                                                          var njcUser = njcUserCredentials.user;
                                                          njcUser!.fbProfile = fbProfile;

                                                          var id = await _dbConnectUser.saveUser(njcUser);
                                                          njcUser.id = id;
                                                          njcUserCredentials.user = njcUser;

                                                          _authShredPrefs.storeUserCredentials(njcUserCredentials);
                                                          
                                                          widget.onSigninSuccess(njcUserCredentials);
                                                          //Only for testing....
                                                          var retrieved = _authShredPrefs.retrieveSavedUserCredentials();
                                                          if (retrieved != null && retrieved.user != null) {
                                                            print(retrieved.user!.name);
                                                          }
                                                        Navigator.of(context).pop();
                                                        }
                                                    }));
                                          
                                        }
                                        // Navigator.of(context).pop();
                                      
                                    },
                                  ),
                        ),
        );
  }
  
  @override
  String screenName() {
    return "Signin";
  }
}

typedef OnSigninSuccess = void Function(UserCredentials userCredentials);