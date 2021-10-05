
// var $m = module;

(function(global) {

    'use strict';

    // global = (typeof module !== 'undefined' && module.exports) ? global : window;
    
    // 특이하게 오류가 남
    // if (typeof module === 'object') console.log(11)
    // global = (typeof module === 'object') ? global : window;

    // var util = require('util');
    // import util from 'util'


    console.log(typeof global)

    module.exports.crop = function() { 
        console.log(global) 
    };
    module.exports.rotate = function() {
        // console.log(typeof global)
    };

// }(this));
    // }(window));
// }(typeof $m === 'object' ? global : window));
}(typeof module !== 'undefined' && module.exports ? global : window));