import 'dart:convert';
import 'dart:io';

import 'package:localization_generator/utils/logger.dart';

final class BaseLocalizationJsonReceiver {
  Map<String, dynamic> receiveLocalizationJsons({
    required String jsonLocatePath,
  }) {
    try {
      final file = File(jsonLocatePath);

      final fileContent = file.readAsStringSync();
      final contentMap = jsonDecode(fileContent) as Map<String, dynamic>;

      return contentMap;
    } on Object catch (error, stackTrace) {
      Logger.log(
        'Receive localization jsons finished with error',
        error,
        stackTrace,
      );

      return {};
    }
  }
}
