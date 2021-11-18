import 'package:hotreloader/hotreloader.dart';

Future<void> main(List<String> args) async {
  // instantiate a reloader that by monitors the project's source code folders for changes
  final reloader = await HotReloader.create();

  // ... your other code

  // cleanup
  reloader.stop();
}
