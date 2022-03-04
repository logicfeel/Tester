// mymodule.js
var parser = require("./calculator").parser;


function print(str) {
    console.log(str);
}

function exec (input) {
    return parser.parse(input);
}

var twenty = exec("4 * 5");