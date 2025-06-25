// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get generalError => 'An unexpected error occurred.';

  @override
  String get generalTryAgain => 'Please try again.';

  @override
  String get signIn => 'Sign In';

  @override
  String get signInEmail => 'Email';

  @override
  String get signInEmailHint => 'Please enter a valid email.';

  @override
  String get signInPassword => 'Password';

  @override
  String get signInPasswordHint => 'Password must be at least 6 characters.';

  @override
  String get signInFailed => 'Sign In Failed';

  @override
  String get signInDontHaveAccount => 'Don\'t have an account?';

  @override
  String get signUp => 'Sign Up';

  @override
  String get signUpEmail => 'Email';

  @override
  String get signUpEmailHint => 'Please enter a valid email.';

  @override
  String get signUpFailed => 'Sign Up Failed';

  @override
  String get signUpUsername => 'Username';

  @override
  String get signUpUsernameHint =>
      'Username must be between 3 and 32 characters.';

  @override
  String get signUpPassword => 'Password';

  @override
  String get signUpPasswordHint => 'Password must be at least 8 characters.';

  @override
  String get signUpConfirmPassword => 'Confirm Password';

  @override
  String get signUpConfirmPasswordHint => 'Passwords do not match.';

  @override
  String get signUpAlreadyHaveAccount => 'Already have an account?';

  @override
  String get ok => 'OK';

  @override
  String get signUpSuccessTitle => 'Sign Up Successful';

  @override
  String get signUpSuccessMessage =>
      'Your account has been created successfully. You can now sign in.';

  @override
  String get goToSignIn => 'Go to Sign In';

  @override
  String get dashboardHome => 'Home';

  @override
  String get dashboardRanking => 'Rankings';

  @override
  String get dashboardAddPrediction => 'Add';

  @override
  String get dashboardMyPredicts => 'Predicts';

  @override
  String get dashboardProfile => 'Profile';

  @override
  String get addPredictionTitle => 'Title';

  @override
  String get addPredictionTitleHint => 'Enter your prediction title';

  @override
  String get addPredictionDescription => 'Description';

  @override
  String get addPredictionDescriptionHint =>
      'Describe your prediction in detail';

  @override
  String get addPredictionSubmit => 'Submit Prediction';

  @override
  String get addPredictionSuccess => 'Prediction submitted successfully!';

  @override
  String get addPredictionFailed => 'Failed to submit prediction.';

  @override
  String get predictionFeedUserNotFound => 'User information not found.';

  @override
  String get predictionFeedUnexpectedError => 'An unexpected error occurred.';

  @override
  String get predictionFeedNoPredictions => 'No predictions yet.';

  @override
  String predictionFeedVoteCount(Object count) {
    return '$count votes';
  }

  @override
  String get predictionFeedPositive => 'Positive Prediction';

  @override
  String get predictionFeedNegative => 'Negative Prediction';

  @override
  String predictionFeedScore(Object score) {
    return '$score / 5';
  }

  @override
  String get predictionFeedNotVotedYet => 'Not voted yet';

  @override
  String get predictionFeedLoadingPredictions => 'Loading predictions...';

  @override
  String get profileEdit => 'Edit Profile';

  @override
  String get profileSettings => 'Settings';

  @override
  String get profileAbout => 'About';

  @override
  String get profileSignOut => 'Sign Out';

  @override
  String get profileSignOutDialogTitle => 'Sign Out';

  @override
  String get profileSignOutDialogContent =>
      'Are you sure you want to sign out?';

  @override
  String get profileSignOutDialogCancel => 'Cancel';

  @override
  String get profileSignOutDialogConfirm => 'Sign Out';

  @override
  String get profileLoadFailed => 'Failed to load profile';

  @override
  String get profileLanguage => 'Language';

  @override
  String get profileUsername => 'Username';

  @override
  String get profileUsernameHint => 'Enter your username';

  @override
  String get profileUsernameRequired => 'Username is required';

  @override
  String get profileUsernameTooShort =>
      'Username must be at least 3 characters';

  @override
  String get profileSave => 'Save Changes';

  @override
  String get profileUpdateSuccess => 'Profile updated successfully';

  @override
  String get profileUpdateError => 'Failed to update profile';

  @override
  String get profileEmail => 'Email';

  @override
  String get profileEmailHint => 'Enter your email address';

  @override
  String get profileEmailRequired => 'Email is required';

  @override
  String get profileEmailInvalid => 'Please enter a valid email address';

  @override
  String get profileUpdateSubmit => 'Update Profile';

  @override
  String get profileUpdateFailed => 'Failed to update profile';

  @override
  String get profileChangePassword => 'Change Password';

  @override
  String get profileCurrentPassword => 'Current Password';

  @override
  String get profileCurrentPasswordHint => 'Enter your current password';

  @override
  String get profileCurrentPasswordRequired => 'Current password is required';

  @override
  String get profileNewPassword => 'New Password';

  @override
  String get profileNewPasswordHint => 'Enter your new password';

  @override
  String get profileNewPasswordRequired => 'New password is required';

  @override
  String get profilePasswordTooShort =>
      'Password must be at least 8 characters';

  @override
  String get profileConfirmPassword => 'Confirm Password';

  @override
  String get profileConfirmPasswordHint => 'Confirm your new password';

  @override
  String get profileConfirmPasswordRequired => 'Please confirm your password';

  @override
  String get profilePasswordsDoNotMatch => 'Passwords do not match';

  @override
  String get profilePasswordChangeSubmit => 'Change Password';

  @override
  String get profilePasswordChangeSuccess => 'Password changed successfully';

  @override
  String get profilePasswordChangeFailed => 'Failed to change password';

  @override
  String get profileDeleteAccount => 'Delete Account';

  @override
  String get profileDeleteAccountDialogTitle => 'Delete Account?';

  @override
  String get profileDeleteAccountDialogContent =>
      'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently lost.';

  @override
  String get profileDeleteAccountDialogCancel => 'Cancel';

  @override
  String get profileDeleteAccountDialogProceed => 'Proceed';

  @override
  String get profileDeleteAccountConfirmationTitle => 'Final Confirmation';

  @override
  String get profileDeleteAccountConfirmationContent =>
      'This action is permanent and cannot be reversed. All your data, including profile information and activity history, will be permanently deleted.';

  @override
  String get profileDeleteAccountConfirmationPhrase =>
      'delete my account permanently';

  @override
  String profileDeleteAccountConfirmationInstruction(String phrase) {
    return 'Please type \"$phrase\" to confirm:';
  }

  @override
  String get profileDeleteAccountConfirmationError =>
      'The confirmation text doesn\'t match';

  @override
  String get profileDeleteAccountConfirmationSubmit => 'Delete Account';

  @override
  String get profileDeleteAccountFailed => 'Failed to delete account';

  @override
  String get votePredictionTitle => 'Vote for Prediction';

  @override
  String votePredictionPublished(Object date) {
    return 'Published: $date';
  }

  @override
  String get votePredictionHowMuchAgree => 'How much do you agree?';

  @override
  String get votePredictionSuccess => 'Vote submitted successfully';

  @override
  String get votePredictionFailed => 'Failed to vote';

  @override
  String get votePredictionVoteRecorded => 'Your vote has been recorded.';

  @override
  String get votePredictionVoteInProgress =>
      'Your vote is being processed. Please wait.';

  @override
  String get languageSelectionTitle => 'Language Selection';

  @override
  String get languageSelectionEnglish => 'English';

  @override
  String get languageSelectionEnglishKey => 'en';

  @override
  String get languageSelectionTurkish => 'Turkish';

  @override
  String get languageSelectionTurkishKey => 'tr';

  @override
  String get myPredictionsEmpty => 'You have no predictions yet.';

  @override
  String get myPredictionsCreate => 'Create Prediction';

  @override
  String get myPredictionsLoadingPredictions => 'Loading predictions...';

  @override
  String get usersNoUsersFound => 'No users found.';

  @override
  String get usersLoadingUsers => 'Loading users...';

  @override
  String get usersPredictions => 'Predictions';

  @override
  String get forgotPassword => 'Forgot Password';

  @override
  String get forgotPasswordWithQuestionMark => 'Forgot Password?';

  @override
  String get forgotPasswordTitle => 'Reset Your Password';

  @override
  String get forgotPasswordDescription =>
      'Enter your email address and we\'ll send you a link to reset your password.';

  @override
  String get forgotPasswordEmail => 'Email';

  @override
  String get forgotPasswordEmailHint => 'Please enter a valid email address';

  @override
  String get forgotPasswordSubmit => 'Send Reset Link';

  @override
  String get forgotPasswordFailed => 'Password Reset Failed';

  @override
  String get forgotPasswordResetLinkSent =>
      'If your email exists in our system, a password reset link has been sent.';

  @override
  String get forgotPasswordRemembered => 'Remembered your password?';

  @override
  String get aboutTitle => 'About';

  @override
  String aboutVersion(String version) {
    return 'Version $version';
  }

  @override
  String get aboutDescriptionContent =>
      'Guess Buddy is a social prediction platform where users can make predictions about future events and vote on others\' predictions. Track your accuracy over time and see how you compare to other users.';

  @override
  String get aboutLinks => 'Links';

  @override
  String get aboutPrivacyPolicy => 'Privacy Policy';

  @override
  String get aboutTermsOfService => 'Terms of Service';

  @override
  String get aboutSupport => 'Help & Support';

  @override
  String get aboutVersionUnavailable => 'Unknown';

  @override
  String get aboutDescription => 'About Guess Buddy';

  @override
  String get aboutCopyright => '© 2023-2024 Guess Buddy. All rights reserved.';

  @override
  String get aboutLaunchUrlFailed => 'Couldn\'t open link';

  @override
  String get passwordChangeTitle => 'Change Password';

  @override
  String get passwordChangeCurrent => 'Current Password';

  @override
  String get passwordChangeNew => 'New Password';

  @override
  String get passwordChangeConfirm => 'Confirm New Password';

  @override
  String get passwordChangeCurrentRequired => 'Current password is required';

  @override
  String get passwordChangeNewRequired => 'New password is required';

  @override
  String get passwordChangeNewTooShort =>
      'New password must be at least 8 characters';

  @override
  String get passwordChangeConfirmRequired =>
      'Please confirm your new password';

  @override
  String get passwordChangeConfirmMismatch => 'Passwords don\'t match';

  @override
  String get passwordChangeSubmit => 'Change Password';

  @override
  String get passwordChangeSuccess => 'Password changed successfully';

  @override
  String get passwordChangeError => 'Failed to change password';

  @override
  String get passwordChangeRequirements =>
      'Password must be at least 8 characters long.';
}
