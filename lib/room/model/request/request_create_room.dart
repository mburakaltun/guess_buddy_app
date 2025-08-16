class RequestCreateRoom {
  final String title;

  RequestCreateRoom({
    required this.title,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
    };
  }
}