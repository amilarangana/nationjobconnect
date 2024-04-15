import 'package:flutter/material.dart';
import 'package:nation_job_connect/authentication/data_access/google_auth.dart';
import 'package:nation_job_connect/authentication/data_access/idata_access_auth.dart';
import 'package:nation_job_connect/authentication/models/user_credentials.dart';
import 'package:nation_job_connect/authentication/store_credentials/auth_shared_prefs.dart';
import '../../authentication/screens/signin_screen.dart';
import '/firebase/firestore_user.dart';
import '/base/base_screen.dart';
import '/base/basic_screen.dart';

class ProfileScreen extends BaseScreen {
  static const routeName = '/signin_screen';
  
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _MyShiftScreenState();
}

class _MyShiftScreenState extends BaseState<ProfileScreen> with BasicScreen {


  final _dbConnectUser = FirestoreUser();
  final _authShredPrefs = AuthSharedPrefs();

  @override
  void initState() {
    _dbConnectUser.dbConnect();
    super.initState();
  }
  
  @override
  getExtra() {
   
  }
  
  @override
  Widget screenBody(BuildContext context) {
    IDataAccessAuth authProvider = GoogleAuth();
    var savedUserCredentials = _authShredPrefs.retrieveSavedUserCredentials();
  
    return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                savedUserCredentials != null ? Image.network(savedUserCredentials.user!.photoUrl!, width: 80): const Text(''),
                const SizedBox(height: 50),
                savedUserCredentials != null ? Text(savedUserCredentials.user!.name!, style: const TextStyle(fontSize: 20),): const Text(""),
                const SizedBox(height: 50),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
                  child: savedUserCredentials != null ? IconButton(
                    iconSize: 40,
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/ic_google.png', width: 40),
                        const Text("Logout")
                      ]),
                    onPressed: () async {
                      setState(() {
                        authProvider.signOut().then((value) {
                          _authShredPrefs.removeSavedUserCredentials();
                        });
                      });  
                    },
                  ) : IconButton(
                    iconSize: 40,
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/ic_google.png', width: 40),
                        const Text("Sigin with Google")
                      ]),
                    onPressed: () async {
                      
                      Navigator.push(context,MaterialPageRoute(builder: (context) =>  
                      SigninScreen(onSigninSuccess: (userCredentials){
                        setState(() {
                          
                        });
                      })));
                                          
                    },
                    ),
                ),
              ],
            ),
        );
  }
  
  @override
  String screenName() {
    return "Profile";
  }
}

typedef OnSigninSuccess = void Function(UserCredentials userCredentials);