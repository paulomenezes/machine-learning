const fs = require('fs');
const lwip = require('lwip');

function randomNumbers(max) {
    function range(upTo) {
        var result = [];
        for(var i = 0; i < upTo; i++) result.push(i);
        return result;
    }
    function shuffle(o){
        for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
        return o;
    }
    var myArr = shuffle(range(max));
    return function() {
        return myArr.shift();
    };
}

var randoms = randomNumbers(112),
    rand = randoms(),
    result = [];
while (rand != null) {
    result.push(rand);
    rand = randoms();
}

let csv = [];
csv.push('filename,label\n');

let csv2 = [];
csv2.push('filename\n');

let csv3 = [];
csv3.push('filename,label\n');

let categories = {
  gul: 0,
  brody: 1,
  menem: 2,
  snow: 3,
  arm: 4,
  paulo: 5,
  joao: 6
}

fs.readdir('./data/Train/Images', (err, files) => {
  console.log(files.length);
  for (var i = 0; i < 112; i++) {
    let rng = result[i];

    // train
    if (i <= 78) {
      csv.push(files[rng] + ',' + categories[files[rng].split(' ')[0]] + '\n');

      lwip.open('./data/Train/Images/' + files[rng], (err, image) => {
        image.resize(32, 32, (err, image) => {
          image.writeFile('./data/Train/Images/train/' + files[rng], (err) => {
            console.log(err)
          })
        });
      });
    } else {
      csv2.push(files[rng] + '\n');
      csv3.push(files[rng] + ',' + categories[files[rng].split(' ')[0]] + '\n')

      lwip.open('./data/Train/Images/' + files[rng], (err, image) => {
        image.resize(32, 32, (err, image) => {
          image.writeFile('./data/Train/Images/test/' + files[rng], (err) => {
            console.log(err)
          })
        });
      });
    }
  }

  fs.writeFile('./data/Train/train_node.csv', csv, 'utf8', function (err) {
    if (err) {
      console.log(err);
    }
  });

  fs.writeFile('./data/test_node.csv', csv2, 'utf8', function (err) {
    if (err) {
      console.log(err);
    }
  });

  fs.writeFile('./sub/prova_node.csv', csv3, 'utf8', function (err) {
    if (err) {
      console.log(err);
    }
  });
});