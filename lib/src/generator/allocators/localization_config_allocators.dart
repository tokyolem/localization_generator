import 'package:localization_generator/src/generator/allocators/base/base_allocator.dart';
import 'package:localization_generator/src/generator/allocators/localization_strings_allocator.dart';
import 'package:recase/recase.dart';

final class SimpleLocalizationConfigAllocator extends BaseAllocator {
  SimpleLocalizationConfigAllocator();

  final _buffer = StringBuffer();

  @override
  StringBuffer generateClass() {
    if (templateStrings == null) {
      throw ArgumentError('template must not be null before start allocator');
    }

    final className = allocateClassName();

    _buffer
      ..writeln(allocateImports())
      ..writeln('abstract class $className {')
      ..writeln(allocateClassConstructor())
      ..writeln('')
      ..writeln(allocateClassGetters());

    return _buffer;
  }

  String allocateClassName() {
    return '\$InnovorgLocalizationConfig';
  }

  String allocateClassConstructor() {
    final className = allocateClassName();

    return '  const $className();';
  }

  String allocateClassGetters() {
    final fieldsBuffer = StringBuffer();
    final localizationStringsAllocator = SimpleLocalizationStringsAllocator()
      ..initializeTemplate(templateStrings!);

    for (var i = 0; i < templateStrings!.keys.length; i++) {
      final isLastGetter = i == templateStrings!.keys.length - 1;
      final localizationPage = templateStrings!.keys.elementAt(i);

      final allocatedLocalizationsClassName =
          localizationStringsAllocator.allocateClassName(localizationPage);

      final handledLocalizationsClassName =
          allocatedLocalizationsClassName.replaceAll(r'$', '');
      final camelCaseFieldName =
          ReCase(handledLocalizationsClassName).camelCase;

      fieldsBuffer.writeln(
        '  $allocatedLocalizationsClassName get $camelCaseFieldName;',
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
