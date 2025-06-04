class PageableResponse {
  final int? number;
  final int? totalElements;
  final int? totalPages;
  final bool? isLast;

  PageableResponse({
    this.number,
    this.totalElements,
    this.totalPages,
    this.isLast,
  });

  factory PageableResponse.fromJson(Map<String, dynamic> json) {
    return PageableResponse(
      number: json['number'] as int?,
      totalElements: json['totalElements'] as int?,
      totalPages: json['totalPages'] as int?,
      isLast: json['isLast'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'totalElements': totalElements,
      'totalPages': totalPages,
      'isLast': isLast,
    };
  }
}