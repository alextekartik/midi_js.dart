library demo_basic;

import 'common_app.dart';

void main() {
  MidiJs ctlr = new MidiJs("packages/tekartik_midi_js/soundfont/");
  print('loading...');
  ctlr.loadInstruments(['acoustic_grand_piano', "synth_drum"]).then((_) {
    print('loaded');
    ctlr.programChange(0, 1);
    ctlr.programChange(1, 118);
    for (var n = 0; n < 100; n++) {
      var delay = n / 4; // play one note every quarter second
      var note = ctlr.pianoKeyOffset + n; // the MIDI note
      var velocity = 127; // how hard the note hits
      // play the note
      ctlr.noteOn(0, note, velocity, delay);
      // play the some note 3-steps up
      ctlr.noteOn(1, note + 3, velocity, delay);
    }
  });
}
