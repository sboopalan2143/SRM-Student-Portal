import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:xml/xml.dart';

class HttpService {
  static Future<(int, Map<String, dynamic>)> sendSoapRequest(
    String apiType,
    String encrptedData,
  ) async {
    final logger = Logger();

    // Define the SOAP envelope as a string
    final soapRequest = '<?xml version="1.0" encoding="utf-8"?> '
        '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" '
        'xmlns:exam="http://ws.fipl.com/">'
        '<soapenv:Body>'
        '<exam:$apiType>'
        '<EncryptedData i:type="d:string">$encrptedData</EncryptedData> '
        '</exam:$apiType>'
        '</soapenv:Body>'
        '</soapenv:Envelope>';

    try {
      final response = await post(
        Uri.parse(
          Api.mainUrl,
        ),
        headers: {
          'Content-Type': 'text/xml',
          'Accept': 'text/xml',
        },
        body: soapRequest,
      );

      if (response.statusCode == 200) {
        final document = XmlDocument.parse(response.body);
        final jsonMap = _convertXmlElementToJson(document.rootElement);

        return (response.statusCode, jsonMap);
      } else {
        log('Error');
        log('Url: ${Api.mainUrl}');
        log('Response: ${response.body}');
        final document = XmlDocument.parse(response.body);
        final jsonMap = _convertXmlElementToJson(document.rootElement);
        return (response.statusCode, jsonMap);
      }
    }
    // catch (e) {
    //   return (0, {'message': '$e'});
    // }
    on SocketException {
      logger.e(
        'Url: ${Api.mainUrl}\n'
        'No Internet Connection',
      );
      return (0, {'message': 'No Internet Connection'});
    }
  }

  static Map<String, dynamic> _convertXmlElementToJson(XmlElement element) {
    final result = <String, dynamic>{};

    // Add element attributes as key-value pairs
    for (final attribute in element.attributes) {
      result[attribute.name.local] = attribute.value;
    }

    // If the element has children, add them to the map
    for (final node in element.children) {
      if (node is XmlElement) {
        final nodeName = node.name.local;

        if (result.containsKey(nodeName)) {
          // If the key already exists, convert it to a list
          if (result[nodeName] is List) {
            (result[nodeName] as List).add(_convertXmlElementToJson(node));
          } else {
            result[nodeName] = [
              result[nodeName],
              _convertXmlElementToJson(node),
            ];
          }
        } else {
          result[nodeName] = _convertXmlElementToJson(node);
        }
      } else if (node is XmlText) {
        // Add text content as a key-value pair
        // ignore: deprecated_member_use
        result['#text'] = node.text;
      }
    }

    return result;
  }
}
