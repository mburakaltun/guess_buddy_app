import 'package:flutter/material.dart';
import 'package:guess_buddy_app/user/screen/edit_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:guess_buddy_app/authentication/screen/sign_in_screen.dart';
import 'package:guess_buddy_app/common/model/shared_preferences/shared_preferences_key.dart';
import 'package:guess_buddy_app/user/service/user_service.dart';
import 'package:guess_buddy_app/user/model/request/request_get_user_profile.dart';
import 'package:guess_buddy_app/user/model/response/response_get_user_profile.dart';
import 'package:guess_buddy_app/common/extension/localization_extension.dart';

import 'change_password_screen.dart';
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



  // Update the _buildMenuItem section in ProfileScreen
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
                            final updated = await Navigator.push<bool>(context, MaterialPageRoute(builder: (context) => EditProfileScreen(profile: profile!)));
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
                        _buildMenuItem(icon: Icons.settings, title: context.message.profileSettings, onTap: () {}),
                        _buildMenuItem(icon: Icons.info_outline, title: context.message.profileAbout, onTap: () {}),
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
