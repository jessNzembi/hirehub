import 'package:get/get.dart';
import 'package:hirehub/utils/local_storage.dart';

class ProfileController extends GetxController {
  final LocalStorageService localStorageService = LocalStorageService();
  RxMap<String, dynamic> userData = RxMap<String, dynamic>();

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() async {
    userData.value = await localStorageService.getUserData();
    update();
  }

  void updateUserData(Map<String, dynamic> newUserData) {
    userData.value = newUserData;
    update();
  }
}
