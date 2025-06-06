class PageableRequest {
  final int page;
  final int size;

  PageableRequest({
    required this.page,
    required this.size,
  });

  factory PageableRequest.fromJson(Map<String, dynamic> json) {
    return PageableRequest(
      page: json['page'],
      size: json['size'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'size': size,
    };
  }
}
