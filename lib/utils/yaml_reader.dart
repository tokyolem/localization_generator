import 'dart:io';

import 'package:localization_generator/utils/constants.dart';
import 'package:localization_generator/utils/logger.dart';
import 'package:yaml/yaml.dart' as yaml;

abstract final class YamlParametersReader {
  /// The method returns the configuration from the
  /// localization.translation.yaml file.
  static Future<Map<String, dynamic>?> mapConfiguration() async {
    try {
      final yamlConfigurator = await _fetchYamlConfigurator();

      if (yamlConfigurator == null) {
        _printConfigurationError();
      }

      final yamlString = yamlConfigurator!.readAsStringSync();

      final yamlMap = yaml.loadYaml(yamlString) as yaml.YamlMap;

      return _castYamlMapToMap(yamlMap);
    } catch (e) {
      _printConfigurationError();

      return null;
    }
  }

  /// The method converts yamlMap into a regular Map object.
  static Map<String, dynamic>? _castYamlMapToMap(yaml.YamlMap yamlMap) {
    final keys = yamlMap.keys.map((e) => e.toString());

    return Map.fromIterables(keys, yamlMap.values);
  }

  static Future<File?> _fetchYamlConfigurator() async {
    try {
      final yamlConfiguration = File(Constants.yamlConfigFilepath);

      return yamlConfiguration;
    } catch (_) {
      _printConfigurationError();

      return null;
    }
  }

  static void _printConfigurationError() => Logger.log(
        '<!>Yaml Configurator not found<!>\n'
        'Check for localization_translator.yaml in the project root\n'
        'Also check the list of available options',
      );
}
