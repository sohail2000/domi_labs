import 'package:domi_labs/common_widgets/components/domi_dialog_button.dart';
import 'package:domi_labs/styling/app_colors.dart';
import 'package:domi_labs/styling/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class InviteDialogBox extends StatelessWidget {
  const InviteDialogBox({
    super.key,
    required this.inviteAddress,
  });
  final String inviteAddress;

  Future<void> _sendInvite() async {
    await Share.share('Join us on this awesome app! $inviteAddress');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
        onTap: () => context.pop(),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.transparent,
        ),
      ),
      Align(
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
                  DomiDialogButton(
                    title: 'Send Invite',
                    onPressed: () async => await _sendInvite(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
