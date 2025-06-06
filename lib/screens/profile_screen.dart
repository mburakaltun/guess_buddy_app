import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:guess_buddy_app/authentication/screen/sign_in_screen.dart'; // Assuming this is your sign-in screen path
import 'package:guess_buddy_app/common/model/shared_preferences/shared_preferences_key.dart'; // Assuming this defines your SharedPreferencesKey

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPreferencesKey.userId);

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const SignInPage()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Profil Ekranı',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _logout,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Çıkış Yap',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}