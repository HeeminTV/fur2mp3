# fur2mp3
A powerful Discord bot that renders almost every chiptune format!

# Requirements
- Node.js (npm)
- Python 3

# Setup
1. Run `setup.bat`
  - It downloads other softwares like "[Furnace](https://github.com/tildearrow/furnace)" and "[corrscope](https://github.com/corrscope/corrscope)". (~~not the latest version~~)
2. Configure a few essentials like bot token and server ID
  - Refer to line 52 of `tobuild\index.js`.
3. Launch `run.bat` to start the bot.
# [Usage](https://gimmick32ndanniversary.neocities.org/fur2mp3manual)

# Things to know
By default, when this bot starts, it copies all files inside `tobuild\` to `build\`. So you will need to modify `tobuild\index.js` and not `build\index.js`.
Also, if you get an update from [Release](https://github.com/HeeminTV/fur2mp3/releases), you just need to overwrite all the files in that `*.zip` file. (You will need to reconfigure. See step 2.)

# Credits

Playback and rendering uses the following libraries/external applications.
- Furnace: https://github.com/tildearrow/furnace/
- sidplayfp: https://sourceforge.net/projects/sidplay-residfp/
- multidumper: https://github.com/maxim-zhao/multidumper/
- SoX: https://sourceforge.net/projects/sox/
- normalize: https://neon1.net/prog/normalizer.html
- FamiStudio: https://famistudio.org/
- MIDIRenderer: https://github.com/getraid-gg/MIDIRenderer/
- zxtune123: https://zxtune.bitbucket.io/
- YMtoVGM: https://github.com/QuinnPainter/YMtoVGM/
- midi2vgm: https://github.com/SudoMaker/midi2vgm/
- corrscope: https://github.com/corrscope/corrscope
