import 'package:localization_generator/src/generator/allocators/base/base_allocator.dart';
import 'package:recase/recase.dart';

final class SimpleLocalizationStringsAllocator extends BaseAllocator {
  final _buffer = StringBuffer();

  @override
  StringBuffer generateClass() {
    if (templateStrings == null) {
      throw ArgumentError('template must not be null before start allocator');
    }

    for (final localizationEntry in templateStrings!.first.value.entries) {
      final className = allocateClassName(localizationEntry.key);

      _buffer
        ..writeln(
          'final class $className {',
        )
        ..writeln(
          _allocateClassConstructor(className),
        )
        ..writeln(
          _allocateClassGetters(
            localizationEntry.value as Map<String, dynamic>,
          ),
        );
    }

    return _buffer;
  }

  String allocateClassName(String underscoreName) {
    return '\$${ReCase(underscoreName).pascalCase}Localization';
  }

  String _allocateClassConstructor(String className) {
    return '''
  final Map<String, String> _localizationStrings;

  const $className(this._localizationStrings);
    ''';
  }

  String _allocateClassGetters(Map<String, dynamic> strings) {
    final gettersBuffer = StringBuffer();

    for (var index = 0; index < strings.keys.length; index++) {
      final key = strings.keys.elementAt(index).trim();
      final isLastGetter = index == strings.keys.length - 1;

      final getterName = _checkKeyForKeyword(
        ReCase(key.trim()).camelCase,
      );

      final getter =
          "String get $getterName => _localizationStrings['$key'] ?? '';";

      if (!gettersBuffer.toString().contains(getter)) {
        gettersBuffer.writeln("  $getter");
        if (!isLastGetter) gettersBuffer.writeln('');
      }
    }

    gettersBuffer.writeln('}');

    return gettersBuffer.toString();
  }

  String _checkKeyForKeyword(String key) {
    return switch (key) {
      'in' => 'inNoKeyword',
      'default' => 'defaultNoKeyword',
      'for' => 'forNoKeyword',
      _ => key,
    };
  }
}
