import 'user_repository.dart';
import '../user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<void> authenticate() async {
    try {
      await _firebaseAuth.signInAnonymously();
    } catch (err, stack) {
      print("in repo");
      print(err.code);
      throw err;
    }
  }

  @override
  Future<String> getUserId() async {
    final user = await _firebaseAuth.currentUser();
    return user.uid;
  }

  @override
  Future<bool> isAuthenticated() async {
    return (await _firebaseAuth.currentUser()) != null;
  }
}
