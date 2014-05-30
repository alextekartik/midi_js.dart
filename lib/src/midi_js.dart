part of midi_js;

class MidiJs {

  JsObject _jsObject;
  String _soundfontUrl;
  MidiJs([this._soundfontUrl]) {
    _jsObject = context['MIDI'];
  }
  // List<String> instruments;

  bool get loaded {
    return _jsObject != null;
  }
  
  GeneralMidi _generalMidi;
  GeneralMidi get generalMidi {
    if (_generalMidi == null) {
      _generalMidi = new GeneralMidi(this);
    }
    return _generalMidi;
  }
  

  /**
   * Load the instruments (in the given soundfont is mentionned)
   */
  Future loadInstruments(List<String> instruments, {String soundfontUrl}) {

    Completer completer = new Completer();
    //return new Future.value();
    JsObject args = new JsObject.jsify({});
    if (soundfontUrl == null) {
      soundfontUrl = this._soundfontUrl;
    }
    if (!soundfontUrl.endsWith('/')) {
      soundfontUrl += '/';
    }
    args['soundfontUrl'] = soundfontUrl;
    args['api'] = 'webaudio';

    var instrumentArray = new JsArray.from(instruments);
    args['instruments'] = instrumentArray;
    //args['instruments'] = instruments;
    args['targetFormat'] = 'ogg';
    args['callback'] = () {
      print('callback');
      completer.complete();
    };
    //return js.context.callMethod(js.context['MIDI']['loadPlugin'], [args]);
    _jsObject.callMethod('loadPlugin', [args]);
    return completer.future;
  }

  dynamic callMethod(String method, [List args]) {
    return _jsObject.callMethod(method, args == null ? [] : args);
  }
  
  /**
   * Supported commands
   */
  void noteOn(int channel, int note, int velocity, num delay) {
    callMethod('noteOn', [channel, note, velocity, delay]);
  }
  void noteOff(int channel, int note, num delay) {
    callMethod('noteOff', [channel, note, delay]);
  }
  void setVolume(int channel, int volume) {
    callMethod('setVolume', [channel, volume]);
  }
  void programChange(int channel, int program) {
    callMethod('programChange', [channel, program]);
  }

  int get pianoKeyOffset => _jsObject['pianoKeyOffset'];

}