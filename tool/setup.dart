library source_setup;
import 'dart:io';

import 'package:tekartik_common/log_utils.dart';
import 'setup_pull.dart';
import 'package:path/path.dart';
// Source setup

void main() {
  //   Map<String, String> envVars = Platform.environment;
  // Check if MIDI.js checked out and pulled
  String src = midiJsGitProject.path;
  debugQuickLogging(Level.ALL);

  String outJsFolder = join(libFolder, 'js');
  String outSoundFontFolder = join(libFolder, 'soundfont');
  new Directory(webFolder).create(recursive: true).then((_) {
    return new Directory(outJsFolder).create(recursive: true);
  }).then((_) {
    return new Directory(outSoundFontFolder).create(recursive: true);
  }).then((_) {

    // return new File(join(src, 'demo-Basic.html')).copy(join(webFolder, 'demo_basic_js.html'));
    //return new File(join(src, 'demo-MultipleInstruments.html')).copy(join(webFolder, 'demo_multiple_instruments_js.html'));
    return new File(join(src, 'js/MIDI/AudioDetect.js')).copy(join(outJsFolder, 'audio_detect.js'));
  }).then((_) {
    return new File(join(src, 'js/MIDI/LoadPlugin.js')).copy(join(outJsFolder, 'load_plugin.js'));
  }).then((_) {
    return new File(join(src, 'js/MIDI/Plugin.js')).copy(join(outJsFolder, 'plugin.js'));
  }).then((_) {
    return new File(join(src, 'js/MIDI/Player.js')).copy(join(outJsFolder, 'player.js'));
  }).then((_) {
    return new File(join(src, 'inc/base64binary.js')).copy(join(outJsFolder, 'base64_binary.js'));
  }).then((_) {
  //  return new File(join(src, 'inc/Base64.js')).copy(join(outJsFolder, 'base64.js'));
  }).then((_) {
    return new File(join(src, 'js/Window/DOMLoader.XMLHttp.js')).copy(join(outJsFolder, 'dom_loader.js'));
  }).then((_) {
    
   
    // From soundfoont
    src = midiJsSoundfontsGitProject.path;
    String soundPath = join(src, 'FluidR3_GM');

    return new Directory(soundPath).list().listen((fse) {
      if (FileSystemEntity.isFileSync(fse.path)) {
        String file = basename(fse.path);
        if (extension(file) == '.js') {
          if (withoutExtension(file).endsWith("-ogg")) {
            print(file);
            return new File(join(soundPath, file)).copy(join(outSoundFontFolder, file));
          }
        }
        ;

      }

    }).asFuture();
  });
}
