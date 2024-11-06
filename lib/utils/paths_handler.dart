abstract final class PathsFormatter {
  static String leavePathOnly(String path) {
    return path.substring(0, path.lastIndexOf(r'/'));
  }

  static String filePrefix(String filePath) {
    print(filePath.split('/'));
    return filePath.split('/').last.split('.').first;
  }
}
