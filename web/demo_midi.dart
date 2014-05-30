library demo_basic;

import 'common_app.dart';
void main() {
  // test loader
  MidiJsLoader loader = new MidiJsLoader(posix.join('packages', 'tekartik_midi_js'));
  loader.midi.then((MidiJs midi) {
    //= new MidiJs("packages/tekartik_midi_js/soundfont/");
    print('loading...');
    midi.loadInstruments(['acoustic_grand_piano']).then((_) {
      print('loaded');
      var delay = 0; // play one note every quarter second
      var note = 50; // the MIDI note
      var velocity = 127; // how hard the note hits
      // play the note
      midi.setVolume(0, 127);
      midi.noteOn(0, note, velocity, delay);
      midi.noteOff(0, note, delay + 0.75);

      new Future.delayed(new Duration(seconds: 1), () {
        midi.loadInstruments(['synth_drum']).then((_) {
          print('loaded');
          var delay = 0; // play one note every quarter second
          var note = 50; // the MIDI note
          var velocity = 127; // how hard the note hits
          // play the note
          midi.programChange(0, 118);
          midi.setVolume(0, 127);
          midi.noteOn(0, note, velocity, delay);
          midi.noteOff(0, note, delay + 0.75);
        });
      });
    });

  });
}
