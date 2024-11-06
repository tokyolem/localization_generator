import 'package:localization_generator/src/generator/allocators/base/base_allocator.dart';
import 'package:localization_generator/src/generator/allocators/localization_strings_allocator.dart';
import 'package:recase/recase.dart';

final class SimpleLocalizationModulesAllocator extends BaseAllocator {
  final _buffer = StringBuffer();

  @override
  StringBuffer generateClass() {
    if (templateStrings == null) {
      throw ArgumentError();
    }

    _buffer
      ..writeln('final class ${_allocateClassName()} {')
      ..writeln(_allocateClassConstructor());

    return _buffer;
  }

  String _allocateClassName() {
    return r"$InnovorgModulesLocalization";
  }

  String _allocateClassConstructor() {
    final generatedBuffer = StringBuffer();

    final stringsAllocator = SimpleLocalizationStringsAllocator()
      ..initializeTemplate(templateStrings!);

    for (final key in templateStrings!.keys) {
      final pageLocalizationName = stringsAllocator.allocateClassName(key);
      final camelCaseLocalizationName = ReCase(
        pageLocalizationName.replaceAll(r'$', ''),
      ).camelCase;

      generatedBuffer.writeln(
        'final $pageLocalizationName $camelCaseLocalizationName;',
      );
    }

    generatedBuffer.writeln('const ${_allocateClassName()}() : ');
    for (var i = 0; i < templateStrings!.keys.length; i++) {
      final key = templateStrings!.keys.elementAt(i);
      final isLastField = i == templateStrings!.keys.length - 1;

      final pageLocalizationName = stringsAllocator.allocateClassName(key);
      final camelCaseLocalizationName = ReCase(
        pageLocalizationName.replaceAll(r'$', ''),
      ).camelCase;

      generatedBuffer.writeln(
        '$camelCaseLocalizationName = $pageLocalizationName()${isLastField ? ';' : ','}',
      );
    }
    generatedBuffer.writeln('}');

    return generatedBuffer.toString();
  }
}
