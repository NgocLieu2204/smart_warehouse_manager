import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Lấy trạng thái đăng nhập của user (stream realtime)
  Stream<User?> get authState => _auth.authStateChanges();

  /// Đăng nhập bằng Email & Password, trả về UserCredential
  Future<UserCredential> signIn(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Đăng ký tài khoản mới
  Future<UserCredential> register(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Đăng xuất
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  /// Lấy token hiện tại của user (nếu có)
  Future<String?> getIdToken() async {
    final user = _auth.currentUser;
    return user != null ? await user.getIdToken() : null;
  }

  /// Lấy user hiện tại (nếu có)
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
