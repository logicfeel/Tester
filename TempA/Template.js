var handlebars = require('handlebars');
var handlebarsWax = require('handlebars-wax');

class TemplateA {
    wax;
    src = '{{lorem}} {{ipsum}}  {{#>far}} boo 없음 {{/far}} {{#>pageQQ}}pageQQ없음{{/pageQQ}}.. {{kkk}} key:'
    // src = '{{#*inline "pageQQ"}} 오버 page {{/inline}} {{lorem}} {{ipsum}}  {{#>far}} boo 없음 {{/far}} {{#>pageQQ}}pageQQ없음{{/pageQQ}}.. {{kkk}} key:'

    constructor() {
        this.build();
    }

    build() {
        this.wax = handlebarsWax(handlebars.create())    // 독립 실행
            // Partials
            .partials('./partials/**/*.{hbs,js}')
            .partials({
                boo: '{{#each boo}}{{greet}}{{/each}}',
                far: '{{#each far}}{{length}}{{/each}}',
                page: ' page 입니다 ',
            })
            // Helpers
            .helpers('./helpers/**/*.js')
            .helpers({
                foo: function () { return 'FOO' },
                bar: function () { return 'BAR' }
            })
            // Data
            .data('./data/**/*.{js,json}')
            .data({
                lorem: 'dolor',
                ipsum: 'sit amet'
        });
    }
    export(key) {
        var _this = this;
        return function(data, hb, c) {
            // TODO:: data _parent 와 같은건 제거후 리턴한다.
            let subData = {};
            for (let prop in data) {
                if (!data._parent[prop]) subData[prop] = data[prop];
            }
            var template = _this.wax.compile(_this.src+ key);
            return template(subData);
        }
    }
    run() {
        var template = this.wax.compile(this.src);
        return template();
    }
}


var ta = new TemplateA()

class TemplateB {
    wax;
    src = ' {{obj.bbb}} {{lorem}} {{ipsum}}  {{#>far}} boo 없음 {{/far}} .. < {{#>super kkk="KKK" vvv=ipsum}} {{#*inline "pageQQ"}} 오버 page {{/inline}} {{/super}} >  key:'
    constructor() {
        this.build();

        this.wax.partials()
    }

    build() {
        this.wax = handlebarsWax(handlebars.create())    // 독립 실행
            // Partials
            .partials('./partials/**/*.{hbs,js}')
            .partials({
                boo: '{{#each boo}}{{greet}}{{/each}}',
                far: '{{#each far}}{{length}}{{/each}}',
                super: ta.export('SUPER')   // 외부 모듈추가
            })
            // Helpers
            .helpers('./helpers/**/*.js')
            .helpers({
                foo: function () { return 'FOO' },
                bar: function () { return 'BAR' }
            })
            // Data
            .data('./data/**/*.{js,json}')
            .data({
                lorem: '___dolor',
                ipsum: '___sit amet',
                obj: {bbb: 'BBB'}
        });
    }
    import(obj) {

        // obj.
        // var _this = this;
        // return function() {
        //     var template = _this.wax.compile('{{lorem}} {{ipsum}}  {{#>far}} boo 없음 {{/far}} .. key:'+ key);
        //     return template();
        // }
    }

    run() {
        var template = this.wax.compile(this.src);
        return template();
    }
}



// var fun = ta.export('Test')

// console.log(fun());
console.log(ta.run());

var tb = new TemplateB()
console.log(tb.run());
