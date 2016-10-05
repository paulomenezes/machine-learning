const fs = require('fs');

let columns = [];

fs.readFile('./audiology.standardized.data.txt', 'utf8', (err, data) => {
	let lines = data.split('\n');

	for (var i = 0; i < lines.length - 1; i++) {
		let attr = lines[i].split(',');

		for (var j = 0; j < attr.length; j++) {
			if (!columns[j])
				columns.push([]);

			let exists = false;
			for (var k = 0; k < columns[j].length; k++) {
				if (columns[j][k] === attr[j]) {
					exists = true;
					break;
				}
			}

			if (!exists)
				columns[j].push(attr[j]);
		}
	}

	let keys = [];

	for (var i = 0; i < columns.length; i++) {
		if (i != 69) {
			let count = columns[i].length - 1;

			for (var j = 0; j < columns[i].length; j++) {
				if (columns[i][j] === '?')
					count--;
			}

			let newLine = [];

			if (count > 0) {
				let k = 0;
				for (var j = 0; j < columns[i].length; j++) {
					if (columns[i][j] === '?')
						newLine.push(-1);
					else {
						newLine.push((1 / count) * k);
						k++;
					}
				}
			} else {
				newLine.push(0);
			}

			let obj = {};
			for (var j = 0; j < columns[i].length; j++) {
				obj[columns[i][j]] = newLine[j];
			}

			keys.push(obj);
		}
	}

	let newFile = '';
	for (var i = 0; i < lines.length - 1; i++) {
		let attr = lines[i].split(',');

		let k = 0;
		let missing = '';

		for (var j = 0; j < attr.length; j++) {
			if (j != 69) {
				missing += keys[k][attr[j]] + ',';
				k++;
			}
		}

		newFile += missing.substr(0, missing.length - 1) + '\n';
	}

	console.log(newFile);

	fs.writeFile('./audiology.binary.txt', newFile);

});