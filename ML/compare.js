const fs = require('fs');

fs.readFile('./sub/sub02.csv', 'utf8', (err, data) => {
  
  fs.readFile('./sub/prova_node.csv', 'utf8', (err, prova) => {
    let count = 0;
  
    data = data.split('\r\n');
    prova = prova.split('\n');

    for (var i = 1; i < prova.length - 1; i++) {
      if (data[i] === prova[i]) count++;

      console.log(`image: (${ data[i].split(',')[1] }:${ prova[i].split(',')[1] }) ${ data[i].split(',')[0] } ${ data[i] === prova[i] }`);
    }

    console.log(`total: ${ count }/${ i } : ${ parseInt((count / i) * 100) }%`);
  })
})

// 79 - 100
// 31 - x