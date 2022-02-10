import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/theme/colors.dart';

class AppToast {
  static show(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: AppColors.secondary,
      textColor: AppColors.primary,
    );
  }
}
