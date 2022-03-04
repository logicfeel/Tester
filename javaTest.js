


const fs = require('fs')
const path = require('path')
const java7 = require('./java7')




var file = "parse/ClassTest.java"

var data = fs.readFileSync(file, 'utf8');

var ast = java7.parse(data)


console.log(1)