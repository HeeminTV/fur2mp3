const fs = require('fs');
const floor = require('mathjs');
require('dotenv').config();
//const { Client, GatewayIntentBits, ActivityType, EmbedBuilder } = require('discord.js');
const { Client, GatewayIntentBits, ActivityType, EmbedBuilder, PresenceUpdateStatus } = require('discord.js');

const bot = new Client({ 
    restRequestTimeout: 60000,
    intents: [
        GatewayIntentBits.Guilds, 
        GatewayIntentBits.GuildMembers, 
        GatewayIntentBits.GuildMessages, 
        GatewayIntentBits.MessageContent
    ]
});

function getFilesizeInBytes(filename) {
    const stats = fs.statSync(filename);
    return stats.size;
}

const get = require("async-get-file");
const async = require("async");

function unixTimestamp() {  
    return Math.floor(Date.now() / 1000);
}

const { spawnSync, execSync, execFileSync, exec } = require('child_process');

const ConfigData = JSON.parse(fs.readFileSync(require('path').join(__dirname, '..', 'settings.json'), 'utf-8'));
const Fur2mp3ResendCooldown = ConfigData.settings.fur2mp3ResendCooldown;
const fur2mp3 = ConfigData.settings.commandName;
const midiMaxSize = ConfigData.settings.midiMaxSize;
const prefix = ConfigData.settings.prefix;
const botToken = ConfigData.settings.token;
const defaultStatus = ConfigData.settings.defaultStatus;

bot.on('ready', async () => {
    const guild = bot.guilds.cache.get(ConfigData.settings.serverid); // 서버 ID 가져오기
    console.log('Ready to render chiptune files!' + `
                               .::.                                             
=%%%%%:                      +@@@@@@*                                           
%%*                          .%.  .@@                                           
%%%%%%.=%%     #%%  *%%%%%:.....  #@@                                           
%%*    =%%     #%%  %%#   .     +@@@                                            
%%*    =%%     #%%  %%#       -@@@:                                             
%%*    =%%     #%%  %%#      @@@@@@@@+       .                     .-*##*:      
%%*     %%%%%%%%%%  %%#                                         =@@@+-@@@@@.    
                             :++++-+%%#: -#%%+.  .+++++-#%%+.    %#  .@@@@@     
                ....        :@@@@@@@@@@@@@@@@@@ .@@@@@@*@@@@@=    .=@@@@@:      
                :-:        .@@@@@-=@@@@@ %@@@@+ @@@@@@ .@@@@@:   %%@@@@@+       
                +*=        @@@@@-:@@@@@.*@@@@# #@@@@@. @@@@@*      -@@@@@       
                %@#       %@@@@+.@@@@@:-@@@@@.*@@@@@=.@@@@@=#@@   +@@@@@.       
                *@@:     =@@@@@ @@@@@:.@@@@@.-@@@@@@@@@@%:  -@@@@@@@@-.         
                .@@@-                .@@@@@ .@@@@@=                             
                 .@@@@-            .@@@@@@..@@@@@%                              
                   #@@@@@@-....-%@@@@@@@=  =####*                               
                     +@@@@@@@@@@@@@@@@-                                          
                        .:*@@@@@%=..                                             
`);

    setInterval(() => {
        const statusFilePath = 'temp_furrendering.txt';

        if (fs.existsSync('temp_osccodec.txt')) {
            let statusMessage;
            if (fs.existsSync('temp_oscout 20MB.mp4')) {
                const percentage1 = getFilesizeInBytes('temp_oscout 20MB.mp4') / (1024 * 1024);
                const percentage2 = percentage1 * 5;
                const percentage4 = percentage2.toFixed(2) + '%';
                statusMessage = fs.readFileSync(statusFilePath, 'utf8').trim() + ' ' + percentage4;
            } else {
                statusMessage = fs.readFileSync(statusFilePath, 'utf-8').trim();
            }

            bot.user.setPresence({
                activities: [{ name: statusMessage, type: ActivityType.Watching }],
                status: 'dnd'
            });
        } else {
            bot.user.setPresence({
                activities: [{ name: defaultStatus, type: ActivityType.Playing }],
                status: 'idle'
            });
        }
    }, 20000); // 20초마다 실행
});bot.on("messageCreate", async function(message) {
    // message 작성자가 봇이면 그냥 return
    if (message.author.bot) return;
    if (!message.content.startsWith(prefix)) return;

    const commandBody = message.content.slice(prefix.length);
    const args = commandBody.split(' ');
    const command = args.shift().toLowerCase();
    
   // if (command === "test99999999999999") {
	if (command === fur2mp3) {
	let TargetMessage = {};

    // 메시지가 답장 메시지인지 확인
	if (message.attachments.size > 0) {
		// 먼저 현재 메시지에서 첨부파일을 확인
		TargetMessage.attachments = message.attachments;
	} else if (message.reference) {
		// 답장된 메시지가 있는 경우 해당 메시지에서 첨부파일 확인
		const repliedMessage = await message.channel.messages.fetch(message.reference.messageId);
		TargetMessage.attachments = repliedMessage.attachments;
	} else {
		TargetMessage.attachments = message.attachments;
	}



	var userPing = '<@' + message.author.id + '>';
		//시발 그럼 가볼까ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ
    if (fs.existsSync('temp_furrendering.txt')) {
		if(fs.existsSync('temp_osccodec.txt')){
			if(fs.existsSync('output_temp_oscout 20MB.mp4')){//f
			var percentage1 = getFilesizeInBytes('output_temp_oscout 20MB.mp4') / (1024*1024);
			var percentage2 = percentage1 * 5;
			var percentage3 = percentage1 * 4;
			var percentage4 = percentage2.toString().substr(0, 5) + '%';
			message.channel.send(userPing + ' ' + 'Another file is being processed! Please wait!\n> Status: ' + fs.readFileSync('temp_furrendering.txt', 'utf8').trim() + '... ' + percentage4.toString());
			return;
			} else {
			message.channel.send(userPing + ' ' + 'Another file is being processed! Please wait!\n> Status: ' + fs.readFileSync('temp_furrendering.txt', 'utf8').trim() + '...');////.slice() + '...');//'
			return;
			}
		} else {
			message.channel.send(userPing + ' Another file is being processed! Please wait!');
			return;
		}
    }
	var opti = '';
	const supportedfurformats = [".fur", ".dmf", ".mod", ".s3m", 
	//".xm", ".it", // **.xm and .im have been disabled because they take a very long time to render in furnace.**
	".fc13", ".fc14", ".smod", ".fc", ".ftm", ".0cc", ".dnm", ".eft", ".fub", ".tfe"
	];
	const supportedvgmformats = [".ay", ".gbs", ".gym", ".hes", ".kss", ".nsf", ".nsfe", ".sap", ".sfm", ".sgc", ".spc", ".vgm", ".vgz", ".spu"];
	const supportedidkformats = [".sid", ".fms", ".mid", ".ym"];//, ".rmi"];
	const WillBeFilteredZXT = [
		".asc",
		".ftc",
		".gtr",
		".psc",
		".psg",
		".psm",
		".pt1",
		".pt2",
		".pt3",
		".sqt",
		".stc",
		".st1", // yeah i stole this list fro m AY MACHINE >:)
		".st3",
		".stp",
		".vtx",
		".chi",
		".dmm",
		".dst",
		".et1",
		".pdt",
		".sqd",
		".str",
		".tfc",
		".tfd",
		".tfe",
		".669",
		".amf",
		".dmf",
		".far",
		".fnk",
		".gdm",
		".imf",
		".it",
		".liq",
		".mdl",
		".mtm",
		".ptm",
		".rtm",
		".s3m",
		".stim",
		".stm",
		".stx",
		".ult",
		".xm",
		".dbm",
		".emod",
		".mod",
		".mtn",
		".ims",
		".med",
		".okt",
		".pt36",
		".sfx",
		".ahx",
		".dtm",
		".gtk",
		".tcb",
		".sap",
		".dtt",
		".cop",
		".sid",
		".ayc",
		".spc",
		".mtc",
		".vgm",
		".gym",
		".nsf",
		".nsfe",
		".gbs",
		".gsf",
		".hes",
		".kss"
		];	

	const WithOutZXT = [
	  ...supportedfurformats,
	  ...supportedvgmformats,
	  ...supportedidkformats,
	 // ...supportedzxtformatsFUCKINGW
	];
	let supportedzxtformats = WillBeFilteredZXT.filter(item => !WithOutZXT.includes(item));

		const supportedfileformats = [
	  ...WithOutZXT,
	  ...supportedzxtformats
	];
	const sendErr = ' An error occurred in the file transfer process. Try `$' + fur2mp3 + ' resend`.';
	const nofileErr = ' An error occurred during rendering! Try again with other files!';//ua
	const currentfnnc = 'Current Furnace Tracker Version : **0.6.7**'
	const currentsid = 'Current sidplayfp Version : **2.9.0**'
	const currentvgm = 'Current multidumper Version : **May 13, 2022**\nCurrent SoX Version : **14.4.2**';//MULT
	const currentfms = 'Current FamiStudio Version : **4.2.1**';
	//const currentmpt = 'Current openmpt123 Version : **0.7.9**';
	const currentmid = 'Current TiMidity++ Version : **2.15.0**';//;';
	const currentzxt = 'Current zxtune123 Version : **r5070**';
	const currentym = 'Current YMtoVGM Version : **v1.0.0**';
	const currentm2v = 'Current midi2vgm Version : **v0.0.1**';
	const currentcrr = 'Current corrscope Version : **0.9.1**';
	const currentver = [
	 currentfnnc,
	 currentsid,
	 currentvgm,
	 currentfms,
	 currentmid,
	 currentzxt,
	 currentym,
	 currentm2v,
	 currentcrr
	];
	//var currentsidalt = 'Current SID2WAV Version : **1.8**'message.guild.channels.cache.get(AutoPostChannelID).toString()
	//const extramessage = 'This bot is not hosted and is unstable. If the command doesn\'t work, the developer is either testing me or I\'m dead.'
	var usg2 = '\n`<Loops / Length>` : How many times the song should loop, Enter `0` if you do not want to. (Maximum vaule is `4`) In `.sid` and other modes, you must enter a length here. (Seconds)\n`<Subsong>` : Subsong to access and render. (starting from `1`)\n`<Osc, Vid Codec>` : Renders oscilloscope if set to `1` or `2`. Put `1` if you want to render your video using `H265 Codec` (High quality but slow), or put `2` if you want to render your video using `H264 Codec` (Poor quality but fast). **The encoding will not proceed if the exported file is less than 20MB.**';//\n`<Autopost>` : Posts your work in ' + 'somewhere in heemin\'s discord channel' + ' automatically if set to `1` or `y` or `on`.\n`<ID3 Title>` : Custom MP3 Title tag.'
	var usage = 
	userPing + 
	' Usage: `$' + fur2mp3 + ' <Loops / Length> <Subsong> <Osc, Vid Codec>`' + 
	'\nSupported File Formats For Oscilloscope Video Rendering: ' + ' `' + WithOutZXT.join(' ') + 
	'`\n' + '\nUnsupported File Formats For Oscilloscope Video Rendering: ' + ' `' + supportedzxtformats.join(' ') + '`' + 
	'\n\nYou need to send your file with this command!\nYou can see the progress using `$' + fur2mp3 + '` command during the rendering oscilloscope video!\n' + 
	usg2 + '\n\n' + currentver.join('\n') + '\n\nTo get more informations, see this online manual! https://gimmick32ndanniversary.neocities.org/fur2mp3manual';//\n\n*' + 
	//extramessage + '*';
	const gwavs = 'Your file has been rendered successfully!';
	const VauleWrong1 = 'The parameter `<';
	const VauleWrong2 = '>` is invalid!';
	const MaxLength = 601;
	if(!args[0] == ''){if(args[0].toString().toUpperCase() == 'RESEND'){
		
				if(!fs.existsSync('temp_furresendcooldown.txt')){fs.appendFileSync('temp_furresendcooldown.txt',(Number(unixTimestamp()) - 1).toString());}//}
				var readfromfurcooldown = fs.readFileSync('temp_furresendcooldown.txt');
				//if( 150 100
				if(Number(readfromfurcooldown) >= Number(unixTimestamp())){message.channel.send(userPing + ' Please wait for **' + (Number(readfromfurcooldown) - Number(unixTimestamp())) + '** seconds!');return;}// else {fs.writeFileSync('temp_furresendcooldown.txt','0');}//nr}
				var sendFilelist = [];
				//message.channel.send('```\n' + Number(readfromfurcooldown) + Number(unixTimestamp()) + '```\n```' + (Number(fs.readFileSync('temp_furresendcooldown.txt')) - Number(unixTimestamp())) + '```');
				if(fs.existsSync('output_furoutput.mp3')){ sendFilelist.push('output_furoutput.mp3');}if(fs.existsSync('output_temp_oscout 20MB.mp4')){ sendFilelist.push('output_temp_oscout 20MB.mp4');}
				
									if(!sendFilelist.length == 0){	try{ message.channel.send(userPing + ' Sending...'); await message.channel.send({ content: userPing + ' ', files: sendFilelist }); fs.writeFileSync('temp_furresendcooldown.txt', (Number(unixTimestamp()) + Fur2mp3ResendCooldown).toString());return;}catch(err){message.channel.send(userPing + sendErr);console.error(err);return;}//}fs.writeFileSync('temp_furresendcooldown.txt', Number(unixTimestamp()) + 30);return;}catch(err){message.channel.send(userPing + sendErr);console.error(err);return;}//}
					//else {return;}
} else { message.channel.send(userPing + ' No output files found!');return;}//There are no
}}
	    if(TargetMessage.attachments.first()){
			//if(!multiSearchOr(TargetMessage.attachments.first().name.toLowerCase(), supportedfileformats) )
			if (!supportedfileformats.some(char => TargetMessage.attachments.first().name.toLowerCase().endsWith(char))){ message.channel.send(userPing + ' Invalid file format! Only `' + supportedfileformats.join(' ') + '` files are allowed!'); return;}//checks if an attachment is sent

			var AttachmentName = await TargetMessage.attachments.first().name;
			if(AttachmentName.toLowerCase().endsWith('.sid')) { var RenderMode = 2;} 
			else if(AttachmentName.toLowerCase().endsWith('.fms')) { var RenderMode = 4; }
			
			else if(AttachmentName.toLowerCase().endsWith('.mid')){
				if( TargetMessage.attachments.first().size > midiMaxSize){
					message.channel.send(userPing + ' Your file is too big! Maximum size is `' + (midiMaxSize / 1000000) + 'MB` in MIDI mode!');
					return;
				} else {
					var RenderMode = 6;
				}
			}
			else if(AttachmentName.toLowerCase().endsWith('.ym')) { var RenderMode = 5; } 
			else if (supportedfurformats.some(char => AttachmentName.toLowerCase().endsWith(char))){ var RenderMode = 1;}
			else if (supportedvgmformats.some(char => AttachmentName.toLowerCase().endsWith(char))){ var RenderMode = 3;}
			else if (supportedzxtformats.some(char => AttachmentName.toLowerCase().endsWith(char))){ var RenderMode = 8;}
			else {message.channel.send('Error! Variable `RenderMode` has undefined mode!');return;}
			if(args[0] == null){//fɜr·tuːˌem.piːˈθriː
				var FurLoopVaule = '0';
				var LoopVaule = '180';
				if(RenderMode == '1'){
					var InfoLoop = 'No Loops';
				} else {
					var InfoLoop = LoopVaule;
			}
			} else if(isNaN(args[0])){
					message.channel.send(userPing + ' ' + VauleWrong1 + 'Loops / Length' + VauleWrong2 + '\nMust be a number!');
					return;
				//}
			} else {
				if(RenderMode == '1'){
					if(Number(args[0]) <= -1){
						message.channel.send(userPing + ' ' + VauleWrong1 + 'Loops / Length' + VauleWrong2 + '\nMinimum number is `0`!');
						return;
					} else if(Number(args[0]) >= 5){
						message.channel.send(userPing + ' ' + VauleWrong1 + 'Loops / Length' + VauleWrong2 + '\nMaximum number is `4`!');
						return;
					} else {
						var FurLoopVaule = args[0];
						var InfoLoop = args[0] == '0' ? 'No Loops' : args[0];
					}
				} else if(RenderMode == '6'){
					if(Number(args[0]) <= -2){
						message.channel.send(userPing + ' ' + VauleWrong1 + 'Standard / OPL3 Bank' + VauleWrong2 + '\nMinimum number is `0`!');
						return;
					} else if(Number(args[0]) >= 78){
						message.channel.send(userPing + ' ' + VauleWrong1 + 'Standard / OPL3 Bank' + VauleWrong2 + '\nMaximum number is `77`!');
						return;
					} else {
						var FurLoopVaule = args[0];
						var InfoLoop = args[0];
					}
				} else {
					//if(!RenderMode == '7'){
						if(Number(args[0]) <= 0){
							message.channel.send(userPing + ' ' + VauleWrong1 + 'Loops / Length' + VauleWrong2 + '\nMinimum number is `1`!');
							return;
						} else if(Number(args[0]) >= 601){
							message.channel.send(userPing + ' ' + VauleWrong1 + 'Loops / Length' + VauleWrong2 + '\nMaximum number is `600`!');
							return;
						} else {
							var LoopVaule = args[0];
							var InfoLoop = args[0];
						}
					//}
				}
			}
						
					
			if(args[1] == null){
				var FurSubsongVaule = '0';
				var SubsongVaule = '1';
				if(RenderMode == '1'){
					var InfoSubs = '1';
				} else {
					var InfoSubs = SubsongVaule;
				}
			} else if(isNaN(args[1])){
					message.channel.send(userPing + ' ' + VauleWrong1 + 'Subsong' + VauleWrong2 + '\nMust be a number!');
					return;
				//}
			} else if(Number(args[1]) <= 0){
				if(RenderMode == '7'){
					var SubsongVaule = args[1];	
					var InfoSubs = args[1];
				} else {
					message.channel.send(userPing + ' ' + VauleWrong1 + 'Subsong' + VauleWrong2 + '\nMinimum number is `1`!');
					return;
				}
			} else {
				var SubsongVaule = args[1];
				var FurSubsongVaule = (Number(args[1]) - 1);
				var InfoSubs = args[1];
			}

			if(args.join(' ').includes('.') || args.join(' ').includes('"')|| args.join(' ').includes("'")){ message.channel.send(usage, {split:true});return;}

				const sentMessage = await message.reply('Downloading...');
				execSync('fur2mp3reset.bat && del /q output_*');

			if(RenderMode == '2'){
				var options = {filename: "temp_sid.sid"};//var options = {
				var whattoexec = 'SIDRender.bat';
				var opti = '-t' + LoopVaule + ' -o' + SubsongVaule;
				
			} else if(RenderMode == '3'){
				var whattoexec = 'VGMRender.bat';
				var opti = (Number(SubsongVaule) -1) + ' --play_length=' + (Number(LoopVaule) * 1000);
				var options = {filename: "temp_vgminput.vgm"};
				
			} else if(RenderMode == '4'){
				var opti = (Number(SubsongVaule) -1) + ' "--play_length=' + (Number(LoopVaule) * 1000) + '"';
				var options = {filename: "temp_fmsinput.fms"};
				var whattoexec = 'FMSRender.bat';
				
			} else if(RenderMode == '8'){
				//var opti = '';
				var whattoexec = 'ZXTRender.bat';
				var fname = TargetMessage.attachments.first().name;
				var ext1 = fname.toString().split('.');
				var ext2 = ext1.pop();
				var options = {filename: 'temp_zxt.' + ext2};
				var opti = options.filename.toString();
			
			} else if(RenderMode == '6'){
				var whattoexec = 'MIDRender.bat';
				//var opti = '';
				var opti = args[0] == null || args[0] == '' ? '-1' : FurLoopVaule;
				var options = {filename: "temp_mid.mid"};
				if(TargetMessage.attachments.toJSON()[1] && TargetMessage.attachments.toJSON()[1].name.toString().toLowerCase().endsWith('.sf2')){//if(TargetMessage.attachments.array()[1].name.toString().toLowerCase().endsWith('.sf2')){
					if(fs.existsSync('temp_sf2.sf2')){fs.unlinkSync('temp_sf2.sf2');}
					var sfsf = TargetMessage.attachments.toJSON()[1].name.toString();
					await get(TargetMessage.attachments.toJSON()[1].url,{filename: "temp_sf2.sf2"});
				} else {
					var sfsf = 'SC-55.sf2';
				}

			} else if(RenderMode == '5'){
				var whattoexec = 'YMRender.bat';
				var opti = '--play_length=' + (Number(LoopVaule) * 1000);
				var options = {filename: "temp_ym.ym"};
				
			} else {
				var whattoexec = 'FURRender.bat';
				var opti = '-subsong ' + FurSubsongVaule + ' -loops ' + FurLoopVaule;
				var options = {filename: "temp_furinput.fur"};
			}
			await get(TargetMessage.attachments.first().url,options);

					if(args[2] == null){
						//var increasing = '** **'; 
						var osc = 0;
						var oscinfo = 'Off';
						
					} else if (Number(args[2]) >= 0 && Number(args[2]) <= 4){

						var osc = 1; 
						if(args[2].toString() == '2'){
							fs.writeFileSync('temp_osccodec.txt', 'h264_');
							var oscinfo = 'On, H264';
						} else if(args[2].toString() == '1'){
							fs.writeFileSync('temp_osccodec.txt', 'libx265');
							var oscinfo = 'On, H265';
						}
					}
	if(osc == 1){
		var infoid3 = '\nOscilloscope Video Rendering: **' + oscinfo + '**'; 
		var altz = '\n' + currentcrr;
	} else { 
		var infoid3 = '\nOscilloscope Video Rendering: **Off**';//\nMP3 ID3 Title: **' + id3tag + '**'; 
		var altz = '';
	}

	if(RenderMode == '2' || RenderMode == '3' || RenderMode == '4'){
		var info = '\n\nLength: **' + InfoLoop + ' Seconds**\n' + 'Track No.: **' + InfoSubs + '**' + infoid3;
	} else if(RenderMode == '6'){
		var info = opti == '-1' ? `\n\nSoundfont: **${sfsf}**${infoid3}` : `\n\nOPL3 Bank: **${args[0].toString()}**${infoid3}`;
	} else if(RenderMode == '8'){
		var info = '\n\n';
	} else if(RenderMode == '5'){
		var info = '\n\nLength: **' + InfoLoop + ' Seconds**' + infoid3;
	} else {
		var info = '\n\nLoops: **' + InfoLoop + '**\nSubsong Number: **' + InfoSubs + '**' + infoid3;
	}

				switch (RenderMode) {
					case 2:
						var currentfnncarg = currentsid;
						break;
					
					case 3:
						var currentfnncarg = currentvgm;
						break;
						
					case 4:
						var currentfnncarg = currentfms + '\n' + currentvgm;
						break;
						
					case 5:
						var currentfnncarg = currentvgm + '\n' + currentym;
						break;
						
					case 6:
						var currentfnncarg = opti == '-1' ? currentmid : `${currentvgm}\n${currentm2v}`;
						break;
						
					case 8:
						var currentfnncarg = currentzxt;
						break;
					
					default:
						var currentfnncarg = currentfnnc;
				}
				
				fs.writeFileSync('temp_furrendering.txt', 'Rendering');
				await sentMessage.edit(currentfnncarg + altz + '\nRendering started!' + info);
					await exec(whattoexec + ' ' + opti.toString(), { stdio: []},(error, stdout, stderr) => { 
							console.error(stderr, stdout); 
							if(RenderMode == '8'){
								var sendfilelist1 = ["output_zxtout.mp3"];
							} else {
								if(osc == 1){ 
									var sendfilelist1 = ["output_temp_oscout 20MB.mp4"];
								} else {
									var sendfilelist1 = ["output_furoutput.mp3"];
								}
							}
							
							if(!fs.existsSync(sendfilelist1.join(''))){
								if(!fs.existsSync('temp_fur2mp3error.txt')){
									message.channel.send(userPing + nofileErr);
								} else {
									message.channel.send(userPing + nofileErr + '\n> Defined error : ' + fs.readFileSync('temp_fur2mp3error.txt'));
								}
								execSync('fur2mp3reset.bat');
								return;
							}
								if(getFilesizeInBytes(sendfilelist1.join('')) > 25780189){
									message.channel.send(userPing + nofileErr + '\n> Defined error : Compression failed!');
									execSync('fur2mp3reset.bat');
									return;
								}
								if(RenderMode == '8'){
									message.reply({
										content: gwavs,
										files: [ 'output_zxtout.mp3' ]
									});
								} else {
									message.reply({
										content: gwavs,
										files: sendfilelist1 
									});
								}
							execSync('fur2mp3reset.bat');
							return;
	
				});
		} else {
			   message.reply(usage, {split:true});
			   return;
    }}
	});
bot.login(botToken);