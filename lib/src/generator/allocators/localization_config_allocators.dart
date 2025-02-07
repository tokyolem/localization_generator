import 'package:localization_generator/src/generator/allocators/base/base_allocator.dart';
import 'package:localization_generator/src/generator/allocators/localization_strings_allocator.dart';
import 'package:localization_generator/utils/constants.dart';
import 'package:recase/recase.dart';

final class SimpleLocalizationConfigAllocator extends BaseAllocator {
  SimpleLocalizationConfigAllocator();

  final _buffer = StringBuffer();

  @override
  StringBuffer generateClass() {
    if (templateStrings == null) {
      throw ArgumentError('template must not be null before start allocator');
    }

    _buffer.writeln(allocateImports());

    for (final template in templateStrings!) {
      final className = allocateClassName(template.key);

      _buffer
        ..writeln('final class $className {')
        ..writeln(
          '  final Map<String, Map<String, String>> pagesLocalizations;',
        )
        ..writeln('')
        ..writeln(allocateClassPrivateFields(template))
        ..writeln(allocateClassConstructor(template.key))
        ..writeln('')
        ..writeln(allocateClassGetters(template));
    }

    return _buffer;
  }

  String allocateClassName(String templateKey) {
    final className = switch (templateKey) {
      Constants.publicLocalizationJsonFilename =>
        r'$InnovorgPublicLocalizationConfig',
      Constants.clientLocalizationJsonFilename =>
        r'$InnovorgClientLocalizationConfig',
      _ => throw UnimplementedError(),
    };

    return className;
  }

  String allocateClassConstructor(String templateKey) {
    final className = allocateClassName(templateKey);

    return '  $className({required this.pagesLocalizations});';
  }

  String allocateClassPrivateFields(
    MapEntry<String, Map<String, dynamic>> template,
  ) {
    final fieldsBuffer = StringBuffer();
    final localizationStringsAllocator = SimpleLocalizationStringsAllocator()
      ..initializeTemplate([template]);

    for (var i = 0; i < template.value.keys.length; i++) {
      final localizationPage = template.value.keys.elementAt(i);

      final allocatedLocalizationsClassName =
          localizationStringsAllocator.allocateClassName(localizationPage);

      final handledLocalizationsClassName =
          allocatedLocalizationsClassName.replaceAll(r'$', '');
      final camelCaseFieldName =
          ReCase(handledLocalizationsClassName).camelCase;

      fieldsBuffer.writeln(
        "  late final $allocatedLocalizationsClassName _$camelCaseFieldName = "
        "$allocatedLocalizationsClassName("
        "pagesLocalizations['$localizationPage'] ?? <String, String>{},);",
      );

      fieldsBuffer.writeln('');
    }

    return fieldsBuffer.toString();
  }

  String allocateClassGetters(MapEntry<String, Map<String, dynamic>> template) {
    final fieldsBuffer = StringBuffer();
    final localizationStringsAllocator = SimpleLocalizationStringsAllocator()
      ..initializeTemplate([template]);

    for (var i = 0; i < template.value.keys.length; i++) {
      final isLastGetter = i == template.value.keys.length - 1;
      final localizationPage = template.value.keys.elementAt(i);

      final allocatedLocalizationsClassName =
          localizationStringsAllocator.allocateClassName(localizationPage);

      final handledLocalizationsClassName =
          allocatedLocalizationsClassName.replaceAll(r'$', '');
      final camelCaseFieldName =
          ReCase(handledLocalizationsClassName).camelCase;

      fieldsBuffer.writeln(
        "  $allocatedLocalizationsClassName get $camelCaseFieldName => "
        "_$camelCaseFieldName;",
      );

      if (!isLastGetter) fieldsBuffer.writeln('');
    }

    fieldsBuffer.writeln('}');

    return fieldsBuffer.toString();
  }

  String allocateImports() {
    return '''
import '$generationPrefix.public_pages_localization.dart';
import '$generationPrefix.client_pages_localization.dart';    
    ''';
  }
}
