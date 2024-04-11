import 'dart:convert';

import 'package:crypto/crypto.dart';

///Add hash functionality to get astring
extension HashStringExtension on String {
  /// return to sha256 of this [String]
  String get hashValue {
    return sha256.convert(utf8.encode(this)).toString();
  }
}
