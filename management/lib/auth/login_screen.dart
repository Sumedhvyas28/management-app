import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:management/home/dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;
  bool isLoading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void toggleAuthMode() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  Future<void> handleAuth() async {
    setState(() {
      isLoading = true;
    });

    try {
      if (isLogin) {
        await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        showSnackbar("Login Successful!", Colors.green);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
      } else {
        await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        showSnackbar("Account Created Successfully!", Colors.green);
      }
    } on FirebaseAuthException catch (e) {
      showSnackbar(e.message ?? "Something went wrong!", Colors.red);
      print(e.message);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 50),
              ),
              const SizedBox(height: 20),

              Text(
                isLogin ? 'Welcome Back!' : 'Create an Account',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Email Field
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),

              // Password Field
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),

              // Login/Signup Button
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : handleAuth, // Disable button when loading
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.blueAccent)
                    : Text(isLogin ? 'Log In' : 'Sign Up'),
              ),
              const SizedBox(height: 20),

              // OR Divider
              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('or continue with'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),

              // Social Login Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _socialButton(Icons.facebook, Colors.blue),
                  _socialButton(Icons.g_translate, Colors.red),
                  _socialButton(Icons.apple, Colors.black),
                ],
              ),
              const SizedBox(height: 20),

              // Toggle Login/Signup
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(isLogin
                      ? "Don't have an account?"
                      : "Already have an account?"),
                  TextButton(
                    onPressed: toggleAuthMode,
                    child: Text(isLogin ? 'Sign Up' : 'Log In'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for Social Login Buttons
  Widget _socialButton(IconData icon, Color color) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 25,
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon, color: Colors.white),
      ),
    );
  }
}
