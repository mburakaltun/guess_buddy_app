import 'package:flutter/material.dart';
import 'package:guess_buddy_app/common/extension/localization_extension.dart';
import 'package:guess_buddy_app/common/utility/language_utility.dart';

import '../../main.dart';
import '../model/request/request_sign_in_user.dart';
import '../../common/model/exception/api_exception.dart';
import '../service/authentication_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isLoading = false;
  String _selectedLang = 'en';

  final AuthenticationService authenticationService = AuthenticationService();

  @override
  void initState() {
    super.initState();
    _loadLanguage();
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
        Navigator.pushReplacementNamed(context, '/dashboard');
      } on ApiException catch (e) {
        if (!mounted) return;
        _showErrorDialog(e.errorMessage);
      } catch (e) {
        if (!mounted) return;
        _showErrorDialog(context.message.generalError);
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
        title: Text(context.message.signInFailed),
        content: Text(message),
        actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(context.message.ok))],
      ),
    );
  }

  Widget _languageDropdown() {
    return Align(
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
      appBar: AppBar(title: Text(context.message.signIn)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _languageDropdown(),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(labelText: context.message.signInEmail, prefixIcon: Icon(Icons.email), border: OutlineInputBorder()),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return context.message.signInEmailHint;
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value!.trim(),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(labelText: context.message.signInPassword, prefixIcon: Icon(Icons.lock), border: OutlineInputBorder()),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return context.message.signInPasswordHint;
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value!,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _signIn,
                    child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : Text(context.message.signIn),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signup');
                  },
                  child: Text(context.message.signInDontHaveAccount),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}