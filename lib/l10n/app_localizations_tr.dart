// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get generalError => 'Beklenmeyen bir hata oluştu.';

  @override
  String get generalTryAgain => 'Lütfen tekrar deneyin.';

  @override
  String get signIn => 'Giriş Yap';

  @override
  String get signInEmail => 'E-posta';

  @override
  String get signInEmailHint => 'Lütfen geçerli bir e-posta girin.';

  @override
  String get signInPassword => 'Şifre';

  @override
  String get signInPasswordHint => 'Şifre en az 6 karakter olmalı.';

  @override
  String get signInFailed => 'Giriş Başarısız';

  @override
  String get signInDontHaveAccount => 'Hesabınız yok mu?';

  @override
  String get signUp => 'Kayıt Ol';

  @override
  String get signUpEmail => 'E-posta';

  @override
  String get signUpEmailHint => 'Lütfen geçerli bir e-posta girin.';

  @override
  String get signUpFailed => 'Kayıt Başarısız';

  @override
  String get signUpUsername => 'Kullanıcı Adı';

  @override
  String get signUpUsernameHint =>
      'Kullanıcı Adı 3 ile 32 karakter arasında olmalı.';

  @override
  String get signUpPassword => 'Şifre';

  @override
  String get signUpPasswordHint => 'Şifre en az 8 karakter olmalı.';

  @override
  String get signUpConfirmPassword => 'Şifreyi Onayla';

  @override
  String get signUpConfirmPasswordHint => 'Şifreler eşleşmiyor.';

  @override
  String get signUpAlreadyHaveAccount => 'Zaten hesabınız var mı?';

  @override
  String get ok => 'Tamam';

  @override
  String get signUpSuccessTitle => 'Kayıt Başarılı';

  @override
  String get signUpSuccessMessage =>
      'Hesabınız başarıyla oluşturuldu. Artık giriş yapabilirsiniz.';

  @override
  String get goToSignIn => 'Giriş Yap\'a Git';

  @override
  String get dashboardHome => 'Ana Menü';

  @override
  String get dashboardRanking => 'Sıralama';

  @override
  String get dashboardAddPrediction => 'Ekle';

  @override
  String get dashboardMyPredicts => 'Tahminlerim';

  @override
  String get dashboardProfile => 'Profil';

  @override
  String get addPredictionTitle => 'Başlık';

  @override
  String get addPredictionTitleHint => 'Tahmin başlığınızı girin';

  @override
  String get addPredictionDescription => 'Açıklama';

  @override
  String get addPredictionDescriptionHint =>
      'Tahmininizi ayrıntılı olarak açıklayın';

  @override
  String get addPredictionSubmit => 'Tahmini Gönder';

  @override
  String get addPredictionSuccess => 'Tahmin başarıyla gönderildi!';

  @override
  String get addPredictionFailed => 'Tahmin kaydedilemedi.';

  @override
  String get predictionFeedUserNotFound => 'Kullanıcı bilgisi bulunamadı.';

  @override
  String get predictionFeedUnexpectedError => 'Beklenmedik bir hata oluştu.';

  @override
  String get predictionFeedNoPredictions => 'Henüz tahmin bulunmamaktadır.';

  @override
  String predictionFeedVoteCount(Object count) {
    return '$count oy';
  }

  @override
  String get predictionFeedPositive => 'Olumlu Tahmin';

  @override
  String get predictionFeedNegative => 'Olumsuz Tahmin';

  @override
  String predictionFeedScore(Object score) {
    return '$score / 5';
  }

  @override
  String get predictionFeedNotVotedYet => 'Henüz oy kullanılmadı';

  @override
  String get predictionFeedLoadingPredictions => 'Tahminler yükleniyor...';

  @override
  String get profileEdit => 'Profili Düzenle';

  @override
  String get profileSettings => 'Ayarlar';

  @override
  String get profileAbout => 'Hakkında';

  @override
  String get profileSignOut => 'Çıkış Yap';

  @override
  String get profileSignOutDialogTitle => 'Çıkış Yap';

  @override
  String get profileSignOutDialogContent =>
      'Çıkış yapmak istediğinizden emin misiniz?';

  @override
  String get profileSignOutDialogCancel => 'İptal';

  @override
  String get profileSignOutDialogConfirm => 'Çıkış Yap';

  @override
  String get profileLoadFailed => 'Profil yüklenemedi';

  @override
  String get profileLanguage => 'Dil';

  @override
  String get profileUsername => 'Kullanıcı Adı';

  @override
  String get profileUsernameHint => 'Kullanıcı adınızı girin';

  @override
  String get profileUsernameRequired => 'Kullanıcı adı gereklidir';

  @override
  String get profileUsernameTooShort =>
      'Kullanıcı adı en az 3 karakter olmalıdır';

  @override
  String get profileSave => 'Değişiklikleri Kaydet';

  @override
  String get profileUpdateSuccess => 'Profil başarıyla güncellendi';

  @override
  String get profileUpdateError => 'Profil güncellenemedi';

  @override
  String get profileEmail => 'E-posta';

  @override
  String get profileEmailHint => 'E-posta adresinizi girin';

  @override
  String get profileEmailRequired => 'E-posta gereklidir';

  @override
  String get profileEmailInvalid => 'Lütfen geçerli bir e-posta adresi girin';

  @override
  String get profileUpdateSubmit => 'Profili Güncelle';

  @override
  String get profileUpdateFailed => 'Profil güncellenemedi';

  @override
  String get profileChangePassword => 'Şifre Değiştir';

  @override
  String get profileCurrentPassword => 'Mevcut Şifre';

  @override
  String get profileCurrentPasswordHint => 'Mevcut şifrenizi girin';

  @override
  String get profileCurrentPasswordRequired => 'Mevcut şifre gereklidir';

  @override
  String get profileNewPassword => 'Yeni Şifre';

  @override
  String get profileNewPasswordHint => 'Yeni şifrenizi girin';

  @override
  String get profileNewPasswordRequired => 'Yeni şifre gereklidir';

  @override
  String get profilePasswordTooShort => 'Şifre en az 8 karakter olmalıdır';

  @override
  String get profileConfirmPassword => 'Şifreyi Onayla';

  @override
  String get profileConfirmPasswordHint => 'Yeni şifrenizi onaylayın';

  @override
  String get profileConfirmPasswordRequired => 'Lütfen şifrenizi onaylayın';

  @override
  String get profilePasswordsDoNotMatch => 'Şifreler eşleşmiyor';

  @override
  String get profilePasswordChangeSubmit => 'Şifreyi Değiştir';

  @override
  String get profilePasswordChangeSuccess => 'Şifre başarıyla değiştirildi';

  @override
  String get profilePasswordChangeFailed => 'Şifre değiştirilemedi';

  @override
  String get profileDeleteAccount => 'Hesabı Sil';

  @override
  String get profileDeleteAccountDialogTitle => 'Hesap Silinsin mi?';

  @override
  String get profileDeleteAccountDialogContent =>
      'Hesabınızı silmek istediğinizden emin misiniz? Bu işlem geri alınamaz ve tüm verileriniz kalıcı olarak silinecektir.';

  @override
  String get profileDeleteAccountDialogCancel => 'İptal';

  @override
  String get profileDeleteAccountDialogProceed => 'Devam Et';

  @override
  String get profileDeleteAccountConfirmationTitle => 'Son Onaylama';

  @override
  String get profileDeleteAccountConfirmationContent =>
      'Bu işlem kalıcıdır ve geri alınamaz. Profil bilgileriniz ve etkinlik geçmişiniz dahil tüm verileriniz kalıcı olarak silinecektir.';

  @override
  String get profileDeleteAccountConfirmationPhrase =>
      'hesabımı kalıcı olarak sil';

  @override
  String profileDeleteAccountConfirmationInstruction(String phrase) {
    return 'Onaylamak için lütfen \"$phrase\" yazın:';
  }

  @override
  String get profileDeleteAccountConfirmationError => 'Onay metni eşleşmiyor';

  @override
  String get profileDeleteAccountConfirmationSubmit => 'Hesabı Sil';

  @override
  String get profileDeleteAccountFailed => 'Hesap silinemedi';

  @override
  String get votePredictionTitle => 'Tahmin için Oy Ver';

  @override
  String votePredictionPublished(Object date) {
    return 'Yayınlanma: $date';
  }

  @override
  String get votePredictionHowMuchAgree => 'Ne kadar katılıyorsunuz?';

  @override
  String get votePredictionSuccess => 'Oyunuz başarıyla gönderildi';

  @override
  String get votePredictionFailed => 'Oy verme başarısız';

  @override
  String get votePredictionVoteRecorded => 'Oyunuz kaydedildi.';

  @override
  String get votePredictionVoteInProgress =>
      'Oyunuz işleniyor. Lütfen bekleyin.';

  @override
  String get languageSelectionTitle => 'Dil Seçimi';

  @override
  String get languageSelectionEnglish => 'İngilizce';

  @override
  String get languageSelectionEnglishKey => 'en';

  @override
  String get languageSelectionTurkish => 'Türkçe';

  @override
  String get languageSelectionTurkishKey => 'tr';

  @override
  String get myPredictionsEmpty => 'Henüz tahmininiz yok.';

  @override
  String get myPredictionsCreate => 'Tahmin Oluştur';

  @override
  String get myPredictionsLoadingPredictions => 'Tahminler yükleniyor...';

  @override
  String get usersNoUsersFound => 'Kullanıcı bulunamadı.';

  @override
  String get usersLoadingUsers => 'Kullanıcılar yükleniyor...';

  @override
  String get usersPredictions => 'Tahmin';

  @override
  String get forgotPassword => 'Şifremi Unuttum';

  @override
  String get forgotPasswordWithQuestionMark => 'Şifreni mi unuttun?';

  @override
  String get forgotPasswordTitle => 'Şifreni Sıfırla';

  @override
  String get forgotPasswordDescription =>
      'E-posta adresini gir ve sana şifre sıfırlama bağlantısı gönderelim.';

  @override
  String get forgotPasswordEmail => 'E-posta';

  @override
  String get forgotPasswordEmailHint =>
      'Lütfen geçerli bir e-posta adresi girin';

  @override
  String get forgotPasswordSubmit => 'Sıfırlama Bağlantısı Gönder';

  @override
  String get forgotPasswordFailed => 'Şifre Sıfırlama Başarısız';

  @override
  String get forgotPasswordResetLinkSent =>
      'E-posta adresiniz sistemimizde mevcutsa, şifre sıfırlama bağlantısı gönderilmiştir.';

  @override
  String get forgotPasswordRemembered => 'Şifreni hatırladın mı?';

  @override
  String get aboutTitle => 'Hakkında';

  @override
  String aboutVersion(String version) {
    return 'Sürüm $version';
  }

  @override
  String get aboutDescriptionContent =>
      'Guess Buddy, kullanıcıların gelecekteki olaylar hakkında tahminlerde bulunabilecekleri ve başkalarının tahminlerine oy verebilecekleri bir sosyal tahmin platformudur. Zaman içindeki doğruluğunuzu takip edin ve diğer kullanıcılarla nasıl karşılaştırıldığınızı görün.';

  @override
  String get aboutLinks => 'Bağlantılar';

  @override
  String get aboutPrivacyPolicy => 'Gizlilik Politikası';

  @override
  String get aboutTermsOfService => 'Kullanım Şartları';

  @override
  String get aboutSupport => 'Yardım ve Destek';

  @override
  String get aboutVersionUnavailable => 'Bilinmiyor';

  @override
  String get aboutDescription => 'Guess Buddy Hakkında';

  @override
  String get aboutCopyright => '© 2023-2024 Guess Buddy. Tüm hakları saklıdır.';

  @override
  String get aboutLaunchUrlFailed => 'Bağlantı açılamadı';
}
