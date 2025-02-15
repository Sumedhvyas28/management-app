import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:management/auth/login_screen.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: _logout,
          icon: const Icon(Icons.logout, color: Colors.white),
          label: const Text('Logout', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
      ),
    );
  }
}
