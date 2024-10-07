import 'package:flutter/material.dart';

class ContinuousLinearLoadingBar extends StatelessWidget {
  const ContinuousLinearLoadingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: null, 
      backgroundColor: Colors.grey[300],
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
    );
  }
}
