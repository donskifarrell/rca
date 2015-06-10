var cheerio = require('cheerio');
var fs = require('fs');

for(var page = 1; page <= 250; page++){	
	$ = cheerio.load(fs.readFileSync('pages/' + page + '.html'));

	var link = $('a').attr('href')

	$('a').each(function(i, elem) {
		num = elem.attribs.href.toString().split("/")[3];
		linkPath = $(elem).children('img').attr('src').toString().split("/")[3];
		fileName = linkPath.toString().split(".")[0];
		fullFileName = fileName + "..max-1024x1024"; // Add .jpg or jpeg as necessary

		console.log(num + " " + fullFileName);
		fs.appendFileSync('file-list.txt', num + " " + fullFileName + "\n");
	});
}
