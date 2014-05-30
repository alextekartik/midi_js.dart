part of midi_js;

Future _loadJavascriptScript(String src) {
  Completer completer = new Completer();
  var script = new ScriptElement();
  script.type = 'text/javascript';
  script.onError.listen((e) {
    // This is actually the only callback called upon success
    // onError, onDone are never called
    completer.completeError(new Exception('script $src not loaded'));
  });
  script.onLoad.listen((_) {
    // This is actually the only callback called upon success
    // onError, onDone are never called
    completer.complete();
  });
  script.src = src;
  document.body.children.add(script);
  return completer.future;
}

class MidiJsLoader {
  String rootUrl;
  MidiJsLoader(this.rootUrl);

  MidiJs _midi;

  /**
   * this trigger the load - to call only once
   */
  Future<MidiJs> get midi {
    List<Future> futures = new List();

    List<String> jsFiles = ['dom_loader.js', 'tekartik_load_plugin.js', 'dom_loader.js', //
      'plugin.js', 'player.js', 'base64_binary.js'];
    for (String jsFile in jsFiles) {
      futures.add(_loadJavascriptScript(posix.join(rootUrl, 'js', jsFile)));
    }
    return Future.wait(futures).then((_) {
      return new MidiJs(posix.join(rootUrl, 'soundfont', '')); // Midi js expect a trailing /
    });
  }

}
