import 'package:domi_labs/styling/app_colors.dart';
import 'package:domi_labs/styling/app_text_styles.dart';
import 'package:flutter/material.dart';

class DomiDialogButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  const DomiDialogButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: AppColor.white,
              foregroundColor: AppColor.white),
          onPressed: onPressed,
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              "Send Invite",
              style: AppTextStyle.blackSemiBold14,
            ),
          )),
    );
  }
}
