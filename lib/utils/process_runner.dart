import 'dart:io';

import 'package:localization_generator/utils/logger.dart';

abstract final class ProcessRunner {
  static Future<bool> runBuildRunner() async {
    final process = await Process.start(
      'dart',
      ['run', 'build_runner', 'build'],
      runInShell: true,
    );

    process.stdout.transform(SystemEncoding().decoder).listen(stdout.write);
    process.stderr.transform(SystemEncoding().decoder).listen(stderr.write);

    final exitCode = await process.exitCode;

    return exitCode == 0;
  }

  static Future<bool> runDartFormatterForGeneration(
    String pathToGenerated,
  ) async {
    return Process.run(
      'dart',
      ['format', pathToGenerated],
    ).then(
      (result) {
        print(result.stderr);
        print(result.stdout);
        Logger.log(
          result.exitCode == 0 ? result.stdout : result.stderr,
        );

        return result.exitCode == 0;
      },
    );
  }
}
