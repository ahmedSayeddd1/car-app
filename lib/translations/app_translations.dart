import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'login': 'Login',
          'phoneNumber': 'Phone Number',
          'otp': 'OTP',
          'sendOTP': 'Send OTP',
          'verifyOTP': 'Verify OTP',
          'User': 'User',
          'Provider': 'Provider',
          "select your account type :": "select your account type :"
        },
        'ar': {
          'login': 'تسجيل الدخول',
          'phoneNumber': 'رقم الهاتف',
          'otp': 'كلمة المرور لمرة واحدة',
          'sendOTP': 'إرسال الكود',
          'verifyOTP': 'تحقق من الكود',
          'User': "عميل",
          'Provider': 'مزود الخدمة',
          "select your account type :": "اختر نوع حسابك :"
        },
        'ur': {
          'login': 'لاگ ان',
          'phoneNumber': 'فون نمبر',
          'otp': 'ایک بار کا پاس ورڈ',
          'sendOTP': 'او ٹی پی بھیجیں',
          'verifyOTP': 'او ٹی پی کی تصدیق کریں',
          'User': 'صارف',
          'Provider': 'فراہم کنندہ',
          "select your account type :": 'اپنے اکاؤنٹ کی قسم منتخب کریں:'
        },
      };
}
