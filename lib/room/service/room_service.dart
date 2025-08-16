import 'package:guess_buddy_app/room/model/request/request_close_room.dart';
import 'package:guess_buddy_app/room/model/response/response_close_room.dart';
import 'package:guess_buddy_app/room/model/response/response_leave_room.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/service/api_service.dart';
import '../../common/model/shared_preferences/shared_preferences_key.dart';
import '../model/endpoint/room_endpoints.dart';
import '../model/request/request_create_room.dart';
import '../model/request/request_get_user_rooms.dart';
import '../model/request/request_join_room.dart';
import '../model/request/request_leave_room.dart';
import '../model/response/response_create_room.dart';
import '../model/response/response_get_user_rooms.dart';
import '../model/response/response_join_room.dart';

class RoomService {
  final ApiService _apiService;

  RoomService() : _apiService = ApiService();

  Future<ResponseCreateRoom> createRoom({required RequestCreateRoom requestCreateRoom}) async {
    final response = await _apiService.post(
      endpoint: RoomEndpoints.create,
      body: requestCreateRoom.toJson(),
    );

    final responseCreateRoom = ResponseCreateRoom.fromJson(response!);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPreferencesKey.roomId, responseCreateRoom.roomId.toString());
    await prefs.setString(SharedPreferencesKey.roomTitle, responseCreateRoom.roomTitle);
    await prefs.setString(SharedPreferencesKey.isHost, "true");
    await prefs.setString(SharedPreferencesKey.passcode, responseCreateRoom.passcode);

    return responseCreateRoom;
  }

  Future<ResponseJoinRoom> joinRoom({required RequestJoinRoom requestJoinRoom}) async {
    final response = await _apiService.post(
      endpoint: RoomEndpoints.join,
      body: requestJoinRoom.toJson(),
    );

    final responseJoinRoom = ResponseJoinRoom.fromJson(response!);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPreferencesKey.roomId, responseJoinRoom.roomId.toString());
    await prefs.setString(SharedPreferencesKey.roomTitle, responseJoinRoom.roomTitle);
    await prefs.setString(SharedPreferencesKey.isHost, responseJoinRoom.isHost.toString());
    await prefs.setString(SharedPreferencesKey.passcode, responseJoinRoom.passcode);

    return responseJoinRoom;
  }

  Future<ResponseLeaveRoom> leaveRoom({required RequestLeaveRoom requestLeaveRoom}) async {
    final response = await _apiService.post(
      endpoint: RoomEndpoints.leave,
      body: requestLeaveRoom.toJson(),
    );
    _removeSharedPreferences();

    return ResponseLeaveRoom.fromJson(response!);
  }

  Future<ResponseCloseRoom> closeRoom({required RequestCloseRoom requestCloseRoom}) async {
    final response = await _apiService.post(
      endpoint: RoomEndpoints.close,
      body: requestCloseRoom.toJson(),
    );
    _removeSharedPreferences();

    return ResponseCloseRoom.fromJson(response!);
  }

  Future<ResponseGetUserRooms> getUserRooms({required RequestGetUserRooms requestGetUserRooms}) async {
    final response = await _apiService.get(
      endpoint: RoomEndpoints.getUserRooms,
      params: requestGetUserRooms.toJson(),
    );
    return ResponseGetUserRooms.fromJson(response!);
  }

  Future<void> exitRoom() async {
    _removeSharedPreferences();
  }

  Future<void> _removeSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPreferencesKey.roomId);
    await prefs.remove(SharedPreferencesKey.roomTitle);
    await prefs.remove(SharedPreferencesKey.isHost);
    await prefs.remove(SharedPreferencesKey.passcode);
  }
}