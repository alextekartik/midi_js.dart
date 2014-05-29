library midi_js;

import 'dart:js';
import 'dart:async';
import 'package:tekartik_common/js_utils.dart';


class MidiJs {

  JsObject jsObject;
  String soundfontUrl;
  MidiJs(this.soundfontUrl) {
    jsObject = context['MIDI'];
    print(jsObjectAsMap(jsObject));
  }
  List<String> instruments;

  JsFunction get loadPlugin {
    return jsObject['loadPlugin'];
  }

  /**
   * Load the instruments (in the given soundfont is mentionned)
   */
  Future loadInstruments(List<String> instruments, {String soundfontUrl}) {

    Completer completer = new Completer();
    //return new Future.value();
    JsObject args = new JsObject.jsify({});
    if (soundfontUrl == null) {
      soundfontUrl = this.soundfontUrl;
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
    jsObject.callMethod('loadPlugin', [args]);
    return completer.future;
  }

  dynamic callMethod(String method, [List args]) {
    return jsObject.callMethod(method, args == null ? [] : args);
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

  int get pianoKeyOffset => jsObject['pianoKeyOffset'];

}
