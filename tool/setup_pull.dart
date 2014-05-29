library source_setup;

import 'dart:io';
import 'package:tekartik_common/platform_utils.dart';
import 'package:tekartik_common/process_utils.dart';
import 'package:tekartik_common/file_utils.dart';
import 'package:tekartik_common/git_utils.dart';
import 'package:tekartik_common/log_utils.dart';
import 'package:tekartik_common/project_utils.dart';
import 'package:path/path.dart';

String sourceFolder = join(scriptDirPath, 'tmp');
String webFolder = join(projectTopPath, 'web');
String libFolder = join(projectTopPath, 'lib');

GitProject midiJsGitProject = new GitProject('https://github.com/mudcube/MIDI.js', rootFolder: sourceFolder);
GitProject midiJsSoundfontsGitProject = new GitProject('https://github.com/gleitz/midi-js-soundfonts.git', rootFolder: sourceFolder);
void main() {
  debugQuickLogging(Level.ALL);
  
  new Directory(sourceFolder).create(recursive: true).then((_) {
    midiJsGitProject.pullOrClone();
  }).then((_) {
    midiJsSoundfontsGitProject.pullOrClone();

  });
  //print(scriptDirPath);
}
