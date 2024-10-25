from mido import MidiFile
import sys
mid = MidiFile(sys.argv[1])
print(int(mid.length))