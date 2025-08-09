import 'package:flutter/material.dart';
import 'package:guess_buddy_app/common/extension/localization_extension.dart';
import 'package:guess_buddy_app/common/utility/dialog_utility.dart';
import 'package:guess_buddy_app/user/model/dto/user_dto.dart';
import 'package:guess_buddy_app/user/model/request/request_unblock_user.dart';
import 'package:guess_buddy_app/user/service/user_service.dart';

import '../model/response/response_get_blocked_users.dart';

class BlockedUsersScreen extends StatefulWidget {
  const BlockedUsersScreen({super.key});

  @override
  State<BlockedUsersScreen> createState() => _BlockedUsersScreenState();
}

class _BlockedUsersScreenState extends State<BlockedUsersScreen> {
  List<UserDto> blockedUsers = [];
  bool isLoading = true;
  String? error;
  final _userService = UserService();

  @override
  void initState() {
    super.initState();
    _loadBlockedUsers();
  }

  Future<void> _loadBlockedUsers() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      ResponseGetBlockedUsers responseGetBlockedUsers = await _userService.getBlockedUsers();
      setState(() {
        blockedUsers = responseGetBlockedUsers.blockedUserDtoList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = context.message.blockedUsersLoadFailed;
        isLoading = false;
      });
    }
  }

  Future<void> _unblockUser(int userId, String username) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.message.blockedUsersUnblockDialogTitle),
        content: Text(context.message.blockedUsersUnblockDialogContent(username)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.message.generalCancel),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _performUnblock(userId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            child: Text(context.message.blockedUsersUnblock),
          ),
        ],
      ),
    );
  }

  Future<void> _performUnblock(int userId) async {
    try {
      RequestUnblockUser request = RequestUnblockUser(unblockedUserId: userId);
      await _userService.unblockUser(request);
      setState(() {
        blockedUsers.removeWhere((user) => user.id == userId);
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.message.blockedUsersUnblockSuccess),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      DialogUtility.handleApiError(
        context: context,
        error: e,
        title: context.message.blockedUsersUnblockFailed,
      );
    }
  }

  Widget _buildBlockedUserItem(UserDto user) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          child: Icon(
            Icons.person,
            color: Theme.of(context).primaryColor,
          ),
        ),
        title: Text(
          user.username,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: OutlinedButton(
          onPressed: () => _unblockUser(user.id, user.username),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Theme.of(context).primaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: Text(
            context.message.blockedUsersUnblock,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.block_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            context.message.blockedUsersEmpty,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.message.blockedUsersEmptyDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.redAccent.withOpacity(0.8),
          ),
          const SizedBox(height: 16),
          Text(
            error!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _loadBlockedUsers,
            icon: const Icon(Icons.refresh),
            label: Text(context.message.generalTryAgain),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
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
        title: Text(context.message.blockedUsersTitle),
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
          ? _buildErrorState()
          : blockedUsers.isEmpty
          ? _buildEmptyState()
          : RefreshIndicator(
        onRefresh: _loadBlockedUsers,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: blockedUsers.length,
          itemBuilder: (context, index) {
            return _buildBlockedUserItem(blockedUsers[index]);
          },
        ),
      ),
    );
  }
}