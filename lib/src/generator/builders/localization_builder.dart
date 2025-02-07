import 'package:build/build.dart';
import 'package:localization_generator/src/generator/allocators/localization_config_allocators.dart';
import 'package:localization_generator/src/generator/allocators/localization_strings_allocator.dart';
import 'package:localization_generator/src/generator/generator/localization_generator.dart';
import 'package:localization_generator/utils/constants.dart';
import 'package:source_gen/source_gen.dart';

Builder clientLocalizationBuilder(BuilderOptions options) {
  return LibraryBuilder(
    LocalizationGenerator(
      allocator: SimpleLocalizationStringsAllocator(),
      templatePaths: [Constants.clientLocalizationJsonFilename],
    ),
    generatedExtension: '.client_pages_localization.dart',
    options: options,
  );
}

Builder publicLocalizationBuilder(BuilderOptions options) {
  return LibraryBuilder(
    LocalizationGenerator(
      allocator: SimpleLocalizationStringsAllocator(),
      templatePaths: [Constants.publicLocalizationJsonFilename],
    ),
    generatedExtension: '.public_pages_localization.dart',
    options: options,
  );
}

Builder localizationConfigBuilder(BuilderOptions options) {
  return LibraryBuilder(
    LocalizationGenerator(
      allocator: SimpleLocalizationConfigAllocator(),
      templatePaths: [
        Constants.clientLocalizationJsonFilename,
        Constants.publicLocalizationJsonFilename,
      ],
    ),
    generatedExtension: '.localization_config.dart',
    options: options,
  );
}
