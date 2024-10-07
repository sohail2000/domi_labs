import 'package:domi_labs/styling/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showErrorMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: AppColor.red.withOpacity(0.7),
    textColor: AppColor.white,
  );
}
