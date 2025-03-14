import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'Region': 'Region',
          'City': 'City',
          'District': 'District',
          "You are now Busy": "You are now Busy",
          "You are now Available": "You are now Available",
          "Resend OTP": "Resend OTP",
          "Enter the 4-digit OTP sent to your phone":
              "Enter the 4-digit OTP sent to your phone",
          "Verify OTP": "Verify OTP",
          'login': 'Login',
          "Enter your phone number": "Enter your phone number",
          'phoneNumber': 'Phone Number',
          'otp': 'OTP',
          'sendOTP': 'Send OTP',
          'verifyOTP': 'Verify OTP',
          'User': 'User',
          'Provider': 'Provider',
          "select your account type :": "select your account type :",
          'provider_dashboard': 'Provider Dashboard',
          'available': 'Available',
          'busy': 'Busy',
          'dashboard': 'Dashboard',
          'accomplished_orders': 'Accomplished Orders',
          'settings': 'Settings',
          'my_orders': 'My Orders',
          'show_my_orders': 'Show My Orders',
          'no_orders_found': 'No orders found',
          'order_id': 'Order #',
          'time': 'Time',
          'destination': 'Destination',
          'car_size': 'Car Size',
          'status': 'Status',
          'load_requests': 'Load requests',
          'status_available': 'Status: Available',
          'status_busy': 'Status: Busy',
          'no_requests_found': 'No requests found',
          'request_id': 'Request #',
          'car_status': 'Car Status',
          'place_of_loading': 'Place of Loading',
          'service_pricing': 'Service Pricing',
          'enter_amount': 'Enter amount',
          'valid_price_error': 'Enter a valid price greater than zero',
          'more': 'MORE',
          'order_status': 'order status',
          'orders': 'My Orders',
          'accomplished': 'accomplished',
          'Broken Engine': 'Broken Engine',
          'Flat Tire': 'Flat Tire',
          'Dead Battery': 'Dead Battery',
          'Small': 'Small',
          'Medium': 'Medium',
          'Large': 'Large',
          'Location': 'Location',
          'under_implementation': 'Pending',
          'rejected': 'Rejected',
          'filter_by': 'Filter orders by : ',
          "Nearest Car Transporters": "Nearest Car Transporters",
          "km away": "km away",
          "Status": "Status",
          "Provider Details": 'Provider Details',
          "Car Malfunction Cause": "Car Malfunction Cause",
          "Location of Loading": "Location of Loading",
          "Destination": "Destination",
          "Submit Request": "Submit Request",
          "Success": "Success",
          "Request submitted successfully": "Request submitted successfully",
          "Car Size": "Car Size",
          "Traffic Accident": "Traffic Accident",
          "Technical Malfunction": "Technical Malfunction",
          "Accept Request": "Accept Request",
          'Please enter the following data : ':
              'Please enter the following data : ',
          'Dashboard': 'Dashboard',
          'Offers': 'Offers',
          'No offers found.': 'No offers found.',
          'SAR': 'SAR',
          'Accept': 'Accept',
          'Negotiate': 'Negotiate',
          'Reject': 'Reject',
          'Waiting for provider confirmation...':
              'Waiting for provider confirmation...',
          'Send Request': 'Send Request',
          'No notifications found': 'No notifications found',
          'Notifications': 'Notifications'
        },
        'ar': {
          "Accept Request": "قبول الطلب",
          "Traffic Accident": "حادثة سيارة",
          "Technical Malfunction": "حادثة فنية",
          "Request submitted successfully": "تم ارسال الطلب بنجاح",
          "Success": " نجاح العملية",
          "Submit Request": "إرسال الطلب",
          "Destination": "الوجهة",
          "Location of Loading": "موقع التحميل",
          "Car Malfunction Cause": "سبب المشكلة",
          "Small": "صغير",
          "Medium": "متوسط",
          "Large": "كبير",
          "Provider Details": "تفاصيل المقدم",
          "Status": "الحالة",
          "Car_transporter_sizes:": "مقاسات السطحة:",
          "Car Size": "مقاس السيارة",
          "km away": "كم بعدا منك",
          "Nearest Car Transporters": "مقدمين خدمات بالقرب منك",
          "You are now Busy": "انت الان مشغول",
          "You are now Available": "انت الان متاح",
          "Resend OTP": "اعادة ارسال الكود",
          "Enter the 4-digit OTP sent to your phone":
              "ادخل الكود المرسل لهاتفك ",
          "Verify OTP": "تحقق من الكود",
          "Enter your phone number": "أدخل رقم هاتفك",
          'login': 'تسجيل الدخول',
          'phoneNumber': 'رقم الهاتف',
          'otp': 'كلمة المرور لمرة واحدة',
          'sendOTP': 'إرسال الكود',
          'verifyOTP': 'تحقق من الكود',
          'User': "عميل",
          'Provider': 'مزود الخدمة',
          "select your account type :": "اختر نوع حسابك :",
          'provider_dashboard': 'صفحة مزود الخدمة',
          'available': 'متاح',
          'busy': 'مشغول',
          'dashboard': 'لوحة التحكم',
          'orders': 'طلباتي',
          'settings': 'الإعدادات',
          'my_orders': 'الطلبات مكتملة',
          'show_my_orders': 'عرض الطلبات المكتملة',
          'no_orders_found': 'لم يتم العثور على طلبات ',
          'order_id': 'طلب #',
          'time': 'الوقت',
          'destination': 'الوجهة',
          'car_size': 'حجم السيارة',
          'status': 'الحالة',
          'load_requests': 'تحميل الطلبات',
          'status_available': 'الحالة: متاح',
          'status_busy': 'الحالة: مشغول',
          'no_requests_found': 'لم يتم العثور على طلبات',
          'request_id': 'طلب #',
          'car_status': 'حالة السيارة',
          'place_of_loading': 'مكان التحميل',
          'service_pricing': 'تسعير الخدمة',
          'enter_amount': 'أدخل المبلغ',
          'valid_price_error': 'أدخل سعرًا صالحًا أكبر من الصفر',
          'more': 'المزيد',
          'order_status': ' حالة الطلب',
          'accomplished': ' مكتملة',
          'Broken Engine': 'عطل في المحرك',
          'Flat Tire': 'اطارات مسطحة',
          'Dead Battery': 'بطارية فارغة',
          'Small': 'صغيرة',
          'Medium': 'متوسطة',
          'Large': 'كبيرة',
          'Location': 'موقع',
          'under_implementation': 'قيد التنفيذ',
          'rejected': 'مرفوضة',
          'filter_by': 'تصفية الطلبات حسب :',
          'Please enter the following data : ':
              'برجاء ادخال البيانات التالية :',
          'Dashboard': 'الصفحة الرئيسية',
          'Offers': 'العروض',
          'No offers found': 'لا يوجد عروض',
          'SAR': 'ريال',
          'Accept': 'قبول',
          'Negotiate': 'تفاوض',
          'Reject': 'رفض',
          'Waiting for provider confirmation...':
              'في انتظار تأكيد مقدم الخدمة ...',
          'Send Request': 'إرسال الطلب',
          'Region': 'المنطقة',
          'City': 'المدينة',
          'District': 'الحي',
          'No notifications found': 'لا يوجد اشعارات جديدة',
          'Notifications': 'إشعارات'
        },
        'ur': {
          'Region': 'علاقہ',
          'City': 'شہر',
          'District': 'ضلع',
          'login': 'لاگ ان',
          'phoneNumber': 'فون نمبر',
          'otp': 'ایک بار کا پاس ورڈ',
          'sendOTP': 'او ٹی پی بھیجیں',
          'verifyOTP': 'او ٹی پی کی تصدیق کریں',
          'User': 'صارف',
          'Provider': 'فراہم کنندہ',
          "select your account type :": 'اپنے اکاؤنٹ کی قسم منتخب کریں:',
          'provider_dashboard': 'فراہم کنندہ ڈیش بورڈ',
          'available': 'دستیاب',
          'busy': 'مصروف',
          'dashboard': 'ڈیش بورڈ',
          'accomplished_orders': 'مکمل ہونے والے آرڈرز',
          'settings': 'ترتیبات',
          'my_orders': 'میرے آرڈرز',
          'show_my_orders': 'میرے آرڈرز دکھائیں',
          'no_orders_found': 'کوئی مکمل آرڈرز نہیں ملے',
          'order_id': 'آرڈر #',
          'time': 'وقت',
          'destination': 'منزل',
          'car_size': 'کار کا سائز',
          'status': 'حالت',
          'load_requests': 'درخواستیں لوڈ کریں',
          'status_available': 'حالت: دستیاب',
          'status_busy': 'حالت: مصروف',
          'no_requests_found': 'کوئی درخواستیں نہیں ملیں',
          'request_id': 'درخواست #',
          'car_status': 'کار کی حالت',
          'place_of_loading': 'لوڈنگ کی جگہ',
          'service_pricing': 'خدمت کی قیمت',
          'enter_amount': 'رقم درج کریں',
          'valid_price_error': 'صفر سے زیادہ درست قیمت درج کریں',
          'more': 'مزید',
        },
      };
}
