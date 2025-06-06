import 'package:flutter/material.dart';
import 'package:guess_buddy_app/common/extension/localization_extension.dart';
import '../model/request/request_sign_up_user.dart';
import '../service/authentication_service.dart';
import '../../common/model/exception/api_exception.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String _email = '';
  String _username = '';
  bool _isLoading = false;

  final AuthenticationService authenticationService = AuthenticationService();

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      await authenticationService.signUp(
        RequestSignUpUser(email: _email, username: _username, password: _passwordController.text, confirmPassword: _confirmPasswordController.text),
      );

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/success');
    } on ApiException catch (e) {
      _showErrorDialog(e.errorMessage);
    } catch (e) {
      _showErrorDialog(context.message.generalError);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(context.message.signUpFailed),
            content: Text(message),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(context.message.ok))],
          ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.message.signUp)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: context.message.signUpEmail, prefixIcon: Icon(Icons.email), border: OutlineInputBorder()),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return context.message.signUpEmailHint;
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value!.trim(),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  decoration: InputDecoration(labelText: context.message.signUpUsername, prefixIcon: Icon(Icons.person), border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context.message.signUpUsernameHint;
                    }
                    return null;
                  },
                  onSaved: (value) => _username = value!.trim(),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: context.message.signUpPassword, prefixIcon: Icon(Icons.lock), border: OutlineInputBorder()),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return context.message.signUpPasswordHint;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(labelText: context.message.signUpConfirmPassword, prefixIcon: Icon(Icons.lock_outline), border: OutlineInputBorder()),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value != _passwordController.text) {
                      return context.message.signUpConfirmPasswordHint;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _signUp,
                    child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : Text(context.message.signUp),
                  ),
                ),
                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signin');
                  },
                  child: Text(context.message.signUpAlreadyHaveAccount),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
