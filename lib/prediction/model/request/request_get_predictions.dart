class RequestGetPredictions {
  final int page;
  final int size;

  RequestGetPredictions({
    required this.page,
    required this.size,
  }) : assert(page >= 0, 'Page must be greater than or equal to 0'),
        assert(size >= 1, 'Size must be greater than or equal to 1');

  factory RequestGetPredictions.fromJson(Map<String, dynamic> json) {
    return RequestGetPredictions(
      page: json['page'] as int,
      size: json['size'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'size': size,
    };
  }
}