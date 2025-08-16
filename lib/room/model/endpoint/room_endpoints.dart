class RoomEndpoints {
  static const String base = '/rooms';
  static const String create = base;
  static const String join = '$base/join';
  static const String leave = '$base/leave';
  static const String close = '$base/close';
  static const String getUserRooms = '$base/user-rooms';
}