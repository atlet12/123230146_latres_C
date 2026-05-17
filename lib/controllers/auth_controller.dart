import 'package:get/get.dart';
import '../services/storage_service.dart';

class AuthController extends GetxController {
  final StorageService _storageService = StorageService();

  var username = ''.obs;
  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    final savedUsername = await _storageService.getUsername();
    if (savedUsername != null && savedUsername.isNotEmpty) {
      username(savedUsername);
      isLoggedIn(true);
    }
  }

  void login(String inputUsername, String password) async {
    if (password.isEmpty) {
      Get.snackbar('Error', 'Password cannot be empty');
      return;
    }

    username(inputUsername);
    await _storageService.saveUsername(inputUsername);
    isLoggedIn(true);
    Get.offAllNamed('/home');
  }

  void logout() async {
    await _storageService.logout();
    username('');
    isLoggedIn(false);
    Get.offAllNamed('/login');
  }
}
