// import 'package:get/get.dart';
// import 'package:uninorte_mobile_class_project/domain/use_case/authUseCase.dart';
// import 'package:loggy/loggy.dart';

// class AuthenticationController extends GetxController {
//   final logged = false.obs;

//   bool get isLogged => logged.value;

//   Future<void> login(email, password) async {
//     final AuthenticationUseCase authentication = Get.find();
//     await authentication.login(email, password);
//     logged.value = true;
//   }

//    Future<bool> signUp(email, password) async {
//     final AuthenticationUseCase authentication = Get.find();
//     logInfo('Controller Sign Up');
//     await authentication.signUp(email, password, 'date', 'school', 'grade');
//     return true;
//   }

//   Future<void> logOut() async {
//     logged.value = false;
//   }
// }