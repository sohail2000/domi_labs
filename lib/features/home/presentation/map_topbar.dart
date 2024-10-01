import 'package:domi_labs/styling/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MapTopBar extends StatelessWidget {
  const MapTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20,right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              backgroundColor: Colors.black,
              child: Image.asset('assets/icons/person_white.png'),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.red.shade300,
                      child:
                          const Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Address goes here",
                      style: AppTextStyle.whiteRegular12,
                    ),
                  ],
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.black,
              child: Image.asset('assets/icons/white_chat_bubble.png')
            )
          ],
        ),
      ),
    );
  }
}
