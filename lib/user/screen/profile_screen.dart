import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:guess_buddy_app/authentication/screen/sign_in_screen.dart';
import 'package:guess_buddy_app/common/model/shared_preferences/shared_preferences_key.dart';
import 'package:guess_buddy_app/user/service/user_service.dart';
import 'package:guess_buddy_app/user/model/request/request_get_user_profile.dart';
import 'package:guess_buddy_app/user/model/response/response_get_user_profile.dart';
import 'package:guess_buddy_app/common/extension/localization_extension.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : error != null
                ? Center(child: Text(error!))
                : Column(
                  children: [
                    const SizedBox(height: 32),
                    CircleAvatar(radius: 48, backgroundImage: AssetImage('assets/avatar_placeholder.png')),
                    const SizedBox(height: 16),
                    Text(profile?.username ?? '', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(profile?.email ?? '', style: const TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(height: 24),
                    Expanded(
                      child: ListView(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.edit),
                            title: Text(context.message.profileEdit),
                            onTap: () {
                              // Navigate to edit profile
                            },
                          ),
                          const Divider(height: 0),
                          ListTile(
                            leading: const Icon(Icons.settings),
                            title: Text(context.message.profileSettings),
                            onTap: () {
                              // Navigate to settings
                            },
                          ),
                          const Divider(height: 0),
                          ListTile(
                            leading: const Icon(Icons.info_outline),
                            title: Text(context.message.profileAbout),
                            onTap: () {
                              // Navigate to about
                            },
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 0),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: ListTile(
                        leading: const Icon(Icons.logout, color: Colors.redAccent),
                        title: Text(context.message.profileSignOut, style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                        onTap: _showLogoutDialog,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
