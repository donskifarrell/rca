

var fs = require('fs');

var present = [];
for (var j = 1; j < 3000; j++) {
	present[j] = "None";
}

var names = [];
var files = fs.readdirSync('images');
var arrayLength = files.length;
for (var i = 0; i < arrayLength; i++) {
	var num = files[i].toString().split('.')[0];
    names.push(num);
}

function sortNumber(a,b) {
    return a - b;
}

var idx = 1;
var sorted = names.sort(sortNumber)
var arrayLength2 = sorted.length;
console.log("length: " + arrayLength2)
console.log("start: " + sorted[1])


for (var j = 1; j < arrayLength2; j++) {
	present[sorted[j]] = sorted[j];
}


for (var j = 0; j < present.length; j++) {
	if (present[j] == "None"){	
		console.log(present[j] + " nUm: " + j);
	}

}