import 'dart:convert';

import 'package:http/http.dart' as http;

final class LocalizationReceiver {
  Future<String> fetchLocalizationJson({
    String? token,
    String? templateLang,
    bool forPublicLocalization = false,
  }) async {
    /*if (token == null && forPublicLocalization) {
      throw UnsupportedError(
        'Operation for configuration: '
        'token == null && forPublicLocalization unsupported',
      );
    }*/

    const requestUrlString = 'https://api.innovorg.com/platform/localization/';
    final requestParams = '?application=mobile&space='
        '${forPublicLocalization ? 'public' : 'client'}';
    final requestUri = Uri.parse('$requestUrlString$requestParams');

    final localizationResponse = await http.get(
      requestUri,
      headers: {
        if (token != null) 'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );

    if (localizationResponse.statusCode != 200) {
      throw ArgumentError(
        'Localization fetching finished with error.\n'
        'Response body was:\n${localizationResponse.body}',
      );
    }

    final localizationLang = templateLang ?? 'en_US';
    final decodedLocalizationResponse = jsonDecode(localizationResponse.body);
    final localizationDataMap = decodedLocalizationResponse['data'];

    // TODO(tokyolem): Rework when response will be correct.
    final templateLangPages = localizationDataMap['pages'];

    return jsonEncode(templateLangPages);
  }
}
