class RequestChangeUsername {
  final String newUsername;

  RequestChangeUsername({required this.newUsername});

  Map<String, dynamic> toJson() {
    return {
      'newUsername': newUsername,
    };
  }
}