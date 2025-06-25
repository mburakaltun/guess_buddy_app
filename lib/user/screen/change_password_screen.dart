import 'package:flutter/material.dart';
import 'package:guess_buddy_app/common/extension/localization_extension.dart';

import '../../common/utility/dialog_utility.dart';
import '../model/request/request_change_password.dart';
import '../service/user_service.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _userService = UserService();

  bool _isLoading = false;
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _changePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final request = RequestChangePassword(
        currentPassword: _currentPasswordController.text,
        newPassword: _newPasswordController.text,
        confirmNewPassword: _confirmPasswordController.text,
      );

      await _userService.changePassword(request);

      if (!mounted) return;
      await DialogUtility.showSuccessDialog(
        context: context,
        title: context.message.passwordChangeSuccessTitle,
        message: context.message.passwordChangeSuccessMessage,
        onDismiss: () => Navigator.pop(context),
      );
    } catch (e) {
      if (!mounted) return;
      DialogUtility.handleApiError(context: context, error: e, title: context.message.passwordChangeError);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          context.message.passwordChangeTitle,
          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.titleLarge?.color),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, color: Theme.of(context).primaryColor),
            onPressed: () {
              // Show password requirements or help dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(context.message.passwordChangeTitle),
                  content: Text(context.message.passwordChangeNewTooShort),
                  actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))],
                ),
              );
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Security icon
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 32),
              child: Icon(Icons.security, size: 70, color: Theme.of(context).primaryColor.withOpacity(0.7)),
            ),

            // Current password field
            TextFormField(
              controller: _currentPasswordController,
              obscureText: _obscureCurrentPassword,
              decoration: InputDecoration(
                labelText: context.message.passwordChangeCurrent,
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(_obscureCurrentPassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _obscureCurrentPassword = !_obscureCurrentPassword;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.message.passwordChangeCurrentRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // New password field
            TextFormField(
              controller: _newPasswordController,
              obscureText: _obscureNewPassword,
              decoration: InputDecoration(
                labelText: context.message.passwordChangeNew,
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(_obscureNewPassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _obscureNewPassword = !_obscureNewPassword;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.message.passwordChangeNewRequired;
                }
                if (value.length < 8) {
                  return context.message.passwordChangeNewTooShort;
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Confirm password field
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: _obscureConfirmPassword,
              decoration: InputDecoration(
                labelText: context.message.passwordChangeConfirm,
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.message.passwordChangeConfirmRequired;
                }
                if (value != _newPasswordController.text) {
                  return context.message.passwordChangeConfirmMismatch;
                }
                return null;
              },
            ),
            const SizedBox(height: 32),

            // Submit button
            ElevatedButton(
              onPressed: _isLoading ? null : _changePassword,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: _isLoading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : Text(context.message.passwordChangeSubmit),
            ),
          ],
        ),
      ),
    );
  }
}
