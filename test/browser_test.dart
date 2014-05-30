library browser_test;

import 'package:unittest/html_config.dart';
import 'common_app.dart';

String ROOT_URL = "packages/tekartik_midi_js";
main() {
  useHtmlConfiguration();
  // must be first
  group('load', () {
    test('loaded', () {
      expect(new MidiJs().loaded, isFalse);
      new MidiJsLoader(ROOT_URL).midi.then((MidiJs midi) {
        expect(midi.loaded, isTrue);
        expect(new MidiJs().loaded, isTrue);
      });
    });
  });

  group('general midi', () {
    MidiJs midi;
    setUp(() {
      if (midi == null) {
        return new MidiJsLoader(ROOT_URL).midi.then((MidiJs midi_) {
          midi = midi_;
        });
      }
    });
    test('piano', () {
      GeneralMidiInstrument instrument = midi.generalMidi.getByNum(0);
      expect(instrument.id, ACOUSTIC_GRAND_PIANO_ID);
      expect(instrument.num, 0);
      expect(instrument.name, 'Acoustic Grand Piano');
      instrument = midi.generalMidi.getById(ACOUSTIC_GRAND_PIANO_ID);
      expect(instrument.id, ACOUSTIC_GRAND_PIANO_ID);
      expect(instrument.num, 0);
      expect(instrument.name, 'Acoustic Grand Piano');
    });

    test('synth_drum', () {
      GeneralMidiInstrument instrument = midi.generalMidi.getByNum(118);
      expect(instrument.id, SYNTH_DRUM_ID);
      expect(instrument.num, 118);
      expect(instrument.name, 'Synth Drum');
      instrument = midi.generalMidi.getById(SYNTH_DRUM_ID);
      expect(instrument.id, SYNTH_DRUM_ID);
      expect(instrument.num, 118);
      expect(instrument.name, 'Synth Drum');
    });

    test('all', () {
      for (int num = 0; num < 128; num++) {
        GeneralMidiInstrument instrument = midi.generalMidi.getByNum(num);
        print(instrument);
        expect(instrument.num, num, reason: "testing num $num");
      }
    });
  });
}
