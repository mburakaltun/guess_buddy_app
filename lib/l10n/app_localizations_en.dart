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
  String get generalCancel => 'Cancel';

  @override
  String get generalDismiss => 'Dismiss';

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
  String get signUpUsernameHint => 'Username must be between 3 and 32 characters.';

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
  String get signUpSuccessMessage => 'Your account has been created successfully. You can now sign in.';

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
  String get addPredictionDescriptionHint => 'Describe your prediction in detail';

  @override
  String get addPredictionSubmit => 'Submit Prediction';

  @override
  String get addPredictionSuccess => 'Prediction submitted successfully!';

  @override
  String get addPredictionFailed => 'Failed to submit prediction.';

  @override
  String get addPredictionPageTitle => 'Add Prediction';

  @override
  String get addPredictionIntro => 'Share your prediction about future events with others and see if you were right!';

  @override
  String get addPredictionTitleRequired => 'Please enter a prediction title';

  @override
  String get addPredictionTitleTooLong => 'Title exceeds maximum length';

  @override
  String get addPredictionDescriptionRequired => 'Please enter a prediction description';

  @override
  String get addPredictionDescriptionTooLong => 'Description exceeds maximum length';

  @override
  String get addPredictionTipsTitle => 'Tips for Good Predictions';

  @override
  String get addPredictionTip1 => 'Be specific about what you\'re predicting';

  @override
  String get addPredictionTip2 => 'Include a timeframe when the prediction can be verified';

  @override
  String get addPredictionTip3 => 'Make sure your prediction is measurable and verifiable';

  @override
  String get addPredictionSubmitting => 'Submitting...';

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
  String get predictionFeedVoteNow => 'Vote Now';

  @override
  String get predictionFeedYourRating => 'Your rating: ';

  @override
  String get predictionFeedChangeRating => 'Change Your Rating';

  @override
  String get predictionFeedRatePrediction => 'Rate This Prediction';

  @override
  String get predictionFeedHowLikely => 'How likely do you think this prediction will come true?';

  @override
  String get predictionFeedNotLikely => 'Not likely';

  @override
  String get predictionFeedVeryLikely => 'Very likely';

  @override
  String get predictionFeedSubmittingVote => 'Submitting your vote...';

  @override
  String get predictionFeedFlagPrediction => 'Flag Prediction';

  @override
  String get predictionFeedBlockUser => 'Block User';

  @override
  String get predictionFeedFlagPredictionDescription => 'Help us keep the community safe by reporting content that violates our guidelines.';

  @override
  String get predictionFeedFlagSelectReason => 'Select a reason:';

  @override
  String get predictionFeedFlagReasonSpam => 'Spam or fake content';

  @override
  String get predictionFeedFlagReasonInappropriate => 'Inappropriate content';

  @override
  String get predictionFeedFlagReasonMisinformation => 'Misinformation';

  @override
  String get predictionFeedFlagReasonHarassment => 'Harassment or bullying';

  @override
  String get predictionFeedFlagReasonOther => 'Other';

  @override
  String get predictionFeedFlagSubmit => 'Submit Report';

  @override
  String get predictionFeedFlagSuccess => 'Prediction flagged successfully';

  @override
  String get predictionFeedFlagFailed => 'Failed to Flag Prediction';

  @override
  String get predictionFeedBlockUserDescription1 => 'Are you sure you want to block ';

  @override
  String get predictionFeedBlockUserDescription2 => '? You won\'t see their predictions or be able to interact with them.';

  @override
  String get predictionFeedBlockConfirm => 'Block User';

  @override
  String predictionFeedBlockSuccess(Object username) {
    return '@$username has been blocked successfully';
  }

  @override
  String get predictionFeedBlockFailed => 'Failed to Block User';

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
  String get profileSignOutDialogContent => 'Are you sure you want to sign out?';

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
  String get profileUsernameTooShort => 'Username must be at least 3 characters';

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
  String get profilePasswordTooShort => 'Password must be at least 8 characters';

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
  String get profileDeleteAccountDialogContent => 'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently lost.';

  @override
  String get profileDeleteAccountDialogCancel => 'Cancel';

  @override
  String get profileDeleteAccountDialogProceed => 'Proceed';

  @override
  String get profileDeleteAccountConfirmationTitle => 'Final Confirmation';

  @override
  String get profileDeleteAccountConfirmationContent => 'This action is permanent and cannot be reversed. All your data, including profile information and activity history, will be permanently deleted.';

  @override
  String get profileDeleteAccountConfirmationPhrase => 'DELETE MY ACCOUNT';

  @override
  String profileDeleteAccountConfirmationInstruction(String phrase) {
    return 'Please type \"$phrase\" to confirm:';
  }

  @override
  String get profileDeleteAccountConfirmationError => 'The confirmation text doesn\'t match';

  @override
  String get profileDeleteAccountConfirmationSubmit => 'Delete Account';

  @override
  String get profileDeleteAccountFailed => 'Failed to delete account';

  @override
  String get profileFeedback => 'Send Feedback';

  @override
  String get feedbackScreenTitle => 'Send Feedback';

  @override
  String get feedbackIntroText => 'We value your feedback! Let us know how we can improve your experience.';

  @override
  String get feedbackTypeLabel => 'Feedback Type';

  @override
  String get feedbackTypeSuggestion => 'Suggestion';

  @override
  String get feedbackTypeBug => 'Bug Report';

  @override
  String get feedbackTypeQuestion => 'Question';

  @override
  String get feedbackTypeOther => 'Other';

  @override
  String get feedbackMessageLabel => 'Your Feedback';

  @override
  String get feedbackMessageHint => 'Please describe your feedback in detail...';

  @override
  String get feedbackMessageRequired => 'Please enter your feedback';

  @override
  String get feedbackMessageTooShort => 'Feedback must be at least 10 characters';

  @override
  String get feedbackSubmitButton => 'Submit Feedback';

  @override
  String get feedbackSuccessTitle => 'Thank You!';

  @override
  String get feedbackSuccessMessage => 'Your feedback has been submitted successfully.';

  @override
  String get feedbackErrorTitle => 'Feedback Error';

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
  String get votePredictionVoteInProgress => 'Your vote is being processed. Please wait.';

  @override
  String get votePredictionSuccessTitle => 'Vote Successful';

  @override
  String get votePredictionSuccessMessage => 'Your vote has been successfully recorded. Thank you for participating!';

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
  String get forgotPasswordDescription => 'Enter your email address and we\'ll send you a link to reset your password.';

  @override
  String get forgotPasswordEmail => 'Email';

  @override
  String get forgotPasswordEmailHint => 'Please enter a valid email address';

  @override
  String get forgotPasswordSubmit => 'Send Reset Link';

  @override
  String get forgotPasswordFailed => 'Password Reset Failed';

  @override
  String get forgotPasswordResetLinkSent => 'If your email exists in our system, a password reset link has been sent.';

  @override
  String get forgotPasswordRemembered => 'Remembered your password?';

  @override
  String get aboutTitle => 'About';

  @override
  String aboutVersion(String version) {
    return 'Version $version';
  }

  @override
  String get aboutDescriptionContent => 'Guess Buddy is a social prediction platform where users can make predictions about future events and vote on others\' predictions. Track your accuracy over time and see how you compare to other users.';

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
  String get passwordChangeNewTooShort => 'New password must be at least 8 characters';

  @override
  String get passwordChangeConfirmRequired => 'Please confirm your new password';

  @override
  String get passwordChangeConfirmMismatch => 'Passwords don\'t match';

  @override
  String get passwordChangeSubmit => 'Change Password';

  @override
  String get passwordChangeSuccess => 'Password changed successfully';

  @override
  String get passwordChangeError => 'Failed to change password';

  @override
  String get passwordChangeRequirements => 'Password must be at least 8 characters long.';

  @override
  String get passwordChangeSuccessTitle => 'Password Changed Successfully';

  @override
  String get passwordChangeSuccessMessage => 'Your password has been changed successfully. You can now log in with your new password.';

  @override
  String get profileUpdateSuccessTitle => 'Profile Updated Successfully';

  @override
  String get profileUpdateSuccessMessage => 'Your profile has been updated successfully.';

  @override
  String get termsOfUseTitle => 'Terms of Use';

  @override
  String get termsOfUseContentHeader => 'Zero Tolerance Policy';

  @override
  String get termsOfUseContent => 'Guess Buddy has a zero tolerance policy for objectionable content and abusive behavior. This includes but is not limited to:\n\n• Harassment or bullying of other users\n• Hate speech or discriminatory content\n• Sexually explicit or violent material\n• Content that violates privacy or intellectual property rights\n• Spam or misleading information\n\nViolations of these terms may result in content removal, temporary suspension, or permanent banning of your account without prior notice.\n\nBy using Guess Buddy, you agree to abide by these terms and understand the consequences of violating them.';

  @override
  String get privacyPolicyHeader => 'Privacy Policy';

  @override
  String get privacyPolicyContent => 'We collect and process certain personal information to provide and improve our services. Your data is handled securely and in accordance with our privacy practices.';

  @override
  String get closeButton => 'Close';

  @override
  String get termsNotAcceptedTitle => 'Terms Not Accepted';

  @override
  String get termsNotAcceptedMessage => 'You must accept the Terms of Use to continue.';

  @override
  String get termsAgreementText => 'By signing up, you agree to our ';

  @override
  String get termsOfUse => 'Terms of Use';

  @override
  String get profileBlockedUsers => 'Blocked Users';

  @override
  String get blockedUsersTitle => 'Blocked Users';

  @override
  String get blockedUsersEmpty => 'No blocked users';

  @override
  String get blockedUsersEmptyDescription => 'You haven\'t blocked any users yet. Blocked users won\'t be able to interact with you.';

  @override
  String get blockedUsersLoadFailed => 'Failed to load blocked users. Please try again.';

  @override
  String get blockedUsersUnblock => 'Unblock';

  @override
  String get blockedUsersUnblockDialogTitle => 'Unblock User';

  @override
  String blockedUsersUnblockDialogContent(String username) {
    return 'Are you sure you want to unblock $username? They will be able to interact with you again.';
  }

  @override
  String get blockedUsersUnblockSuccess => 'User unblocked successfully';

  @override
  String get blockedUsersUnblockFailed => 'Failed to Unblock User';

  @override
  String blockedUsersBlockedOn(String date) {
    return 'Blocked on $date';
  }

  @override
  String get selectRoom => 'Select Room';

  @override
  String get createRoom => 'Create Room';

  @override
  String get joinRoom => 'Join Room';

  @override
  String get signOut => 'Sign Out';

  @override
  String get roomCreationFailed => 'Room Creation Failed';

  @override
  String get roomJoinFailed => 'Failed to Join Room';

  @override
  String get roomCreatedSuccessfully => 'Room Created!';

  @override
  String get roomPasscodeInfo => 'Your room passcode is:';

  @override
  String get roomPasscodeShareInfo => 'Share this passcode with your friends to let them join your room.';

  @override
  String get continueToRoom => 'Continue to Room';

  @override
  String get createRoomTitle => 'Create New Room';

  @override
  String get createRoomDescription => 'Create a new prediction room and invite your friends to join.';

  @override
  String get roomTitleLabel => 'Room Title';

  @override
  String get roomTitleHint => 'Enter a name for your room';

  @override
  String get roomTitleRequired => 'Please enter a room title';

  @override
  String get roomTitleTooLong => 'Room title cannot exceed 50 characters';

  @override
  String get createRoomButton => 'Create Room';

  @override
  String get joinRoomTitle => 'Join Existing Room';

  @override
  String get joinRoomDescription => 'Enter the 6-digit passcode shared by your friend to join their room.';

  @override
  String get passcodeLabel => 'Room Passcode';

  @override
  String get passcodeHint => 'Enter 6-digit passcode';

  @override
  String get passcodeRequired => 'Please enter the room passcode';

  @override
  String get passcodeInvalid => 'Passcode must be exactly 6 characters';

  @override
  String get joinRoomButton => 'Join Room';

  @override
  String get copyPasscode => 'Copy Passcode';

  @override
  String get passcodeCopied => 'Passcode copied to clipboard';

  @override
  String get sharePasscodeWithFriends => 'Share this passcode with your friends';

  @override
  String get createRoomSubtitle => 'Create a new prediction room and invite your friends';

  @override
  String get roomTitle => 'Room Title';

  @override
  String get roomTitleTooShort => 'Room title must be at least 3 characters';

  @override
  String get joinRoomSubtitle => 'Enter the passcode shared by your friend';

  @override
  String get roomPasscode => 'Room Passcode';

  @override
  String get passcodeInvalidLength => 'Passcode must be exactly 6 characters';

  @override
  String get yourRooms => 'Your Rooms';

  @override
  String get host => 'Host';

  @override
  String get member => 'Member';

  @override
  String get join => 'Join';

  @override
  String get joinByPasscode => 'Join by Passcode';

  @override
  String get failedToLoadUserRooms => 'Failed to load your rooms';

  @override
  String get profileLeaveRoom => 'Leave Room';

  @override
  String get profileCloseRoom => 'Close Room';

  @override
  String get profileLeaveRoomDialogTitle => 'Leave Room';

  @override
  String profileLeaveRoomDialogContent(String roomTitle) {
    return 'Are you sure you want to leave the room \"$roomTitle\"? You will no longer be able to participate in this room.';
  }

  @override
  String get profileLeaveRoomDialogCancel => 'Cancel';

  @override
  String get profileLeaveRoomDialogProceed => 'Leave Room';

  @override
  String get profileLeaveRoomConfirmationTitle => 'Confirm Leave Room';

  @override
  String get profileLeaveRoomConfirmationContent => 'This action cannot be undone. You will permanently leave this room.';

  @override
  String get profileLeaveRoomConfirmationPhrase => 'LEAVE ROOM';

  @override
  String profileLeaveRoomConfirmationInstruction(String phrase) {
    return 'Type \"$phrase\" to confirm:';
  }

  @override
  String get profileLeaveRoomConfirmationError => 'Confirmation text doesn\'t match';

  @override
  String get profileLeaveRoomConfirmationSubmit => 'Leave Room';

  @override
  String get profileLeaveRoomFailed => 'Failed to Leave Room';

  @override
  String get profileCloseRoomDialogTitle => 'Close Room';

  @override
  String profileCloseRoomDialogContent(String roomTitle) {
    return 'Are you sure you want to close the room \"$roomTitle\"? This will permanently delete the room and remove all members.';
  }

  @override
  String get profileCloseRoomDialogCancel => 'Cancel';

  @override
  String get profileCloseRoomDialogProceed => 'Close Room';

  @override
  String get profileCloseRoomConfirmationTitle => 'Confirm Close Room';

  @override
  String get profileCloseRoomConfirmationContent => 'This action cannot be undone. The room will be permanently deleted and all members will be removed.';

  @override
  String get profileCloseRoomConfirmationPhrase => 'CLOSE ROOM';

  @override
  String profileCloseRoomConfirmationInstruction(String phrase) {
    return 'Type \"$phrase\" to confirm:';
  }

  @override
  String get profileCloseRoomConfirmationError => 'Confirmation text doesn\'t match';

  @override
  String get profileCloseRoomConfirmationSubmit => 'Close Room';

  @override
  String get profileCloseRoomFailed => 'Failed to Close Room';

  @override
  String get profileExitRoom => 'Exit Room';

  @override
  String get profileExitRoomDialogTitle => 'Exit Room';

  @override
  String profileExitRoomDialogContent(String roomTitle) {
    return 'Are you sure you want to exit \'$roomTitle\'? You can rejoin anytime and continue where you left off.';
  }

  @override
  String get profileExitRoomDialogCancel => 'Cancel';

  @override
  String get profileExitRoomDialogConfirm => 'Exit Room';

  @override
  String get profileExitRoomFailed => 'Failed to Exit Room';

  @override
  String get profileLeaveRoomPermanently => 'Leave Room Permanently';

  @override
  String get profileLeaveRoomPermanentlyDialogTitle => 'Leave Room Permanently';

  @override
  String profileLeaveRoomPermanentlyDialogContent(String roomTitle) {
    return 'Are you sure you want to permanently leave \'$roomTitle\'? This action will delete all your data from this room and cannot be undone.';
  }

  @override
  String get profileLeaveRoomPermanentlyDialogCancel => 'Cancel';

  @override
  String get profileLeaveRoomPermanentlyDialogProceed => 'Proceed';

  @override
  String get profileLeaveRoomPermanentlyConfirmationTitle => 'Confirm Permanent Leave';

  @override
  String get profileLeaveRoomPermanentlyConfirmationContent => 'This action will permanently delete all your room data and cannot be undone.';

  @override
  String get profileLeaveRoomPermanentlyConfirmationPhrase => 'DELETE MY DATA';

  @override
  String profileLeaveRoomPermanentlyConfirmationInstruction(String phrase) {
    return 'Type \'$phrase\' to confirm:';
  }

  @override
  String get profileLeaveRoomPermanentlyConfirmationError => 'Please type the exact phrase to confirm';

  @override
  String get profileLeaveRoomPermanentlyConfirmationSubmit => 'Delete Data';

  @override
  String get profileLeaveRoomPermanentlyFailed => 'Failed to Leave Room Permanently';
}
