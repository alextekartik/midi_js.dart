part of midi_js;

const String ACOUSTIC_GRAND_PIANO_ID = "acoustic_grand_piano";
const String SYNTH_DRUM_ID = "synth_drum";

class GeneralMidiInstrument {
  GeneralMidi generalMidi;
  JsObject _jsObject;
  int get num => _jsObject['number'];
  String get id => _jsObject['id'];
  String get name => _jsObject['instrument'];
  GeneralMidiInstrument(this.generalMidi, this._jsObject);
  
  @override
  String toString() {
    return "$num $id $name";
  }
}

//class GeneralMidiInstrumentById extends GeneralMidiInstrument {
//  int id;
//  GeneralMidiInstrumentById(GeneralMidi gm, this.id, JsObject jsObject) : super(gm, jsObject);
//}
class GeneralMidi {
  MidiJs midi;
  JsObject _jsObject;
  GeneralMidi(this.midi) {
    _jsObject = midi._jsObject['GeneralMIDI'];
  }

  /**
   * the original js api is byId although there is an id field which has nothing to do
   */
  GeneralMidiInstrument getByNum(int num) {
    JsObject jsByNum = _jsObject['byId'];
    //print(jsObjectAsMap(midi._jsObject));
    //print(jsObjectKeys(midi._jsObject));
    //print(jsObjectAsMap(jsByNum));
    return new GeneralMidiInstrument(this, jsByNum[num]);
  }

  /**
     * the original js api is byName although it works for name and id
     */
  GeneralMidiInstrument getById(String id) {
    JsObject jsById = _jsObject['byName'];
    //print(jsObjectAsMap(midi._jsObject));
    //print(jsObjectKeys(midi._jsObject));
    //print(jsObjectAsMap(jsById));
    return new GeneralMidiInstrument(this, jsById[id]);
  }


}
