import 'package:flutter/material.dart';
import '/firebase/firestore_user.dart';
import '../../resources/utils.dart';
import '../../user_profile/models/user.dart';
import '../../resources/colors.dart';
import '../../widgets/common/no_data.dart';
import '../../widgets/common/waiting.dart';
import '/base/base_screen.dart';
import '/base/basic_screen.dart';

class ApplicationsScreen extends BaseScreen {
  static const routeName = '/applications';
  final String shiftId;
  ApplicationsScreen(this.shiftId, {super.key});

  @override
  State<ApplicationsScreen> createState() => _MyShiftScreenState();
}

class _MyShiftScreenState extends BaseState<ApplicationsScreen> with BasicScreen {


  final _dbConnectUser = FirestoreUser();

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
  //Load the device id....
   return FutureBuilder(
      future: Utils.getDeviceId(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshotDeviceId) { 
        var deviceId = snapshotDeviceId.data;
          if (deviceId != null) {

            //Load the user id....
            return FutureBuilder(
              future: _dbConnectUser.readUser(deviceId), 
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshotUser) {
                User? user = snapshotUser.data;
                if (user != null && user.id != null) {

                  return Container();
              }else{
                return const NoData('No My shifts available');
              }
          });
      }else{
        return const NoData('No My shifts available');
      }
    });
    
  }
  
  @override
  String screenName() {
    return "Appliacations";
  }
}