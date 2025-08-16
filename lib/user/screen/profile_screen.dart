import 'package:flutter/material.dart';
import 'package:guess_buddy_app/room/model/request/request_close_room.dart';
import 'package:guess_buddy_app/user/screen/edit_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:guess_buddy_app/authentication/screen/sign_in_screen.dart';
import 'package:guess_buddy_app/common/model/shared_preferences/shared_preferences_key.dart';
import 'package:guess_buddy_app/user/service/user_service.dart';
import 'package:guess_buddy_app/user/model/request/request_get_user_profile.dart';
import 'package:guess_buddy_app/user/model/response/response_get_user_profile.dart';
import 'package:guess_buddy_app/common/extension/localization_extension.dart';

import '../../common/constants/routes.dart';
import '../../common/utility/dialog_utility.dart';
import '../../room/model/request/request_get_user_rooms.dart';
import '../../room/model/request/request_leave_room.dart';
import '../../room/model/response/response_get_user_rooms.dart';
import '../../room/service/room_service.dart';
import 'blocked_users_screen.dart';
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
  final _roomService = RoomService();
  bool isHost = false;
  String roomTitle = "";
  int roomId = 0;

  @override
  void initState() {
    super.initState();
    _loadProfile();
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isHost = prefs.getString(SharedPreferencesKey.isHost) == "true";
      roomTitle = prefs.getString(SharedPreferencesKey.roomTitle) ?? "";
      roomId = int.tryParse(prefs.getString(SharedPreferencesKey.roomId) ?? "0") ?? 0;
    });
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

  // Exit Room (Temporary Leave)
  void _showExitRoomDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.message.profileExitRoomDialogTitle),
        content: Text(context.message.profileExitRoomDialogContent(roomTitle)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.message.profileExitRoomDialogCancel)
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _exitRoom();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
            child: Text(context.message.profileExitRoomDialogConfirm),
          ),
        ],
      ),
    );
  }

  Future<void> _exitRoom() async {
    try {
      setState(() => isLoading = true);

      await _roomService.exitRoom();

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, Routes.roomSelection);
    } catch (e) {
      if (!mounted) return;

      setState(() => isLoading = false);

      DialogUtility.handleApiError(context: context, error: e, title: context.message.profileExitRoomFailed);
    }
  }

  void _showPermanentLeaveRoomDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.message.profileLeaveRoomPermanentlyDialogTitle),
        content: Text(context.message.profileLeaveRoomPermanentlyDialogContent(roomTitle)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.message.profileLeaveRoomPermanentlyDialogCancel)
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showPermanentLeaveRoomConfirmationDialog();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
            child: Text(context.message.profileLeaveRoomPermanentlyDialogProceed),
          ),
        ],
      ),
    );
  }

  void _showPermanentLeaveRoomConfirmationDialog() {
    final TextEditingController controller = TextEditingController();
    final confirmationPhrase = context.message.profileLeaveRoomPermanentlyConfirmationPhrase;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.message.profileLeaveRoomPermanentlyConfirmationTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.message.profileLeaveRoomPermanentlyConfirmationContent),
            const SizedBox(height: 8),
            Text(context.message.profileLeaveRoomPermanentlyConfirmationInstruction(confirmationPhrase), style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), hintText: confirmationPhrase),
              maxLines: 1,
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.message.profileLeaveRoomPermanentlyDialogCancel)
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim() == confirmationPhrase) {
                Navigator.pop(context);
                _leaveRoomPermanently();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(context.message.profileLeaveRoomPermanentlyConfirmationError), backgroundColor: Colors.redAccent)
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
            child: Text(context.message.profileLeaveRoomPermanentlyConfirmationSubmit),
          ),
        ],
      ),
    );
  }

  Future<void> _leaveRoomPermanently() async {
    try {
      setState(() => isLoading = true);

      RequestLeaveRoom requestLeaveRoom = RequestLeaveRoom(roomId: roomId);
      await _roomService.leaveRoom(requestLeaveRoom: requestLeaveRoom);

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, Routes.roomSelection);
    } catch (e) {
      if (!mounted) return;

      setState(() => isLoading = false);

      DialogUtility.handleApiError(context: context, error: e, title: context.message.profileLeaveRoomPermanentlyFailed);
    }
  }

  void _showCloseRoomDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
        title: Text(context.message.profileCloseRoomDialogTitle),
        content: Text(context.message.profileCloseRoomDialogContent(roomTitle)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(context.message.profileCloseRoomDialogCancel)),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showCloseRoomConfirmationDialog();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
            child: Text(context.message.profileCloseRoomDialogProceed),
          ),
        ],
      ),
    );
  }

  void _showCloseRoomConfirmationDialog() {
    final TextEditingController controller = TextEditingController();
    final confirmationPhrase = context.message.profileCloseRoomConfirmationPhrase;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
        title: Text(context.message.profileCloseRoomConfirmationTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.message.profileCloseRoomConfirmationContent),
            const SizedBox(height: 8),
            Text(context.message.profileCloseRoomConfirmationInstruction(confirmationPhrase), style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), hintText: confirmationPhrase),
              maxLines: 1,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(context.message.profileCloseRoomDialogCancel)),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim() == confirmationPhrase) {
                Navigator.pop(context);
                _closeRoom();
              } else {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(context.message.profileCloseRoomConfirmationError), backgroundColor: Colors.redAccent));
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
            child: Text(context.message.profileCloseRoomConfirmationSubmit),
          ),
        ],
      ),
    );
  }

  Future<void> _closeRoom() async {
    try {
      setState(() => isLoading = true);

      RequestCloseRoom requestCloseRoom = RequestCloseRoom(roomId: roomId);
      await _roomService.closeRoom(requestCloseRoom: requestCloseRoom);

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, Routes.roomSelection);
    } catch (e) {
      if (!mounted) return;

      setState(() => isLoading = false);

      DialogUtility.handleApiError(context: context, error: e, title: context.message.profileCloseRoomFailed);
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
                      _loadProfile();
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
                  icon: Icons.block,
                  title: context.message.profileBlockedUsers,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const BlockedUsersScreen()));
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
                  icon: Icons.exit_to_app,
                  title: context.message.profileExitRoom,
                  iconColor: Colors.orange,
                  textColor: Colors.orange,
                  onTap: _showExitRoomDialog,
                ),
                _buildMenuItem(
                  icon: Icons.delete_sweep,
                  title: context.message.profileLeaveRoomPermanently,
                  iconColor: Colors.redAccent,
                  textColor: Colors.redAccent,
                  onTap: _showPermanentLeaveRoomDialog,
                ),
                if (isHost)
                  _buildMenuItem(
                    icon: Icons.close,
                    title: context.message.profileCloseRoom,
                    iconColor: Colors.redAccent,
                    textColor: Colors.redAccent,
                    onTap: _showCloseRoomDialog,
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