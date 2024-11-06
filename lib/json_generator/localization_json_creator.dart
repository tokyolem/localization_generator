import 'dart:convert';
import 'dart:io';

final class LocalizationJsonCreator {
  Future<void> createTemplateLocalizationJson({
    required String pagesLocalizationJson,
    bool forPublicLocalizations = false,
  }) async {
    final decodedPagesLocalizationJson = jsonDecode(pagesLocalizationJson);
    final formattedJson = JsonEncoder.withIndent('  ').convert(
      decodedPagesLocalizationJson,
    );

    File(
      '${forPublicLocalizations ? 'public_localization_template' : 'client_localization_template'}.json',
    ).writeAsString(formattedJson, flush: false);
  }
}
