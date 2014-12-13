jQuery.fn.extend({
    template : function(data){
        var tmpl_data = $(this).html();

        var fn = new Function("obj",
            "var p=[];" +

            "with(obj){p.push('" +
            tmpl_data 
            .replace(/[\r\t\n]/g, " ")
            .split("<%").join("\t")
            .replace(/(^|%>)[^\t]*?(\t|$)/g, function(){return arguments[0].split("'").join("\\'");})
            .replace(/\t==(.*?)%>/g,"',$1,'")
            .replace(/\t=(.*?)%>/g, "',(($1)+'').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/\"/g,'&quot;'),'")
            .split("\t").join("');")
            .split("%>").join("p.push('")
            + "');}return p.join('');");
        return fn( data );

    }

});

if (window.console && window.console.log ) {
    window.log = window.console.log
} else {
    window.console = {
        log: function () {}
    }
}
