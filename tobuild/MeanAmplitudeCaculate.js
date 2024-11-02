const fs = require("fs");
const { exec } = require('child_process');
exec(`sox-14.4.2\\sox.exe "${process.argv.slice(2).join(' ')}" -n stat`, (err, stdout, stderr) => {
	stderr.split('\r\n').forEach(function(element){ 
		if(element.trim().startsWith('Maximum amplitude:')) {
			if(Number(element.replace(/[^0-9.]/g, '')) > 0.000001) {
				console.log('true');
			} else {
				console.log('false');
			}
		}
	});

});