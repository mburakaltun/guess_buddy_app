import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @generalError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred.'**
  String get generalError;

  /// No description provided for @generalTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Please try again.'**
  String get generalTryAgain;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signInEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get signInEmail;

  /// No description provided for @signInEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email.'**
  String get signInEmailHint;

  /// No description provided for @signInPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get signInPassword;

  /// No description provided for @signInPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters.'**
  String get signInPasswordHint;

  /// No description provided for @signInFailed.
  ///
  /// In en, this message translates to:
  /// **'Sign In Failed'**
  String get signInFailed;

  /// No description provided for @signInDontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get signInDontHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signUpEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get signUpEmail;

  /// No description provided for @signUpEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email.'**
  String get signUpEmailHint;

  /// No description provided for @signUpFailed.
  ///
  /// In en, this message translates to:
  /// **'Sign Up Failed'**
  String get signUpFailed;

  /// No description provided for @signUpUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get signUpUsername;

  /// No description provided for @signUpUsernameHint.
  ///
  /// In en, this message translates to:
  /// **'Username must be between 3 and 32 characters.'**
  String get signUpUsernameHint;

  /// No description provided for @signUpPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get signUpPassword;

  /// No description provided for @signUpPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters.'**
  String get signUpPasswordHint;

  /// No description provided for @signUpConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get signUpConfirmPassword;

  /// No description provided for @signUpConfirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get signUpConfirmPasswordHint;

  /// No description provided for @signUpAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get signUpAlreadyHaveAccount;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @signUpSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Up Successful'**
  String get signUpSuccessTitle;

  /// No description provided for @signUpSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your account has been created successfully. You can now sign in.'**
  String get signUpSuccessMessage;

  /// No description provided for @goToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Go to Sign In'**
  String get goToSignIn;

  /// No description provided for @dashboardHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get dashboardHome;

  /// No description provided for @dashboardRanking.
  ///
  /// In en, this message translates to:
  /// **'Rankings'**
  String get dashboardRanking;

  /// No description provided for @dashboardAddPrediction.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get dashboardAddPrediction;

  /// No description provided for @dashboardMyPredicts.
  ///
  /// In en, this message translates to:
  /// **'Predicts'**
  String get dashboardMyPredicts;

  /// No description provided for @dashboardProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get dashboardProfile;

  /// No description provided for @addPredictionTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get addPredictionTitle;

  /// No description provided for @addPredictionTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your prediction title'**
  String get addPredictionTitleHint;

  /// No description provided for @addPredictionDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get addPredictionDescription;

  /// No description provided for @addPredictionDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Describe your prediction in detail'**
  String get addPredictionDescriptionHint;

  /// No description provided for @addPredictionSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit Prediction'**
  String get addPredictionSubmit;

  /// No description provided for @addPredictionSuccess.
  ///
  /// In en, this message translates to:
  /// **'Prediction submitted successfully!'**
  String get addPredictionSuccess;

  /// No description provided for @addPredictionFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to submit prediction.'**
  String get addPredictionFailed;

  /// No description provided for @predictionFeedUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'User information not found.'**
  String get predictionFeedUserNotFound;

  /// No description provided for @predictionFeedUnexpectedError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred.'**
  String get predictionFeedUnexpectedError;

  /// No description provided for @predictionFeedNoPredictions.
  ///
  /// In en, this message translates to:
  /// **'No predictions yet.'**
  String get predictionFeedNoPredictions;

  /// No description provided for @predictionFeedVoteCount.
  ///
  /// In en, this message translates to:
  /// **'{count} votes'**
  String predictionFeedVoteCount(Object count);

  /// No description provided for @predictionFeedPositive.
  ///
  /// In en, this message translates to:
  /// **'Positive Prediction'**
  String get predictionFeedPositive;

  /// No description provided for @predictionFeedNegative.
  ///
  /// In en, this message translates to:
  /// **'Negative Prediction'**
  String get predictionFeedNegative;

  /// No description provided for @predictionFeedScore.
  ///
  /// In en, this message translates to:
  /// **'{score} / 5'**
  String predictionFeedScore(Object score);

  /// No description provided for @predictionFeedNotVotedYet.
  ///
  /// In en, this message translates to:
  /// **'Not voted yet'**
  String get predictionFeedNotVotedYet;

  /// No description provided for @predictionFeedLoadingPredictions.
  ///
  /// In en, this message translates to:
  /// **'Loading predictions...'**
  String get predictionFeedLoadingPredictions;

  /// No description provided for @profileEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profileEdit;

  /// No description provided for @profileSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get profileSettings;

  /// No description provided for @profileAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get profileAbout;

  /// No description provided for @profileSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get profileSignOut;

  /// No description provided for @profileSignOutDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get profileSignOutDialogTitle;

  /// No description provided for @profileSignOutDialogContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get profileSignOutDialogContent;

  /// No description provided for @profileSignOutDialogCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get profileSignOutDialogCancel;

  /// No description provided for @profileSignOutDialogConfirm.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get profileSignOutDialogConfirm;

  /// No description provided for @profileLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load profile'**
  String get profileLoadFailed;

  /// No description provided for @profileLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileLanguage;

  /// No description provided for @profileUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get profileUsername;

  /// No description provided for @profileUsernameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your username'**
  String get profileUsernameHint;

  /// No description provided for @profileUsernameRequired.
  ///
  /// In en, this message translates to:
  /// **'Username is required'**
  String get profileUsernameRequired;

  /// No description provided for @profileEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get profileEmail;

  /// No description provided for @profileEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get profileEmailHint;

  /// No description provided for @profileEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get profileEmailRequired;

  /// No description provided for @profileEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get profileEmailInvalid;

  /// No description provided for @profileUpdateSubmit.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get profileUpdateSubmit;

  /// No description provided for @profileUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdateSuccess;

  /// No description provided for @profileUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile'**
  String get profileUpdateFailed;

  /// No description provided for @profileChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get profileChangePassword;

  /// No description provided for @profileCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get profileCurrentPassword;

  /// No description provided for @profileCurrentPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your current password'**
  String get profileCurrentPasswordHint;

  /// No description provided for @profileCurrentPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Current password is required'**
  String get profileCurrentPasswordRequired;

  /// No description provided for @profileNewPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get profileNewPassword;

  /// No description provided for @profileNewPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get profileNewPasswordHint;

  /// No description provided for @profileNewPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'New password is required'**
  String get profileNewPasswordRequired;

  /// No description provided for @profilePasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get profilePasswordTooShort;

  /// No description provided for @profileConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get profileConfirmPassword;

  /// No description provided for @profileConfirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm your new password'**
  String get profileConfirmPasswordHint;

  /// No description provided for @profileConfirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get profileConfirmPasswordRequired;

  /// No description provided for @profilePasswordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get profilePasswordsDoNotMatch;

  /// No description provided for @profilePasswordChangeSubmit.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get profilePasswordChangeSubmit;

  /// No description provided for @profilePasswordChangeSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get profilePasswordChangeSuccess;

  /// No description provided for @profilePasswordChangeFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to change password'**
  String get profilePasswordChangeFailed;

  /// No description provided for @profileDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get profileDeleteAccount;

  /// No description provided for @profileDeleteAccountDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account?'**
  String get profileDeleteAccountDialogTitle;

  /// No description provided for @profileDeleteAccountDialogContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently lost.'**
  String get profileDeleteAccountDialogContent;

  /// No description provided for @profileDeleteAccountDialogCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get profileDeleteAccountDialogCancel;

  /// No description provided for @profileDeleteAccountDialogProceed.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get profileDeleteAccountDialogProceed;

  /// No description provided for @profileDeleteAccountConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Final Confirmation'**
  String get profileDeleteAccountConfirmationTitle;

  /// No description provided for @profileDeleteAccountConfirmationContent.
  ///
  /// In en, this message translates to:
  /// **'This action is permanent and cannot be reversed. All your data, including profile information and activity history, will be permanently deleted.'**
  String get profileDeleteAccountConfirmationContent;

  /// No description provided for @profileDeleteAccountConfirmationPhrase.
  ///
  /// In en, this message translates to:
  /// **'delete my account permanently'**
  String get profileDeleteAccountConfirmationPhrase;

  /// No description provided for @profileDeleteAccountConfirmationInstruction.
  ///
  /// In en, this message translates to:
  /// **'Please type \"{phrase}\" to confirm:'**
  String profileDeleteAccountConfirmationInstruction(String phrase);

  /// No description provided for @profileDeleteAccountConfirmationError.
  ///
  /// In en, this message translates to:
  /// **'The confirmation text doesn\'t match'**
  String get profileDeleteAccountConfirmationError;

  /// No description provided for @profileDeleteAccountConfirmationSubmit.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get profileDeleteAccountConfirmationSubmit;

  /// No description provided for @profileDeleteAccountFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete account'**
  String get profileDeleteAccountFailed;

  /// No description provided for @votePredictionTitle.
  ///
  /// In en, this message translates to:
  /// **'Vote for Prediction'**
  String get votePredictionTitle;

  /// No description provided for @votePredictionPublished.
  ///
  /// In en, this message translates to:
  /// **'Published: {date}'**
  String votePredictionPublished(Object date);

  /// No description provided for @votePredictionHowMuchAgree.
  ///
  /// In en, this message translates to:
  /// **'How much do you agree?'**
  String get votePredictionHowMuchAgree;

  /// No description provided for @votePredictionSuccess.
  ///
  /// In en, this message translates to:
  /// **'Vote submitted successfully'**
  String get votePredictionSuccess;

  /// No description provided for @votePredictionFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to vote'**
  String get votePredictionFailed;

  /// No description provided for @votePredictionVoteRecorded.
  ///
  /// In en, this message translates to:
  /// **'Your vote has been recorded.'**
  String get votePredictionVoteRecorded;

  /// No description provided for @votePredictionVoteInProgress.
  ///
  /// In en, this message translates to:
  /// **'Your vote is being processed. Please wait.'**
  String get votePredictionVoteInProgress;

  /// No description provided for @languageSelectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Language Selection'**
  String get languageSelectionTitle;

  /// No description provided for @languageSelectionEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageSelectionEnglish;

  /// No description provided for @languageSelectionEnglishKey.
  ///
  /// In en, this message translates to:
  /// **'en'**
  String get languageSelectionEnglishKey;

  /// No description provided for @languageSelectionTurkish.
  ///
  /// In en, this message translates to:
  /// **'Turkish'**
  String get languageSelectionTurkish;

  /// No description provided for @languageSelectionTurkishKey.
  ///
  /// In en, this message translates to:
  /// **'tr'**
  String get languageSelectionTurkishKey;

  /// No description provided for @myPredictionsEmpty.
  ///
  /// In en, this message translates to:
  /// **'You have no predictions yet.'**
  String get myPredictionsEmpty;

  /// No description provided for @myPredictionsCreate.
  ///
  /// In en, this message translates to:
  /// **'Create Prediction'**
  String get myPredictionsCreate;

  /// No description provided for @myPredictionsLoadingPredictions.
  ///
  /// In en, this message translates to:
  /// **'Loading predictions...'**
  String get myPredictionsLoadingPredictions;

  /// No description provided for @usersNoUsersFound.
  ///
  /// In en, this message translates to:
  /// **'No users found.'**
  String get usersNoUsersFound;

  /// No description provided for @usersLoadingUsers.
  ///
  /// In en, this message translates to:
  /// **'Loading users...'**
  String get usersLoadingUsers;

  /// No description provided for @usersPredictions.
  ///
  /// In en, this message translates to:
  /// **'Predictions'**
  String get usersPredictions;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordWithQuestionMark.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPasswordWithQuestionMark;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Your Password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we\'ll send you a link to reset your password.'**
  String get forgotPasswordDescription;

  /// No description provided for @forgotPasswordEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get forgotPasswordEmail;

  /// No description provided for @forgotPasswordEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get forgotPasswordEmailHint;

  /// No description provided for @forgotPasswordSubmit.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get forgotPasswordSubmit;

  /// No description provided for @forgotPasswordFailed.
  ///
  /// In en, this message translates to:
  /// **'Password Reset Failed'**
  String get forgotPasswordFailed;

  /// No description provided for @forgotPasswordResetLinkSent.
  ///
  /// In en, this message translates to:
  /// **'If your email exists in our system, a password reset link has been sent.'**
  String get forgotPasswordResetLinkSent;

  /// No description provided for @forgotPasswordRemembered.
  ///
  /// In en, this message translates to:
  /// **'Remembered your password?'**
  String get forgotPasswordRemembered;

  /// No description provided for @aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutTitle;

  /// No description provided for @aboutVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String aboutVersion(String version);

  /// No description provided for @aboutDescriptionContent.
  ///
  /// In en, this message translates to:
  /// **'Guess Buddy is a social prediction platform where users can make predictions about future events and vote on others\' predictions. Track your accuracy over time and see how you compare to other users.'**
  String get aboutDescriptionContent;

  /// No description provided for @aboutLinks.
  ///
  /// In en, this message translates to:
  /// **'Links'**
  String get aboutLinks;

  /// No description provided for @aboutPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get aboutPrivacyPolicy;

  /// No description provided for @aboutTermsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get aboutTermsOfService;

  /// No description provided for @aboutSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get aboutSupport;

  /// No description provided for @aboutVersionUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get aboutVersionUnavailable;

  /// No description provided for @aboutDescription.
  ///
  /// In en, this message translates to:
  /// **'About Guess Buddy'**
  String get aboutDescription;

  /// No description provided for @aboutCopyright.
  ///
  /// In en, this message translates to:
  /// **'© 2023-2024 Guess Buddy. All rights reserved.'**
  String get aboutCopyright;

  /// No description provided for @aboutLaunchUrlFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open link'**
  String get aboutLaunchUrlFailed;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
