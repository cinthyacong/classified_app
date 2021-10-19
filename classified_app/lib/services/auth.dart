import 'package:get/get.dart';

class Auth extends GetxController {
  var token = "".obs;

  get() {
    print(token);
    return token;
  }

  set(input) {
    token = input.obs;
    print(token);
    return token;
  }
}
