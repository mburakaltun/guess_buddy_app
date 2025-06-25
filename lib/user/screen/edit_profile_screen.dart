import 'package:flutter/material.dart';
import 'package:guess_buddy_app/common/extension/localization_extension.dart';
import 'package:guess_buddy_app/user/model/response/response_get_user_profile.dart';

import '../../common/utility/dialog_utility.dart';
import '../model/request/request_change_username.dart';
import '../model/request/request_get_user_profile.dart';
import '../service/user_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _userService = UserService();

  bool _isLoading = false;
  bool _isLoadingProfile = true;
  String? _error;
  ResponseGetUserProfile? _profile;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() {
      _isLoadingProfile = true;
      _error = null;
    });

    try {
      RequestGetUserProfile request = RequestGetUserProfile();
      final profile = await _userService.getUserProfile(request);

      setState(() {
        _profile = profile;
        _usernameController.text = profile.username;
        _isLoadingProfile = false;
      });
    } catch (e) {
      setState(() {
        _error = context.message.profileLoadFailed;
        _isLoadingProfile = false;
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final request = RequestChangeUsername(newUsername: _usernameController.text.trim());

      final response = await _userService.changeUsername(request);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.message.profileUpdateSuccess)));
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      DialogUtility.handleApiError(context: context, error: e, title: context.message.profileUpdateError);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.redAccent.withOpacity(0.8)),
          const SizedBox(height: 16),
          Text(_error!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          context.message.profileEdit,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoadingProfile
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? _buildErrorState()
          : Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.teal.withOpacity(0.2),
              child: const Icon(Icons.person, size: 50, color: Colors.teal),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: context.message.profileUsername, prefixIcon: const Icon(Icons.person_outline)),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return context.message.profileUsernameRequired;
                }
                if (value.length < 3) {
                  return context.message.profileUsernameTooShort;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Display email as read-only field
            TextFormField(
              initialValue: _profile?.email,
              readOnly: true,
              enabled: false,
              decoration: InputDecoration(labelText: context.message.profileEmail, prefixIcon: const Icon(Icons.email_outlined)),
            ),
            const SizedBox(height: 32),
            // Save button moved to the form body
            ElevatedButton(
              onPressed: _isLoading ? null : _saveProfile,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: _isLoading
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : Text(context.message.profileSave),
            ),
            const SizedBox(height: 16),
            // Instructions text
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
            ),
          ],
        ),
      ),
    );
  }
}