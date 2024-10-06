import 'package:domi_labs/styling/app_colors.dart';
import 'package:domi_labs/styling/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class InviteDialogBox extends StatelessWidget {
  const InviteDialogBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card.filled(
          color: AppColor.black,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Invite and Earn",
                      style: AppTextStyle.whiteBold16,
                    ),
                    const Spacer(),
                    // Image.asset( "assets/icons/cancel_icon.png", width: 40,height:40,)
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: const Icon(
                        Icons.cancel_outlined,
                        color: AppColor.white,
                        size: 20,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 14),
                const Text(
                  "Invite your neighbor and you both recives \$10 when they claim their address.",
                  style: AppTextStyle.whiteRegular14,
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: AppColor.white,
                          foregroundColor: Colors.white),
                      onPressed: () async {
                        final result = await Share.share(
                            'check out my website https://pub.dev/packages/share_plus');

                        if (result.status == ShareResultStatus.success) {
                          print('Thank you for sharing my website!');
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "Send Invite",
                          style: AppTextStyle.blackSemiBold14,
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
