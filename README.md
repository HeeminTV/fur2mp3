# fur2mp3
A powerful Discord bot that renders almost every chiptune format!

# Requirements
- Node.js (npm)
- Python 3

# Setup
1. Run `setup.bat`
  - It downloads other softwares like "[Furnace](https://github.com/tildearrow/furnace)" and "[corrscope](https://github.com/corrscope/corrscope)". (~~not the latest version~~)
2. Configure a few essentials like bot token ~~and server ID~~
  - ~~Refer to line 52 of `tobuild\index.js`.~~
  - Go to the section "[**Configure `settings.json`**](https://github.com/HeeminTV/fur2mp3?tab=readme-ov-file#configure-settingsjson)"
3. Launch `run.bat` to start the bot.
# [Usage (Outdated)](https://gimmick32ndanniversary.neocities.org/fur2mp3manual)

# Configure `settings.json`
```json
{
	"settings": {
		"token": "YOUR_BOT_TOKEN",
		"prefix": "$",
		"commandName": "fur2mp3",
		"fur2mp3ResendCooldown": "60",
		"midiMaxSize": "200000",
		"defaultStatus": "corrscope.exe",
		"GPU": "NVIDEA: 1, INTEL ARC: 2, RADEON: 3, OTHERS / SOFTWARE: 4"
	},
	
	"oscilloscope": {
		"label": "true",
		"lineWidth": "2",
		"resWidth": "1920",
		"resHeight": "1080"
	}
}
```
  - `token` : Put your bot's token here
  - `prefix` : Set the command prefix (e.g. **$**fur2mp3)
  - `commandName` : Set the name of the command (e.g. $**fur2mp3**)
  - `fur2mp3ResendCooldown` : Set the request cooldown time in the `resend` command
  - `midiMaxSize` : Set the maximum size of `.mid` files
  - `defaultStatus` : Set the status message to use when the bot is in an idle state rather than rendering
  - `GPU` : Determines which GPU to use in oscilloscope rendering mode
  ** **
  - `label` : "true" enables text labels in oscilloscope rendering, any other value disables them
  - `lineWidth` : Set line width when rendering oscilloscope
  - `resWidth` : Determines the width of the video to be output
  - `resHeight` : Determines the height of the video to be output

# Things to know
By default, when this bot starts, it copies all files inside `tobuild\` to `build\`. So you will need to modify `tobuild\index.js` and not `build\index.js`.
~~Also, if you get an update from [Release](https://github.com/HeeminTV/fur2mp3/releases), you just need to overwrite all the files in that `*.zip` file. (You will need to reconfigure. See step 2.)~~

# Credits

Playback and rendering uses the following libraries/external applications.
- Furnace: https://github.com/tildearrow/furnace/
- sidplayfp: https://sourceforge.net/projects/sidplay-residfp/
- multidumper: https://github.com/maxim-zhao/multidumper/
- SoX: https://sourceforge.net/projects/sox/
- normalize: https://neon1.net/prog/normalizer.html
- FamiStudio: https://famistudio.org/
- ~~MIDIRenderer: https://github.com/getraid-gg/MIDIRenderer/~~
- TiMidity++: https://timidity.sourceforge.net/
- zxtune123: https://zxtune.bitbucket.io/
- YMtoVGM: https://github.com/QuinnPainter/YMtoVGM/
- midi2vgm: https://github.com/SudoMaker/midi2vgm/
- corrscope: https://github.com/corrscope/corrscope
