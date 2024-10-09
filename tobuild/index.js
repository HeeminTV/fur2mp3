bot.login(settings.token);
const {exec} = require('child_process');
const fs = require('fs');
const {floor} = require('mathjs');
require('dotenv').config();
const Discord = require('discord.js');
const ActivityType = require("discord.js");
const GatewayIntentBits = require("discord.js");
const bot = new Discord.Client({ 
	restRequestTimeout: 60000,
    presence: {
       /* activity: {
            name: 'Mr. Gimmick!',
            type: 'PLAYING'
        },
        status: 'idle',*/
		 intents: [
		 GatewayIntentBits.Guilds, 
		 GatewayIntentBits.GuildMembers, 
		 Discord.Intents.FLAGS.GUILDS,
         Discord.Intents.FLAGS.GUILD_MEMBERS
		 ] 
		/* ws: {
        intents: [
            Discord.Intents.FLAGS.GUILDS,
            Discord.Intents.FLAGS.GUILD_MEMBERS
        ]
    }*/
}});

function getFilesizeInBytes(filename) {
    var stats = fs.statSync(filename);
    var fileSizeInBytes = stats.size;
    return fileSizeInBytes;
}
  const get = require("async-get-file");
  const async = require("async");
  const { EmbedBuilder } = require('discord.js');
  function unixTimestamp () {  
  return Math.floor(Date.now() / 1000)
}
const { 
  spawnSync, 
  execSync, 
  execFileSync,
} = require('child_process');


// -----------------------------------User-set CONFIG value-------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

const Fur2mp3ResendCooldown = 60;
const fur2mp3 = "fur2mp3";
// ^ command name
const midiMaxSize = 200000;
// ^ midi mode max size (someone could upload black midi so it blpocks IN BYTES





const autopoststring = 'just dropped this amazing stuff! Come and listen!';
// ^ autosend 1 string
const AutoPostChannelID = '';
// ^ If 'Auto post' is enabled, the bot will send your file on the channel. you should put the ID of the channel

const prefix = "$";
	// ^ prefix. if it is set to "!" and command name is set to "chiprender", you should enter "!chiprender <parameters>" on discord.
const settings = {
	serverid: '',
	//PUT YOUR SERVER ID HERE^
	token: '',
	//PUT YOUR BOT'S TOKEN HERE^
};
// prefix
// -----------------------------------User-set CONFIG value-------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ----------------------------------------THE END :p  -----------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------

bot.on('ready', async () => {
	 const guild = bot.guilds.cache.get(settings.serverid);
	 console.log('Ready to render chiptune file formats!');
	 setInterval(() => {
     const statusFilePath = 'buffer_furrendering.txt';

    if (fs.existsSync(statusFilePath)) {
		if(fs.existsSync('buffer_oscout 20MB.mp4')){//f
			var percentage1 = getFilesizeInBytes('buffer_oscout 20MB.mp4') / (1024*1024);
			var percentage2 = percentage1 * 5;
			var percentage4 = percentage2.toString().substr(0, 5) + '%';
			var statusMessage = fs.readFileSync(statusFilePath, 'utf8').trim() + ' ' + percentage4.toString();//);
			
		} else {
			var statusMessage = fs.readFileSync(statusFilePath, 'utf-8').trim();
			
		}

        bot.user.setPresence({
            activity: { name: statusMessage, type: 'WATCHING' },
			status: 'dnd'
        });
    } else {
        const defaultStatus = "corrscope.exe";
        bot.user.setPresence({
            activity: { name: defaultStatus, type: 'PLAYING' }, // 기본적으로 "Playing Mr. Gimmick!"으로 설정
			status: 'idle'
        });
    }
}, 20000);  // 20초마다 실행
	 
	 
	 
	 
	 
	 
	 
	 
});
bot.on("message", async function(message) {
    // message 작성자가 봇이면 그냥 return
    if (message.author.bot) return;
	/*if (!message.author.username == 'heeminheemin') { message.channel.send('has been disabled for a while'); return;} else {
		message.channel.send(message.author.username);
	}*/
    // message 시작이 prefix가 아니면 return
    if (!message.content.startsWith(prefix)) return;

    const commandBody = message.content.slice(prefix.length);
    const args = commandBody.split(' ');
    const command = args.shift().toLowerCase();
    
   // if (command === "test99999999999999") {
	    if (command === fur2mp3) {
			    let TargetMessage = {};

    // 메시지가 답장 메시지인지 확인
if (message.attachments.size > 0) {
    // 먼저 답장한 메시지에서 첨부파일을 확인
    TargetMessage.attachments = message.attachments;
} else if (message.reference) {
    // 답장당한 메시지가 있으면 해당 메시지에서 첨부파일을 확인
    const repliedMessage = await message.channel.messages.fetch(message.reference.messageID);
    

    TargetMessage.attachments = repliedMessage.attachments;

} else {
	TargetMessage.attachments = message.attachments;
}


		   var userPing = '<@' + message.author.id + '>';
		//시발 그럼 가볼까ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ
		
		
			const filePath = 'buffer_furrendering.txt';
    
    if (fs.existsSync(filePath)) {
		if(fs.existsSync('buffer_osccodec.txt')){
			if(fs.existsSync('output_buffer_oscout 20MB.mp4')){//f
			var percentage1 = getFilesizeInBytes('output_buffer_oscout 20MB.mp4') / (1024*1024);
			var percentage2 = percentage1 * 5;
			var percentage3 = percentage1 * 4;
			if(Number(percentage3) > 100){ var percentage4 = 'Your file will probably be compressed again, as it is larger than **25MB**...'} else { var percentage4 = percentage2.toString().substr(0, 5) + '%';}
			message.channel.send(userPing + ' ' + 'Another file is being processed! Please wait!\nStatus: ' + fs.readFileSync('buffer_furrendering.txt', 'utf8').trim() + '... ' + percentage4.toString());
			return;
			} else {
			message.channel.send(userPing + ' ' + 'Another file is being processed! Please wait!\nStatus: ' + fs.readFileSync('buffer_furrendering.txt', 'utf8').trim() + '...');////.slice() + '...');//'
			return;
			}
		} else {
			message.channel.send(userPing + ' Another file is being processed! Please wait!');
			return;
		}
    }
	var opti = '';
	const supportedfurformats = [".fur", ".dmf", ".mod", ".s3m", ".xm", ".it", ".fc13", ".fc14", ".smod", ".fc", ".ftm", ".0cc", ".dnm", ".eft", ".fub", ".tfe"];
	const supportedvgmformats = [".ay", ".gbs", ".gym", ".hes", ".kss", ".nsf", ".nsfe", ".sap", ".sfm", ".sgc", ".spc", ".vgm", ".vgz", ".spu"];
	const supportedidkformats = [".sid", ".fms", ".mid", ".ym"];//, ".rmi"];
	const WillBeFilteredZXT = [//[
/*  "ASC",
  "FTC",
  "GTR",
  "PSC",
  "PSG",
  "PSM",
  "PT1",
  "PT2",
  "PT3",
  "SQT",
  "STC",
  "ST1",
  "ST3",
  "STP",
  "VTX",
  "YM",
  "CHI",
  "DMM",
  "DST",
  "ET1",
  "PDT",
  "SQD",
  "STR",
  "TFC",
  "TFD",
  "TFE",
  "669",
  "AMF",
  "DMF",
  "FAR",
  "FNK",
  "GDM",
  "IMF",
  "IT",
  "LIQ",
  "MDL",
  "MTM",
  "PTM",
  "RTM",
  "S3M",
  "STIM",
  "STM",
  "STX",
  "ULT",
  "XM",
  "DBM",
  "EMOD",
  "MOD",
  "MTN",
  "IMS",
  "MED",
  "OKT",
  "PT36",
  "SFX",
  "AHX",
  "DTM",
  "GTK",
  "TCB",
  "SAP",
  "DTT",
  "COP",
  "SID",
  "AYC",
  "SPC",
  "MTC",
  "VGM",
  "GYM",
  "NSF",
  "NSFe",
  "GBS",
  "GSF",
  "HES",
  "KSS"*/
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
//  이젠 아니라구 히히힣 ".ym",
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
];	const WithOutZXT = [
  ...supportedfurformats,
  ...supportedvgmformats,
  ...supportedidkformats,
 // ...supportedzxtformatsFUCKINGW
];
let supportedzxtformats = WillBeFilteredZXT.filter(item => !WithOutZXT.includes(item));
//message.channel.send('```\n' + supportedzxtformats + '```\n```' + supportedzxtformatsFUCKINGW + '```');
//console.log(filteredArr); // [1, 2, 5]

	const supportedfileformats = [
 /* ...supportedfurformats,
  ...supportedvgmformats,
  ...supportedidkformats,*///...supportedfileformats42,
  ...WithOutZXT,
  ...supportedzxtformats
];/*
const supportedfileformats = supportedfileformats2.filter((element, index) => {
    return supportedfileformats2.indexOf(element) === index;
});*/
	const sendErr = ' An error occurred in the file transfer process. Try `$' + fur2mp3 + ' resend`.';
	const nofileErr = ' An error occurred during rendering! Try again with other files!';//ua
	//var usg2 = '`<Loops>` : ';//Put loops cou
	var currentfnnc = 'Current Furnace Tracker Version : **0.6.7**'
	const currentnormalize = 'Current normalize Version : **0.253**'
	//var currentsidalt = 'Current SID2WAV Version : **1.8**'
	var currentsidalt = 'Current sidplayfp Version : **2.9.0**'
	var currentsid = currentsidalt + '\n' + currentnormalize
	const currentvgm = 'Current multidumper Version : **May 13, 2022**\nCurrent SoX Version : **14.4.2**\n' + currentnormalize;//MULT
	const currentfms = 'Current FamiStudio Version : **4.2.1**';
	const currentmpt = 'Current openmpt123 Version : **0.7.9**';
	const currentmid = 'Current MIDIRenderer Version : **1.1.3**';//;';
	const currentzxt = 'Current zxtune123 Version : **r5070**';
	const currentym = 'Current YMtoVGM Version : **v1.0.0**';
	const currentm2v = 'Current midi2vgm Version : **v0.0.1**';
	const currentcrr = 'Current corrscope Version : **0.9.1**';
	//var currentsidalt = 'Current SID2WAV Version : **1.8**'message.guild.channels.cache.get(AutoPostChannelID).toString()
	const extramessage = 'This bot is not hosted and is unstable. If the command doesn\'t work, the developer is either testing me or I\'m dead.'
	var usg2 = '\n`<Loops / Length>` : How many times the song should loop, Enter `0` if you do not want to. (Maximum vaule is `4`) In `.sid` and other modes, you must enter a length here. (Seconds)\n`<Subsong>` : Subsong to access and render. (starting from `1`)\n`<Osc, Vid Codec>` : Renders oscilloscope if set to `1` or `2`. Put `1` if you want to render your video using `H265 Codec` (High quality but slow), or put `2` if you want to render your video using `H264 Codec` (Poor quality but fast). **The encoding will not proceed if the exported file is less than 20MB.**\n`<Autopost>` : Posts your work in ' + 'somewhere in heemin\'s discord channel' + ' automatically if set to `1` or `y` or `on`.\n`<ID3 Title>` : Custom MP3 Title tag.'
	var usage = userPing + ' Usage: `$' + fur2mp3 + ' <Loops / Length> <Subsong> <Osc, Vid Codec> <Autopost> <ID3 Title>`' + '\nSupported File Formats For Oscilloscope Video Rendering: ' + ' `' + WithOutZXT.join(' ') + '`\n' + '\nUnsupported File Formats For Oscilloscope Video Rendering: ' + ' `' + supportedzxtformats.join(' ') + '`' + '\n\nYou need to send your file with this command!\nYou can see the progress using `$' + fur2mp3 + '` command during the rendering oscilloscope video!\n' + usg2 + '\n\n' + currentfnnc + '\n' + currentsidalt + '\n' + currentvgm + '\n' + currentfms + '\n' + currentmid + '\n' + currentzxt + '\n' + currentym + '\n' + currentm2v + '\n' + currentcrr + '\n\nTo get more informations, see this online manual! https://gimmick32ndanniversary.neocities.org/fur2mp3manual\n\n*' + extramessage + '*';
	const gwavs = 'Your file has been rendered successfully!';
	const VauleWrong1 = 'The parameter `<';
	const VauleWrong2 = '>` is invalid!';
	const MaxLength = 601;
	if(!args[0] == ''){if(args[0].toString().toUpperCase() == 'RESEND'){
		
				if(!fs.existsSync('buffer_furresendcooldown.txt')){fs.appendFileSync('buffer_furresendcooldown.txt',(Number(unixTimestamp()) - 1).toString());}//}
				var readfromfurcooldown = fs.readFileSync('buffer_furresendcooldown.txt');
				//if( 150 100
				if(Number(readfromfurcooldown) >= Number(unixTimestamp())){message.channel.send(userPing + ' Please wait for **' + (Number(readfromfurcooldown) - Number(unixTimestamp())) + '** seconds!');return;}// else {fs.writeFileSync('buffer_furresendcooldown.txt','0');}//nr}
				var sendFilelist = [];
				//message.channel.send('```\n' + Number(readfromfurcooldown) + Number(unixTimestamp()) + '```\n```' + (Number(fs.readFileSync('buffer_furresendcooldown.txt')) - Number(unixTimestamp())) + '```');
				if(fs.existsSync('output_furoutput.mp3')){ sendFilelist.push('output_furoutput.mp3');}if(fs.existsSync('output_buffer_oscout 20MB.mp4')){ sendFilelist.push('output_buffer_oscout 20MB.mp4');}
				
									if(!sendFilelist.length == 0){	try{ message.channel.send(userPing + ' Sending...'); await message.channel.send(userPing + ' ',{ files: sendFilelist }); fs.writeFileSync('buffer_furresendcooldown.txt', (Number(unixTimestamp()) + Fur2mp3ResendCooldown).toString());return;}catch(err){message.channel.send(userPing + sendErr);console.error(err);return;}//}fs.writeFileSync('buffer_furresendcooldown.txt', Number(unixTimestamp()) + 30);return;}catch(err){message.channel.send(userPing + sendErr);console.error(err);return;}//}
					//else {return;}
} else { message.channel.send(userPing + ' No output files found!');return;}//There are no
}}//if (['1','3','5','7','9'].some(char => profileID.endsWith(char))) {
  //...
//}
	    if(TargetMessage.attachments.first()){
			//if(!multiSearchOr(TargetMessage.attachments.first().name.toLowerCase(), supportedfileformats) )
				if (!supportedfileformats.some(char => TargetMessage.attachments.first().name.toLowerCase().endsWith(char)))//)// {
  //...
//}
				{ message.channel.send(userPing + ' Invalid file format! Only `' + supportedfileformats.join(' ') + '` files are allowed!'); return;}//checks if an attachment is sent

			var AttachmentName = await TargetMessage.attachments.first().name;//".ftm", ".dnm", ".0cc", ".fur", ".mod", ".xm", ".dmf", ".sid", ".vgm", ".nsf", ".spc"
			if(AttachmentName.toLowerCase().endsWith('.sid')) { var RenderMode = 2;} 
			else if(AttachmentName.toLowerCase().endsWith('.fms')) { var RenderMode = 4; }
			
			else if(AttachmentName.toLowerCase().endsWith('.mid')){// || AttachmentName.toLowerCase().endsWith('.rmi')) { 
				//var sidmode = 0; var vgmmode = 0; var fmsmode = 0; //var midmode = 1;
				if( TargetMessage.attachments.first().size > midiMaxSize){message.channel.send(userPing + ' Your file is too big! Maximum size is `' + (midiMaxSize / 1000) + 'KB` in MIDI mode!');return;
				} else {
					//if(AttachmentName.toLowerCase().endsWith('.rmi')){ var rmi = 1;} else { var rmi = 0;}
					if(args[1] == null || args[1] == '-1'){ var RenderMode = 6;} else if(isNaN(args[1])){ message.channel.send(userPing + ' ' + VauleWrong1 + 'OPL3 Bank' + VauleWrong2 + '\nMust be a number!');return;}
					else if(Number(args[1].replaceAll('.', '')) >= 78 || Number(args[1].replaceAll('.', '')) <= -2){ message.channel.send(userPing + ' ' + VauleWrong1 + 'OPL3 Bank' + VauleWrong2);return;
					} else { var RenderMode = 7;}
			
				}
			}
			else if(AttachmentName.toLowerCase().endsWith('.ym')) { var RenderMode = 5;} 
			else if (supportedfurformats.some(char => AttachmentName.toLowerCase().endsWith(char))){ var RenderMode = 1;}
			else if (supportedvgmformats.some(char => AttachmentName.toLowerCase().endsWith(char))){ var RenderMode = 3;}
			else if (supportedzxtformats.some(char => AttachmentName.toLowerCase().endsWith(char))){ var RenderMode = 8;}
			else {message.channel.send('fucl');return;}
			if(args[0] == null){//fɜr·tuːˌem.piːˈθriː
				var FurLoopVaule = '0';
				var LoopVaule = '180';
				if(RenderMode == '1'){
					var InfoLoop = 'No Loops';
				} else {
					var InfoLoop = LoopVaule;
			}
			} else if(isNaN(args[0]) && !(args[0].toLowerCase() == 'auto' && RenderMode == '7')){
				//if(!RenderMode == '7' || !args[0].toLowerCase() == 'auto'){
					
				//} else {
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
				//if(!RenderMode == '7' || !args[0].toLowerCase() == 'auto'){
					
				//} else {
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
// else subs = arg[1].toString();}//}
if(args.join(' ').includes('.') || args.join(' ').includes('"')|| args.join(' ').includes("'")){ message.channel.send(usage, {split:true});return;}//|||
//message.channel.send('```' + loop + subs + '```');
//var opti = loop + subs;
// 원래 여기엮ㅆᄋᅠᆼ니var opti = subs + loop;
if(!args[4] == ''){
//	let arr = ['a', 'b', 'c', 'd', 'e', 'f', 'g'];

// 첫 번째부터 두 번째까지는 그대로 유지하고, 그 이후는 하나로 묶음
var result = [
    ...args.slice(0, 3), // 처음 3개의 요소를 그대로 유지
    args.slice(3).join(' ') // 3번째 이후의 요소를 하나로 묶어서 결합
];
	
	var id3tag = result[3];
	
} else { var id3tag = AttachmentName;}//'
//message.channel.send(id3tag);
fs.writeFileSync('buffer_fur2mp3id3title.txt', id3tag);
if(args[3] == null){ var autopost = '0';} else { if(args[3].toString() == '1'){var autopost = '1';} else { var autopost = '0'; }}//if(isNaN(args[3].toString()))
	//if(!fs.existsSync('buffer_furrendering.txt')){fs.appendFileSync('buffer_furrendering.txt', 'MP3RenderingMode');}
				const sentMessage = await message.channel.send('Uploading...');
				execSync('fur2mp3reset.bat');
				execSync('del /q output_*');
				//if(fs.existsSync('buffer_norender.txt')){fs.unlinkSync('buffer_norender.txt');}


			
			if(RenderMode == '2'){
				var options = {filename: "buffer_sid.sid"};//var options = {
				var whattoexec = 'SIDRender.bat';
				/*if(args[0] == null){var optis = 180;} else { if(isNaN(args[0])){var optis = 180;} else { var optis = Number(args[0]);}}
				var opti = '-t' + optis + ' -o' + sidsubs;*/
				var opti = '-t' + LoopVaule + ' -o' + SubsongVaule;
				
			} else if(RenderMode == '3'){
				var whattoexec = 'VGMRender.bat';
				var opti = (Number(SubsongVaule) -1) + ' --play_length=' + (Number(LoopVaule) * 1000);
				var options = {filename: "buffer_vgminput.vgm"};
				
			} else if(RenderMode == '4'){
				var opti = (Number(SubsongVaule) -1) + ' "--play_length=' + (Number(LoopVaule) * 1000) + '"';
				var options = {filename: "buffer_fmsinput.fms"};
				var whattoexec = 'FMSRender.bat';
				
			} else if(RenderMode == '8'){
				//var opti = '';
				var whattoexec = 'ZXTRender.bat';
				var fname = TargetMessage.attachments.first().name;
				var ext1 = fname.toString().split('.');//var sendfilelist = ['zxtzxt.mp3'];
				var ext2 = ext1.pop();
				var options = {filename: 'buffer_zxt.' + ext2};//};
				//message.channel.send('```\n' + fname + ext1 + ext2 + options.filename.toString() + '```');
				var opti = options.filename.toString();
			
			} else if(RenderMode == '6'){
				var whattoexec = 'MIDRender.bat';
				var opti = '';
				var options = {filename: "buffer_mid.mid"};//if(rmi == 1){var options = {filename: "buffer_mid.rmi"};}else{var options = {filename: "buffer_mid.mid"};}
				if(TargetMessage.attachments.array()[1] && TargetMessage.attachments.array()[1].name.toString().toLowerCase().endsWith('.sf2')){//if(TargetMessage.attachments.array()[1].name.toString().toLowerCase().endsWith('.sf2')){
					if(fs.existsSync('buffer_sf2.sf2')){fs.unlinkSync('buffer_sf2.sf2');}
					var sfsf = TargetMessage.attachments.array()[1].name.toString();
					var sfav = 1;
				} else { var sfsf = 'SC-55.sf2';} //else
				
			} else if(RenderMode == '7'){ 
				//if(fs.existsSync('buffer_extcommand.txt')){ fs.unlinkSync('buffer_extcommand.txt');}
				//fs.writeFileSync('buffer_extcommand.txt', '--bank ' + args[1].toString());
				var whattoexec = 'OPL3MIDRender.bat';
				if(LoopVaule.toLowerCase() == 'auto'){
					var opti = 'AUTO' + ' "--bank ' + args[1].toString() + '"';
					var InfoLoop = 'Auto';
				} else {
				var opti = '"--play_length=' + (Number(LoopVaule) * 1000) + '" "--bank ' + args[1].toString() + '"';
				var InfoLoop =  LoopVaule + ' Seconds';
				}
				var options = {filename: "buffer_vgmmidi.mid"};//}//if(rmi == 1){var options = {filename: "buffer_vgmmidi.rmi"};}else{var options = {filename: "buffer_vgmmidi.mid"};}}
			
			
			} else if(RenderMode == '5'){
				var whattoexec = 'YMRender.bat';
				var opti = '--play_length=' + (Number(LoopVaule) * 1000);
				var options = {filename: "buffer_ym.ym"};
				
			} else {
				var whattoexec = 'FURRender.bat';
				var opti = '-subsong ' + FurSubsongVaule + ' -loops ' + FurLoopVaule;
				var options = {filename: "buffer_furinput.fur"};
			}//var options = {
   // directory: "./images/cats/",}
			
			//message.channel.send('```\n' + vgmmode + '```');
			//await message.channel.send('```\n' + opti + whattoexec + 'fuk\n\n' + options + '```');
			//if(fs.existsSync('buffer_osccodec.txt')){fs.unlinkSync('buffer_osccodec.txt');}
			await get(TargetMessage.attachments.first().url,options);
				if(sfav == 1){//[[[[
			await get(TargetMessage.attachments.array()[1].url,{filename: "buffer_sf2.sf2"});}

					if(args[2] == null){//message.channel.send('asfasf');}
						//var increasing = '** **'; 
						var osc = 0;
						var oscinfo = 'Off';
						
					} else if (Number(args[2]) >= 0 && Number(args[2]) <= 4){

						var osc = 1; 
						if(args[2].toString() == '2'){
							fs.writeFileSync('buffer_osccodec.txt', 'libx264 true');
							var oscinfo = 'On, H264, Two-Pass Encoding';
						} else if(args[2].toString() == '1'){
							fs.writeFileSync('buffer_osccodec.txt', 'libx265 true');
							var oscinfo = 'On, H265, Two-Pass Encoding';
						} else if(args[2].toString() == '4'){
							fs.writeFileSync('buffer_osccodec.txt', 'libx264 false');
							var oscinfo = 'On, H264, Single-Pass Encoding';
						} else if(args[2].toString() == '3'){
							fs.writeFileSync('buffer_osccodec.txt', 'libx265 false');
							var oscinfo = 'On, H265, Single-Pass Encoding';
						}
					}
if(osc == 1){
	var infoid3 = '\nOscilloscope Video Rendering: **' + oscinfo + '**'; 
	var altz = '\n' + currentcrr;
} else { 
	var infoid3 = '\nOscilloscope Video Rendering: **Off**\nMP3 ID3 Title: **' + id3tag + '**'; var altz = '';
}

if(RenderMode == '2' || RenderMode == '3' || RenderMode == '4'){
	var info = '\n\nLength: **' + InfoLoop + ' Seconds**\n' + 'Track No.: **' + InfoSubs + '**' + infoid3;
} else if(RenderMode == '6'){
	var info = '\n\nSoundfont: **' + sfsf + '**' + infoid3;
} else if(RenderMode == '8'){
	var info = '\n' + '\nMP3 ID3 Title: **' + id3tag + '**';
} else if(RenderMode == '5'){
	var info = '\n\nLength: **' + InfoLoop + ' Seconds**' + infoid3;
} else if(RenderMode == '7'){
	var info = '\n\nLength: **' + InfoLoop + '**\nOPL3 Bank: **' + args[1].toString() + '**' + infoid3;
} else {
	var info = '\n\nLoops: **' + InfoLoop + '**\nSubsong Number: **' + InfoSubs + '**' + infoid3;
}
//} else { var info = '';}
				//if(!args[0])
				if(RenderMode == '2'){ var currentfnncarg = currentsid;} //else { var currentfnncarg = currentsid;}
				else if(RenderMode == '3'){ var currentfnncarg = currentvgm;}
				else if(RenderMode == '5'){ var currentfnncarg = currentvgm + '\n' + currentym;}
				else if(RenderMode == '4'){ var currentfnncarg = currentfms + '\n' + currentvgm;}
				else if(RenderMode == '6'){ var currentfnncarg = currentmid;}
				else if(RenderMode == '7'){ var currentfnncarg = currentvgm + '\n' + currentm2v;}
				else if(RenderMode == '8'){ var currentfnncarg = currentzxt;}
				else { var currentfnncarg = currentfnnc;}
					fs.writeFileSync('buffer_furrendering.txt', 'Rendering');
				await sentMessage.edit(currentfnncarg + altz + '\nRendering started!' + info);
				//message.channel.startTyping();
				//await exec('fur2wav.bat buffer_furinput.fur', (error, stdout, stderr) => {
//let optionsv = {stdio : 'pipe' };//xmessage.channel.send('```\n' + opti + '```');
//message.channel.send('```\n' + whattoexec + ' ' + opti + '```');
//await message.channel.send(whattoexec + ' ' + opti.toString());
					await exec(whattoexec + ' ' + opti.toString(), { stdio: []},(error, stdout, stderr) => { console.error(stderr, stdout,{ split : true});
							//exec('fur2mp3reset.bat');
							if(RenderMode == '8'){
								var sendfilelist1 = ["output_zxtout.mp3"];
							} else {
								if(osc == 1){ 
									var sendfilelist1 = ["output_buffer_oscout 20MB.mp4"];
								} else {
									var sendfilelist1 = ["output_furoutput.mp3"];
								}
							}
							
							if(!fs.existsSync(sendfilelist1.join(''))){
								if(!fs.existsSync('buffer_fur2mp3error.txt')){
									message.channel.send(userPing + nofileErr);
								} else {
									message.channel.send(userPing + nofileErr + '\nDefined error : ' + fs.readFileSync('buffer_fur2mp3error.txt'));
									//fs.unlinkSync('buffer_fur2mp3error.txt');
								}
								execSync('fur2mp3reset.bat');
								return;
							}
								if(getFilesizeInBytes(sendfilelist1.join('')) > 25780189){
									message.channel.send(userPing + nofileErr + '\nCompression failed!');
									execSync('fur2mp3reset.bat');
									return;
								}//{ 
								if(RenderMode == '8'){
									message.channel.send(userPing + ' ' + gwavs, { files: [ 'output_zxtout.mp3' ]}); //return;
								} else {
									message.channel.send(userPing + ' ' + gwavs,{ files: sendfilelist1 });
								}
							if(autopost == '1'){
								if(!osc == 1){
									message.guild.channels.cache.get(AutoPostChannelID).send(userPing + ' ' + autopoststring ,{ files: sendfilelist1 });
								} else { 
									message.channel.send(userPIng + ' Sorry, I can\'t post the Google Drive link at there!');
								}
							} 
							execSync('fur2mp3reset.bat');
							return;//}
	
				});
		} //message.channel. // 파이 이름 ㅍbuffer_furinput.fur'
		       else { //message.channel.send(userPing + ' Send your file with this command!');
			   message.channel.send(usage, {split:true});return; //}
//});
//끝이당
		
		
		
		
		
		
		
		
		
		
        //message.channel.send('shut up' + args);
    }}
	});