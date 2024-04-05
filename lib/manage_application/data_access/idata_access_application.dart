import '../models/application.dart';

abstract class iDataAccessApplication {
  void dbConnect();
  void sendApplication(Application application);
  void removeApplication(String userId, String vacancyId, String myApplicationId);
}