import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../blocs/auth/auth_state.dart';
import '../../repositories/auth_repository.dart';
import '../../views/dashboard/dashboard_screen.dart';
import '../../views/auth/register_screen.dart';
// Assuming button.dart is now in lib/widgets/
import '../../widgets/buttton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(AuthRepository()),
      child: Scaffold(
        backgroundColor: const Color(0xFFE0E5EC), // Neumorphism background color
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const DashboardScreen()),
              );
            }
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message ?? 'An error occurred')),
              );
            }
          },
          builder: (context, state) {
            bool isLoading = state is AuthLoading;

            return SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Logo
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/warehouse_logo.png',
                              // *** THAY ĐỔI Ở ĐÂY ***
                              fit: BoxFit.contain, // Đổi từ .cover sang .contain
                              width: 300,
                              height: 300,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Smart Warehouse',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333A44),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Made easy!',
                          style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                        ),
                        const SizedBox(height: 50),

                        // Username/Email Text Field
                        _buildNeumorphicTextField(
                          controller: _emailController,
                          hintText: 'username',
                          icon: Icons.person_outline,
                          validator: (val) => val!.isEmpty ? 'Please enter an email' : null,
                        ),
                        const SizedBox(height: 25),

                        // Password Text Field
                        _buildNeumorphicTextField(
                          controller: _passwordController,
                          hintText: 'password',
                          icon: Icons.lock_outline,
                          obscureText: true,
                          validator: (val) => val!.length < 6
                              ? 'Enter a password 6+ chars long'
                              : null,
                        ),
                        const SizedBox(height: 40),

                        // Login Button
                        if (isLoading)
                          const CircularProgressIndicator()
                        else
                          NeumorphicButton(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      LoginRequested(
                                        username: _emailController.text.trim(),
                                        password: _passwordController.text.trim(),
                                      ),
                                    );
                              }
                            },
                            backgroundColor: const Color(0xFF6D98E1),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        const SizedBox(height: 30),

                        // Footer text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Forgot password? ',
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                            const Text("OR ", style: TextStyle(color: Colors.blueGrey),),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => const RegisterScreen()),
                                );
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF333A44),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Widget builder for Neumorphic Text Fields
  Widget _buildNeumorphicTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE0E5EC),
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(255, 255, 255, 0.9),
            offset: Offset(-5, -5),
            blurRadius: 10,
            spreadRadius: 0,
          ),
           BoxShadow(
            color: Color.fromRGBO(163, 177, 198, 0.9),
            offset: Offset(5, 5),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.blueGrey),
          prefixIcon: Icon(icon, color: Colors.blueGrey, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }
}