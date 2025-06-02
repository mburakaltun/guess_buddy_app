class ResponseSignUpUser {
  final int id;

  ResponseSignUpUser({required this.id});

  factory ResponseSignUpUser.fromJson(Map<String, dynamic> json) {
    return ResponseSignUpUser(
      id: json['id'],
    );
  }
}
