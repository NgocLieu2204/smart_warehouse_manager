import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Lấy trạng thái đăng nhập của user
  Stream<User?> get user => _auth.authStateChanges();

  // Đăng nhập bằng Email & Password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      // In token sau khi đăng nhập thành công
      if (user != null) {
        String? token = await user.getIdToken();
        print('User Token: $token');
      }

      return user;
    } catch (e) {
      print('Login Error: ${e.toString()}');
      return null;
    }
  }

  // Đăng ký bằng Email & Password
  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print('Register Error: ${e.toString()}');
      return null;
    }
  }

  // Đăng xuất
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
