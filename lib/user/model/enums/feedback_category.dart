enum FeedbackCategory {
  suggestion('SUGGESTION'),
  bugReport('BUG_REPORT'),
  question('QUESTION'),
  other('OTHER');

  final String value;
  const FeedbackCategory(this.value);

  static FeedbackCategory fromString(String value) {
    return FeedbackCategory.values.firstWhere(
          (category) => category.toString().split('.').last == value,
      orElse: () => FeedbackCategory.other,
    );
  }
}