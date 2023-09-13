// // import 'package:f_web_authentication/data/datasources/remote/authentication_datasource.dart';

// // import '../../data/datasources/remote/user_datasource.dart';
// import '../models/user.dart';

// class Repository {
//   late AuthenticationDataSource _authenticationDataSource;
//   late UserDataSource _userDataSource;
//   String token = "";

//   Repository() {
//     _authenticationDataSource = AuthenticationDataSource();
//     _userDataSource = UserDataSource();
//   }

//   Future<bool> login(String email, String password) async {
//     token = await _authenticationDataSource.login(email, password);
//     return true;
//   }

//   Future<bool> signUp(String email, String password) async =>
//       await _authenticationDataSource.signUp(email, password);

//   Future<bool> logOut() async => await _authenticationDataSource.logOut();

//   Future<List<User>> getUsers() async => await _userDataSource.getUsers();

//   Future<bool> addUser(User user) async => await _userDataSource.addUser(user);

//   Future<bool> updateUser(User user) async =>
//       await _userDataSource.updateUser(user);

//   Future<bool> deleteUser(int id) async => await _userDataSource.deleteUser(id);

//   Future<bool> simulateProcess() async =>
//       await _userDataSource.simulateProcess(token);
// }
