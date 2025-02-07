import 'package:localization_generator/json_generator/localization_json_creator.dart';
import 'package:localization_generator/json_generator/localization_receiver.dart';
import 'package:localization_generator/utils/logger.dart';
import 'package:localization_generator/utils/process_runner.dart';
import 'package:localization_generator/utils/yaml_reader.dart';
import 'package:source_gen/source_gen.dart';

Future<void> main() async {
  final configuration = await YamlParametersReader.mapConfiguration();
  final token = configuration?['innovorg_api_token'];
  final generateOnly = configuration?['generate_only'] as bool? ?? false;

  if (token == null) {
    throw InvalidGenerationSourceError(
      '\n`innovorg_api_token` must not be null\n\n'
      'Check configuration in localization_generator.yaml\n',
    );
  }

  final receiver = LocalizationReceiver();
  try {
    if (!generateOnly) {
      final templatePLocalizationPagesJson =
          await receiver.fetchLocalizationJson(
        forPublicLocalization: true,
      );
      final templateCLocalizationPagesJson =
          await receiver.fetchLocalizationJson(
        token: token,
        forPublicLocalization: false,
      );

      LocalizationJsonCreator().createTemplateLocalizationJson(
        pagesLocalizationJson: templatePLocalizationPagesJson,
        forPublicLocalizations: true,
      );

      LocalizationJsonCreator().createTemplateLocalizationJson(
        pagesLocalizationJson: templateCLocalizationPagesJson,
        forPublicLocalizations: false,
      );
    }

    final needStartBuildRunner = configuration?['start_build_runner'];
    if (needStartBuildRunner) await ProcessRunner.runBuildRunner();

    final directoryForFormat =
        configuration?['generation_directory_for_format'];
    if (directoryForFormat != null) {
      await ProcessRunner.runDartFormatterForGeneration(directoryForFormat);
    }
  } on Object catch (error, stackTrace) {
    print(error);
    Logger.log('Error', error, stackTrace);
  }
}
