import 'package:flutter/material.dart';

class SignUpSuccessScreen extends StatelessWidget {
  const SignUpSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_outline,
                size: 100,
                color: Colors.tealAccent,
              ),
              const SizedBox(height: 24),
              const Text(
                'Sign Up Successful!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.tealAccent,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Your account has been created successfully. You can now sign in.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Sign In page
                  Navigator.pushReplacementNamed(context, '/signin');
                },
                child: const Text('Go to Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
