import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guess_buddy_app/common/constants/routes.dart';
import 'package:guess_buddy_app/common/extension/localization_extension.dart';
import 'package:guess_buddy_app/common/utility/dialog_utility.dart';
import 'package:guess_buddy_app/room/model/request/request_create_room.dart';
import 'package:guess_buddy_app/room/model/request/request_join_room.dart';
import 'package:guess_buddy_app/room/model/request/request_get_user_rooms.dart';
import 'package:guess_buddy_app/room/model/response/response_get_user_rooms.dart';
import 'package:guess_buddy_app/room/service/room_service.dart';

class RoomSelectionScreen extends StatefulWidget {
  const RoomSelectionScreen({super.key});

  @override
  State<RoomSelectionScreen> createState() => _RoomSelectionScreenState();
}

class _RoomSelectionScreenState extends State<RoomSelectionScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _createRoomFormKey = GlobalKey<FormState>();
  final _joinRoomFormKey = GlobalKey<FormState>();
  final _roomTitleController = TextEditingController();
  final _passcodeController = TextEditingController();

  final RoomService _roomService = RoomService();

  bool _isCreatingRoom = false;
  bool _isJoiningRoom = false;
  bool _isLoadingUserRooms = false;
  ResponseGetUserRooms? _userRooms;
  String? _userRoomsError;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadUserRooms();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _roomTitleController.dispose();
    _passcodeController.dispose();
    super.dispose();
  }

  Future<void> _loadUserRooms() async {
    setState(() {
      _isLoadingUserRooms = true;
      _userRoomsError = null;
    });

    try {
      final response = await _roomService.getUserRooms(
        requestGetUserRooms: RequestGetUserRooms(page: 0, size: 20),
      );
      setState(() {
        _userRooms = response;
        _isLoadingUserRooms = false;
      });
    } catch (e) {
      setState(() {
        _userRoomsError = context.message.failedToLoadUserRooms;
        _isLoadingUserRooms = false;
      });
    }
  }

  Future<void> _createRoom() async {
    if (!_createRoomFormKey.currentState!.validate()) return;

    setState(() => _isCreatingRoom = true);

    try {
      final response = await _roomService.createRoom(
        requestCreateRoom: RequestCreateRoom(
          title: _roomTitleController.text.trim(),
        ),
      );

      if (!mounted) return;

      await _showRoomCreatedDialog(response.passcode);

      Navigator.pushReplacementNamed(context, Routes.dashboard);
    } catch (e) {
      if (!mounted) return;
      DialogUtility.handleApiError(
        context: context,
        error: e,
        title: context.message.roomCreationFailed,
      );
    } finally {
      if (mounted) {
        setState(() => _isCreatingRoom = false);
      }
    }
  }

  Future<void> _joinRoomByPasscode() async {
    if (!_joinRoomFormKey.currentState!.validate()) return;

    setState(() => _isJoiningRoom = true);

    try {
      await _roomService.joinRoom(
        requestJoinRoom: RequestJoinRoom(
          passcode: _passcodeController.text.trim(),
        ),
      );

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, Routes.dashboard);
    } catch (e) {
      if (!mounted) return;
      DialogUtility.handleApiError(
        context: context,
        error: e,
        title: context.message.roomJoinFailed,
      );
    } finally {
      if (mounted) {
        setState(() => _isJoiningRoom = false);
      }
    }
  }

  Future<void> _joinRoomById(String passcode) async {
    setState(() => _isJoiningRoom = true);

    try {
      await _roomService.joinRoom(
        requestJoinRoom: RequestJoinRoom(passcode: passcode),
      );

      if (!mounted) return;
      Navigator.pushReplacementNamed(context, Routes.dashboard);
    } catch (e) {
      if (!mounted) return;
      DialogUtility.handleApiError(
        context: context,
        error: e,
        title: context.message.roomJoinFailed,
      );
    } finally {
      if (mounted) {
        setState(() => _isJoiningRoom = false);
      }
    }
  }

  Future<void> _showRoomCreatedDialog(String passcode) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            const SizedBox(width: 8),
            Text(context.message.roomCreatedSuccessfully),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.message.roomPasscodeInfo),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Text(
                    passcode,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: passcode));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(context.message.passcodeCopied),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                        icon: const Icon(Icons.copy),
                        tooltip: context.message.copyPasscode,
                      ),
                      Text(
                        context.message.copyPasscode,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              context.message.sharePasscodeWithFriends,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.message.continueToRoom),
          ),
        ],
      ),
    );
  }

  Widget _buildJoinRoomTab() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.message.joinRoomTitle,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              context.message.joinRoomSubtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Join by Passcode Section
            Form(
              key: _joinRoomFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    context.message.joinByPasscode,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  TextFormField(
                    controller: _passcodeController,
                    decoration: InputDecoration(
                      labelText: context.message.roomPasscode,
                      prefixIcon: const Icon(Icons.vpn_key),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      counterText: '',
                    ),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    maxLength: 6,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return context.message.passcodeRequired;
                      }
                      if (value.trim().length != 6) {
                        return context.message.passcodeInvalidLength;
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) => _joinRoomByPasscode(),
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: _isJoiningRoom ? null : _joinRoomByPasscode,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                    ),
                    child: _isJoiningRoom
                        ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.login),
                        const SizedBox(width: 8),
                        Text(
                          context.message.joinRoom,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),

            // Your Rooms Section - Made flexible to fill remaining space
            if (_isLoadingUserRooms)
              const Center(child: CircularProgressIndicator())
            else if (_userRoomsError != null)
              Column(
                children: [
                  Text(_userRoomsError!, style: TextStyle(color: Colors.red)),
                  TextButton(
                    onPressed: _loadUserRooms,
                    child: Text(context.message.generalTryAgain),
                  ),
                ],
              )
            else if (_userRooms?.userRooms.isNotEmpty == true) ...[
                Text(
                  context.message.yourRooms,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 20), // Add bottom padding
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _userRooms!.userRooms.length,
                      itemBuilder: (context, index) {
                        final room = _userRooms!.userRooms[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: Icon(
                              room.isHost ? Icons.admin_panel_settings : Icons.person,
                              color: room.isHost ? Colors.amber : Colors.grey,
                            ),
                            title: Text(room.roomTitle),
                            subtitle: Text(
                              room.isHost ? context.message.host : context.message.member,
                            ),
                            trailing: ElevatedButton(
                              onPressed: _isJoiningRoom ? null : () => _joinRoomById(room.passcode),
                              child: Text(context.message.join),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
          ],
        ),
      ),
    );
  }

  Widget _buildCreateRoomTab() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _createRoomFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.message.createRoomTitle,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              context.message.createRoomSubtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            TextFormField(
              controller: _roomTitleController,
              decoration: InputDecoration(
                labelText: context.message.roomTitle,
                prefixIcon: const Icon(Icons.meeting_room),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              ),
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return context.message.roomTitleRequired;
                }
                if (value.trim().length < 3) {
                  return context.message.roomTitleTooShort;
                }
                return null;
              },
              onFieldSubmitted: (_) => _createRoom(),
            ),

            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: _isCreatingRoom ? null : _createRoom,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 2,
              ),
              child: _isCreatingRoom
                  ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add),
                  const SizedBox(width: 8),
                  Text(
                    context.message.createRoom,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.message.selectRoom),
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.signIn);
            },
            child: Text(
              context.message.signOut,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: const Icon(Icons.login),
              text: context.message.joinRoom,
            ),
            Tab(
              icon: const Icon(Icons.add),
              text: context.message.createRoom,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildJoinRoomTab(),
          _buildCreateRoomTab(),
        ],
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}