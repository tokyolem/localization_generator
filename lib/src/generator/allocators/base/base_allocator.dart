abstract class BaseAllocator {
  List<MapEntry<String, Map<String, dynamic>>>? templateStrings;

  String? generationPrefix;

  StringBuffer generateClass() {
    throw UnimplementedError();
  }

  void initializeTemplate(
    List<MapEntry<String, Map<String, dynamic>>> template,
  ) {
    templateStrings = template;
  }

  void initializePrefix(String prefix) => generationPrefix = prefix;
}
