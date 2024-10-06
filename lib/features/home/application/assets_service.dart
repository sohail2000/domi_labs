import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class AssetService {
  static Future<String> _loadAsset({required String assetPath}) async {
    return await rootBundle.loadString(assetPath);
  }

  static Future<Map<String, dynamic>> parseJsonFromAsset(
      {required String assetPath}) async {
    String jsonString = await _loadAsset(assetPath: assetPath);
    final asn = json.decode(jsonString);
    return asn;
  }
}
