abstract class BaseAllocator {
  Map<String, dynamic>? templateStrings;

  String? generationPrefix;

  StringBuffer generateClass() {
    throw UnimplementedError();
  }

  void initializeTemplate(Map<String, dynamic> template) =>
      templateStrings = template;

  void initializePrefix(String prefix) => generationPrefix = prefix;
}
