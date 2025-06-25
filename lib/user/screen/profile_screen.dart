import 'package:flutter/material.dart';
import 'package:guess_buddy_app/user/screen/edit_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:guess_buddy_app/authentication/screen/sign_in_screen.dart';
import 'package:guess_buddy_app/common/model/shared_preferences/shared_preferences_key.dart';
import 'package:guess_buddy_app/user/service/user_service.dart';
import 'package:guess_buddy_app/user/model/request/request_get_user_profile.dart';
import 'package:guess_buddy_app/user/model/response/response_get_user_profile.dart';
import 'package:guess_buddy_app/common/extension/localization_extension.dart';

import '../../common/utility/dialog_utility.dart';
import 'change_password_screen.dart';
import 'feedback_screen.dart';
import 'language_selection_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ResponseGetUserProfile? profile;
  bool isLoading = true;
  String? error;
  final _userService = UserService();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() {
      isLoading = true;
      error = null;
    });
    try {
      final userService = UserService();
      final result = await userService.getUserProfile(RequestGetUserProfile());
      setState(() {
        profile = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = context.message.profileLoadFailed;
        isLoading = false;
      });
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPreferencesKey.userId);

    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const SignInPage()), (Route<dynamic> route) => false);
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(context.message.profileSignOutDialogTitle),
            content: Text(context.message.profileSignOutDialogContent),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: Text(context.message.profileSignOutDialogCancel)),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _logout();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
                child: Text(context.message.profileSignOutDialogConfirm),
              ),
            ],
          ),
    );
  }

  Widget _buildMenuItem({required IconData icon, required String title, Color? iconColor, Color? textColor, VoidCallback? onTap}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: iconColor ?? Theme.of(context).primaryColor),
        title: Text(title, style: TextStyle(fontSize: 16, color: textColor, fontWeight: textColor != null ? FontWeight.bold : FontWeight.normal)),
        trailing: const Icon(Icons.chevron_right, size: 22),
        onTap: onTap,
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.redAccent.withOpacity(0.8)),
          const SizedBox(height: 16),
          Text(error!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _loadProfile,
            icon: const Icon(Icons.refresh),
            label: Text(context.message.generalTryAgain),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(context.message.profileDeleteAccountDialogTitle),
            content: Text(context.message.profileDeleteAccountDialogContent),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: Text(context.message.profileDeleteAccountDialogCancel)),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showDeleteAccountConfirmationDialog();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
                child: Text(context.message.profileDeleteAccountDialogProceed),
              ),
            ],
          ),
    );
  }

  void _showDeleteAccountConfirmationDialog() {
    final TextEditingController controller = TextEditingController();
    final confirmationPhrase = context.message.profileDeleteAccountConfirmationPhrase;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(context.message.profileDeleteAccountConfirmationTitle),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(context.message.profileDeleteAccountConfirmationContent),
                const SizedBox(height: 8),
                Text(context.message.profileDeleteAccountConfirmationInstruction(confirmationPhrase), style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextField(
                  controller: controller,
                  decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), hintText: confirmationPhrase),
                  maxLines: 1,
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: Text(context.message.profileDeleteAccountDialogCancel)),
              ElevatedButton(
                onPressed: () {
                  if (controller.text.trim() == confirmationPhrase) {
                    Navigator.pop(context);
                    _deleteAccount();
                  } else {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(context.message.profileDeleteAccountConfirmationError), backgroundColor: Colors.redAccent));
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
                child: Text(context.message.profileDeleteAccountConfirmationSubmit),
              ),
            ],
          ),
    );
  }

  Future<void> _deleteAccount() async {
    try {
      setState(() {
        isLoading = true;
      });

      await _userService.deleteUser();

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(SharedPreferencesKey.userId);

      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const SignInPage()), (Route<dynamic> route) => false);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      DialogUtility.handleApiError(context: context, error: e, title: context.message.profileDeleteAccountFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : error != null
              ? _buildErrorState()
              : Column(
                children: [
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      children: [
                        _buildMenuItem(
                          icon: Icons.edit,
                          title: context.message.profileEdit,
                          onTap: () async {
                            final updated = await Navigator.push<bool>(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
                            if (updated == true) {
                              _loadProfile(); // Reload profile if updated
                            }
                          },
                        ),
                        _buildMenuItem(
                          icon: Icons.lock,
                          title: context.message.profileChangePassword,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen()));
                          },
                        ),
                        _buildMenuItem(
                          icon: Icons.feedback,
                          title: context.message.profileFeedback,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const FeedbackScreen()));
                          },
                        ),
                        _buildMenuItem(
                          icon: Icons.language,
                          title: context.message.profileLanguage,
                          onTap: () async {
                            await Navigator.push<String>(context, MaterialPageRoute(builder: (context) => const LanguageSelectionScreen()));
                          },
                        ),
                        const SizedBox(height: 8),
                        const Divider(indent: 16, endIndent: 16),
                        const SizedBox(height: 8),
                        _buildMenuItem(
                          icon: Icons.delete_forever,
                          title: context.message.profileDeleteAccount,
                          iconColor: Colors.redAccent,
                          textColor: Colors.redAccent,
                          onTap: _showDeleteAccountDialog,
                        ),
                        const SizedBox(height: 8),
                        const Divider(indent: 16, endIndent: 16),
                        const SizedBox(height: 8),
                        _buildMenuItem(
                          icon: Icons.logout,
                          title: context.message.profileSignOut,
                          iconColor: Colors.redAccent,
                          textColor: Colors.redAccent,
                          onTap: _showLogoutDialog,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
