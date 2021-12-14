import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthenticationService {

  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage!;
  var _firebaseAuth= FirebaseAuth.instance;

  Future<UserCredential> login(String email, String password)async {
    return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
  Future<UserCredential> register(String email, String password)async {
    return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  // Future register(String email, String password,String uID) async {
  //   return _firebaseAuth
  //       .createUserWithEmailAndPassword(email: email, password: password)
  //       .then((value) {
  //     print(value.user!.email);
  //     print(value.user!.uid);
  //     uID = value.user!.uid.toString();
  //   }).catchError((error) {
  //     print(error.toString());
  //   });
  //
  // }

  Future logout() async {
    return await _firebaseAuth.signOut();
  }

  Future getUser() async {
    return await _firebaseAuth.currentUser;
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser;
    return currentUser != null;
  }

  void setLoading(val) {
    _isLoading = val;
  }

  void setMessage(String message) {
    _errorMessage = message;
  }

  Stream<User> get user =>
      _firebaseAuth.authStateChanges().map((event) => event!);
}
