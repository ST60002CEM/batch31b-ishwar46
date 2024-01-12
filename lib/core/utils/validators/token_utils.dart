import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';

bool isTokenFormatValid(String? token) {
  if (token == null) {
    return false;
  }

  List<String> parts = token.split('.');

  // Check if the token has three parts (header, payload, signature)
  if (parts.length != 3) {
    return false;
  }

  try {
    // Check if each part is a valid Base64 URL encoded string
    for (String part in parts) {
      base64Url.decode(part);
    }
    return true;
  } catch (e) {
    // An error occurred while decoding the token
    return false;
  }
}

bool isTokenValid(String? token) {
  if (token == null) {
    return false;
  }

  try {
    // Check token format
    if (!isTokenFormatValid(token)) {
      return false;
    }

    // Check token expiration
    if (JwtDecoder.isExpired(token)) {
      return false;
    }

    // If you have a secret or key, you can check the token's integrity
    // Example:
    // if (!JwtDecoder.verify(token, 'your_secret_key')) {
    //   return false;
    // }

    return true;
  } catch (e) {
    // An error occurred while decoding or validating the token
    return false;
  }
}
