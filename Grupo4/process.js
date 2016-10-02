const fs = require('fs');

fs.readFile('./audiologyCl.txt', 'utf8', (err, data) => {
	let lines = data.split('\n');

	let parts = lines[0].split(',[');

	for (var i = 0; i < parts[0].split(',').length; i++) {
		console.log(parts[0].split(',')[i].replace('[', ''));
	}

	console.log('');

	for (var i = 0; i < parts[1].split(',').length; i++) {
		let feature = parts[1].split(',')[i].replace(']]', '').split('(');

		console.log(feature[0] + (feature.length > 1 ? ': ' + feature[1].replace(')', '') : ''));
	}
});