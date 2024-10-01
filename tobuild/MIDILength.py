from mido import MidiFile
mid = MidiFile('buffer_vgmmidi.mid')
print(int(mid.length))