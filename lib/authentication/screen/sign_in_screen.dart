import 'package:flutter/material.dart';
import 'package:guess_buddy_app/common/constants/routes.dart';
import 'package:guess_buddy_app/common/extension/localization_extension.dart';
import 'package:guess_buddy_app/common/utility/language_utility.dart';

import '../../common/utility/dialog_utility.dart';
import '../../main.dart';
import '../model/request/request_sign_in_user.dart';
import '../service/authentication_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _email = '';
  String _password = '';
  bool _isLoading = false;
  bool _obscurePassword = true;
  String _selectedLang = 'en';

  final AuthenticationService authenticationService = AuthenticationService();

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadLanguage() async {
    final lang = await LanguageHelper.getLanguage();
    setState(() {
      _selectedLang = lang;
    });
  }

  Future<void> _changeLanguage(String? lang) async {
    if (lang == null) return;
    await LanguageHelper.setLanguage(lang);
    setState(() {
      _selectedLang = lang;
    });
    // Update app locale
    if (context.mounted) {
      GuessBuddyApp.setLocale(context, Locale(lang));
    }
  }

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() => _isLoading = true);

      try {
        await authenticationService.signIn(RequestSignInUser(email: _email, password: _password));

        if (!mounted) return;
        Navigator.pushReplacementNamed(context, Routes.dashboard);
      } catch (e) {
        if (!mounted) return;
        DialogUtility.handleApiError(
          context: context,
          error: e,
          title: context.message.signInFailed,
        );
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  Widget _languageDropdown() {
    return Container(
      alignment: Alignment.centerRight,
      child: DropdownButton<String>(
        value: _selectedLang,
        underline: const SizedBox(),
        icon: const Icon(Icons.language),
        items: [
          DropdownMenuItem(value: context.message.languageSelectionEnglishKey, child: Text(context.message.languageSelectionEnglish)),
          DropdownMenuItem(value: context.message.languageSelectionTurkishKey, child: Text(context.message.languageSelectionTurkish)),
        ],
        onChanged: _changeLanguage,
        style: Theme.of(context).textTheme.bodyMedium,
        dropdownColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // App title/logo
                    Text(
                      'Guess Buddy',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // Email field
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: context.message.signInEmail,
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty || !value.contains('@')) {
                          return context.message.signInEmailHint;
                        }
                        return null;
                      },
                      onSaved: (value) => _email = value!.trim(),
                    ),
                    const SizedBox(height: 20),

                    // Password field
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: context.message.signInPassword,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                      ),
                      obscureText: _obscurePassword,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return context.message.signInPasswordHint;
                        }
                        return null;
                      },
                      onSaved: (value) => _password = value!,
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.forgotPassword);
                        },
                        child: Text(
                          context.message.forgotPasswordWithQuestionMark,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Sign In button
                    ElevatedButton(
                      onPressed: _isLoading ? null : _signIn,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                          : Text(
                        context.message.signIn,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Sign up link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.message.signInDontHaveAccount,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, Routes.signUp);
                          },
                          child: Text(
                            context.message.signUp,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    _languageDropdown(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}