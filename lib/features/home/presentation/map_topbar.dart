import 'package:domi_labs/styling/app_text_styles.dart';
import 'package:flutter/material.dart';

class MapTopBar extends StatelessWidget {
  const MapTopBar({
    super.key,
    required this.address,
  });
  final String address;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.black,
              child: Image.asset(
                'assets/icons/person_white.png',
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/car03.png',
                              width: 40,
                              height: 40,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(address,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.whiteRegular12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            CircleAvatar(
                radius: 24,
                backgroundColor: Colors.black,
                child: Image.asset('assets/icons/white_chat_bubble.png'))
          ],
        ),
      ),
    );
  }
}
