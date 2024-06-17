import 'dart:convert';
import 'dart:io';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class HttpService {
  static Future<(int, Map<String, dynamic>)> initialGetApi({
    required String url,
  }) async {
    final logger = Logger();
    try {
      final response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return (response.statusCode, jsonResponse as Map<String, dynamic>);
      } else {
        logger.e(
          'Url: $url\n'
          'Response: ${response.body}',
        );
        final jsonResponse = json.decode(response.body);
        return (response.statusCode, jsonResponse as Map<String, dynamic>);
      }
    } on SocketException {
      logger.e(
        'Url: $url\n'
        'No Internet Connection',
      );
      return (0, {'message': 'No Internet Connection'});
    }
  }

  static Future<(int, Map<String, dynamic>)> initialPostApi({
    required String url,
    required Object body,
  }) async {
    final logger = Logger();
    try {
      final response = await post(Uri.parse(url), body: body);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return (response.statusCode, jsonResponse as Map<String, dynamic>);
      } else {
        logger.e(
          'Url: $url\n'
          'Body: $body\n'
          'Response: ${response.body}',
        );
        final jsonResponse = json.decode(response.body);
        return (response.statusCode, jsonResponse as Map<String, dynamic>);
      }
    } on SocketException {
      logger.e(
        'Url: $url\n'
        'No Internet Connection',
      );
      return (0, {'message': 'No Internet Connection'});
    }
  }

  static Future<(int, Map<String, dynamic>)> getApi({
    required String url,
  }) async {
    final logger = Logger();
    try {
      final response = await get(
        Uri.parse(url),
        headers: TokensManagement.headers,
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return (response.statusCode, jsonResponse as Map<String, dynamic>);
      } else {
        logger.e(
          'Url: $url\n'
          'Response: ${response.body}',
        );
        final jsonResponse = json.decode(response.body);
        return (response.statusCode, jsonResponse as Map<String, dynamic>);
      }
    } on SocketException {
      logger.e(
        'Url: $url\n'
        'No Internet Connection',
      );
      return (0, {'message': 'No Internet Connection'});
    }
  }

  static Future<(int, Map<String, dynamic>)> postApi({
    required String url,
    required Object body,
  }) async {
    final logger = Logger();
    try {
      final response = await post(
        Uri.parse(url),
        headers: TokensManagement.headers,
        body: body,
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return (response.statusCode, jsonResponse as Map<String, dynamic>);
      } else {
        logger.e(
          'Url: $url\n'
          'Body: $body\n'
          'Response: ${response.body}',
        );
        final jsonResponse = json.decode(response.body);
        return (response.statusCode, jsonResponse as Map<String, dynamic>);
      }
    } on SocketException {
      logger.e(
        'Url: $url\n'
        'No Internet Connection',
      );
      return (0, {'message': 'No Internet Connection'});
    }
  }
}
