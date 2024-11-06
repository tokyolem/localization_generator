import 'package:build/build.dart';
import 'package:localization_generator/localization_generator.dart';
import 'package:localization_generator/src/generator/allocators/base/base_allocator.dart';
import 'package:source_gen/source_gen.dart';

abstract class BaseLocalizationGenerator
    extends GeneratorForAnnotation<GenerateLocalization> {
  final BaseAllocator allocator;
  final List<String> templatePaths;

  const BaseLocalizationGenerator({
    required this.allocator,
    required this.templatePaths,
  });

  void startGeneration(BuildStep buildStep);
}
