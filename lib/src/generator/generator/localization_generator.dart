import 'package:build/build.dart';
import 'package:localization_generator/src/generator/generator/base/base_localization_generator.dart';
import 'package:localization_generator/src/generator/json_receivers/base_localization_json_receiver.dart';
import 'package:localization_generator/utils/paths_handler.dart';
import 'package:source_gen/source_gen.dart';

class LocalizationGenerator extends BaseLocalizationGenerator {
  LocalizationGenerator({
    required super.templatePaths,
    required super.allocator,
  });

  @override
  Future<void> generateForAnnotatedElement(
    element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    startGeneration(buildStep);
  }

  @override
  void startGeneration(BuildStep buildStep) {
    final localizationJsonReceiver = BaseLocalizationJsonReceiver();

    final localizationEntries = <MapEntry<String, Map<String, dynamic>>>[];
    for (final templatePath in templatePaths) {
      localizationEntries.add(
        MapEntry(
          templatePath,
          localizationJsonReceiver.receiveLocalizationJsons(
            jsonLocatePath: templatePath,
          ),
        ),
      );
    }

    if (localizationEntries.isEmpty) return;

    final pathForGeneration = buildStep.allowedOutputs.first.path;
    final generationPrefix = PathsFormatter.filePrefix(pathForGeneration);

    allocator
      ..initializeTemplate(localizationEntries)
      ..initializePrefix(generationPrefix);

    buildStep.writeAsString(
      buildStep.allowedOutputs.first,
      allocator.generateClass().toString(),
    );
  }
}
