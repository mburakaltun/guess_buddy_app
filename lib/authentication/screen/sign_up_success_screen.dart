import 'package:flutter/material.dart';
import 'package:guess_buddy_app/common/constants/routes.dart';
import 'package:guess_buddy_app/common/extension/localization_extension.dart';

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
              const Icon(Icons.check_circle_outline, size: 100, color: Colors.tealAccent),
              const SizedBox(height: 24),
              Text(context.message.signUpSuccessTitle, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.tealAccent)),
              const SizedBox(height: 16),
              Text(context.message.signUpSuccessMessage, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: Colors.white70)),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.signIn);
                },
                child: Text(context.message.goToSignIn),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
