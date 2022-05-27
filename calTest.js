// mymodule.js
var parser = require("./calculator").parser;


function print(str) {
    console.log(str);
}

function exec (input) {
    parser.lexer.options.ranges = true;
    parser.lexer.options.flex = true;
    
    return parser.parse(input);
}


var context ='';

context = `43 * 55`;
// context = `43 * 
// 55`;
// context = `PI * 55`;
// context = `E`;
context = `logic2`;
context = `logic3`;
context = `logic4`;
context = `logic`;
context = `logic11`;
context = `logic9`;
// context = `logic3 logic3`;

// context = `LO`;
// context = `LO2`;
// context = ` `;
// context = `3 + 2`;
// context = `X * 55`;
// context = `LO 2+ 3`;
// context = `((2+ 3) * 3)`;

var twenty = exec(context);

// var twenty = exec("43 * 55");


// var twenty2 = exec("(3 * 5) + 10");