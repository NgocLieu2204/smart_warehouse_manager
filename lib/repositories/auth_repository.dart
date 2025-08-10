import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    Future<String?> login (String email, String password) async {
        try {
            UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                email: email,
                password: password,
            );
            final token = await userCredential.user!.getIdToken();
            if (token == null) {
                throw Exception('Failed to retrieve token');
            }
            return token;
        } catch (e) {
            throw Exception('Login failed: $e');
        }
        
    }
    Future<void> logout() async {
        try {
            await _auth.signOut();
        } catch (e) {
            throw Exception('Logout failed: $e');
        }
    }
    Future<String?> register(String email, String password) async {
        try {
            UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                email: email,
                password: password,
            );
            final token = await userCredential.user!.getIdToken();
            if (token == null) {
                throw Exception('Failed to retrieve token');
            }
            return token;
        } catch (e) {
            throw Exception('Registration failed: $e');
        }
    }
    Future<String?> getCurrentUserToken() async {
    final user = _auth.currentUser;
    if (user != null) {
      return await user.getIdToken();
    }
    return null;
  }
}