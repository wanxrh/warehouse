
define(function(require, exports, module) {

    var mod = {};

    mod.TopBanner=function(C){var win=window,doc=document,head=doc.head?doc.head:doc.getElementsByTagName("head")[0];var html=''
    +'<div id="cekebrate_banner">'
    +'<div class="cekebrate_bg2">'
    +'<div class="cekebrate_head">'
    +'<span class="slideDown" title="展开"></span>'
    +'</div>'
    +'<a target="_blank" href="'+C.href+'">'
    +'<img class="cekebrate_Minlogo none" src="'+C.smallImg+'" />'
    +'</a>'
    +'</div>'
    +'<div  class="cekebrate_bg">'
    +'<div class="cekebrate_head">'
    +'<span class="slideUp" title="收起"></span>'
    +'</div>'
    +'<a target="_blank" class="cekebrate_logo" href="'+C.href+'">'
    +'<img class="cekebrate_logo none" src="'+C.LargeImg+'" />'
    +'</a>'
    +'</div>'
    +'</div>';var cssText=''
    +'#cekebrate_banner{ width:100%; min-width:1000px; overflow:hidden; position:relative; height:'+C.LargeImgHeight+'px; background-color:'+C.LargeBgC+';}'
    +'.cekebrate_bg, .cekebrate_bg2 {display:block; width:100%; position:absolute;}'
    +'.cekebrate_bg a, .cekebrate_bg2 a{ width:100%; height: 100%; display: block;z-index:1; cursor: pointer;}'
    +'.cekebrate_bg {height:'+C.LargeImgHeight+'px; top:0;background:url('+C.LargeImg+') no-repeat bottom '+C.LargeBgC+'; }'
    +'.cekebrate_bg2{ top:-'+C.smallImgHeight+'px; height:'+C.smallImgHeight+'px;background:url('+C.smallImg+') no-repeat bottom '+C.smallBgC+';}'
    +'.cekebrate_head{margin:0 auto; width:1000px;position:relative; z-index:1;}'
    +'.cekebrate_logo,.cekebrate_Minlogo{margin:0 auto;}'
    +'.cekebrate_logo{height:'+C.LargeImgHeight+'px;}'
    +'.none{display:none;}'
    +'.cekebrate_Minlogo{ width:1000px; height:'+C.smallImgHeight+'px;}'
    +'.slideUp,.slideDown{width:'+C.UpDownWidth+'px;position:absolute;height:'+C.UpDownHeight+'px; top:0px;right:0px;display:block;cursor:pointer; z-index:1000;}'
    +'.slideUp{background: transparent url('+C.buttonUp+') no-repeat 0 0;_background: transparent none;_filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src=\''+C.buttonUp+'\', sizingMethod=\'scale\');*zoom: 1;}'
    +'.slideDown{background: transparent url('+C.buttonDown+') no-repeat 0 0;_background: transparent none;_filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src=\''+C.buttonDown+'\', sizingMethod=\'scale\');*zoom: 1;}'
    +'.slideDown{top:-'+C.UpDownHeight+'px;}';var css=doc.createElement('style');css.type='text/css';if(css.styleSheet){css.styleSheet.cssText=cssText;}else{css.appendChild(doc.createTextNode(cssText));}
    head.appendChild(css);doc.body.innerHTML=html+doc.body.innerHTML;eval(function(p,a,c,k,e,d){e=function(c){return(c<a?'':e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--){d[e(c)]=k[c]||e(c)}k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1};while(c--){if(k[c]){p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c])}}return p}('n p(a,b,c){6.Q(a,b,c)}p.D=Z,p.B.R=n(a,b){x d,i,c=6,e="H"==s p.D?p.D:Z,f=(V U).X(),g="H"==s 6.E?6.E:4,h="I"==s 6.F?6.F:"u-r";y/^(N|w|r|A|t-w|t-r|t-A|u-w|u-r)$/i.10(h)||(h="u-r"),i=n(){x j,k,l,m,e=(V U).X(),i=e-f;16(i>g)y a.8(c,1),c.S(d,b),14 0;O(h){7"N":a.8(c,i/g);9;7"w":j=.T*4*(i/g)*4*(i/g),a.8(c,j/4);9;7"r":j=2*4*(i/g)-.T*4*(i/g)*4*(i/g),a.8(c,j/4);9;7"A":k=4*(i/g),v>k?j=.M*k*k:(k-=v,j=v+2*k-.M*k*k),a.8(c,j/4);9;7"t-w":l=4*(i/g),m=4-q.o(L-l*l,.5),a.8(c,m/4);9;7"t-r":l=4-4*(i/g),m=q.o(L-l*l,.5),a.8(c,m/4);9;7"t-A":l=4*(i/g),v>l?m=v-q.o(P-l*l,.5):(l=4-l,m=v+q.o(P-l*l,.5)),a.8(c,m/4);9;7"u-w":l=4*(i/g),a.8(c,q.o(l,5)/q.o(4,5));9;7"u-r":l=4*(i/g),a.8(c,1-q.o(4-l,5)/q.o(4,5))}},6.C=d=12(i,18(g/e)),11(i,0),6.C},p.B.S=n(a,b){y a=a||6.C,1i(a),"n"==s b&&b(),"n"==s 6.G&&6.G(),6},p.B.Q=n(){x b,a=[].1m.8(1l);J(b=0;3>b&&b<a.1c;b++)O(s a[b]){7"H":6.E=a[b];9;7"I":6.F=a[b];9;7"n":6.G=a[b]}y 6},p.B.1a=n(a,b,c){x d,g,e={},f=a.W?a.W:1b.1h.1k(a,1n);J(d K f)e[d]=f[d];y g=6.R(n(c){x f;J(d K b)"I"!=s b[d]||Y(z(b[d]))||!e[d]||Y(z(e[d]))||(f=b[d].19(/(%|K|1d|1e|1g|1j|1f|17|13)$/i),a.15[d]=z(e[d])+(z(b[d])-z(e[d]))*c+(f?f[1]:""))},c)};',62,86,'||||1e3||this|case|call|break||||||||||||||function|pow|CL_Animate|Math|dec|typeof|arc|para|500|acc|var|return|parseFloat|accdec|prototype|timer|fps|time|alg|callback|number|string|for|in|1e6|002|uniform|switch|25e4|init|run|stop|001|Date|new|currentStyle|getTime|isNaN|100|test|setTimeout|setInterval|px|void|style|if|pc|parseInt|match|easy|document|length|cm|mm|pt|em|defaultView|clearInterval|ex|getComputedStyle|arguments|slice|null'.split('|'),0,{}));var topBanner={isCartoon:false,ele:{},options:{executeTime:6000,Up_DownHeight:75,UpbannerHeight:300,DownbannerHeight:75,slideUp_btn:'.slideUp',slideDown_btn:'.slideDown',ad_Upbanner:'.cekebrate_bg',ad_Downbanner:'.cekebrate_bg2',ad_time:700,btn_time:700,ud_time:500},A:new CL_Animate(),merge:function(obj1,obj2){var obj={},i;for(i in obj1)
    obj[i]=obj1[i];for(i in obj2)
    obj[i]=obj2[i];return obj;},dom:function(selector){if(selector.substr(0,1)=="#"){return doc.getElementById(selector.substr(1));}
    else if(selector.substr(0,1)=="."){selector=" "+selector.substr(1).toLowerCase()+" ";for(var i=0;i<this.elements.length;i++){if((" "+this.elements[i].className+" ").toLowerCase().indexOf(selector)>=0)
    return this.elements[i];}}
    return null;},bannerSlideUp:function(){if(this.isCartoon)return;this.isCartoon=true;clearTimeout(this.timer);var self=this;self.A.init(self.options.ad_time).run(function(i){self.ele.top_banner.style.height=(self.options.UpbannerHeight-self.options.UpbannerHeight*i)+"px";self.ele.Upbanner.style.top=(-self.options.UpbannerHeight*i)+"px";self.ele.slideUp.style.top=(-self.options.Up_DownHeight*i)+"px";},function(){self.A.init(self.options.btn_time).run(function(i){self.ele.top_banner.style.height=(self.options.DownbannerHeight*i)+"px";self.ele.Downbanner.style.top=(-self.options.DownbannerHeight+self.options.DownbannerHeight*i)+"px";},function(){self.A.init(self.options.ud_time).run(function(i){self.ele.slideDown.style.top=(-self.options.Up_DownHeight+self.options.Up_DownHeight*i)+"px";},function(){self.isCartoon=false});});});},bannerSlideDown:function(){if(this.isCartoon)return;this.isCartoon=true;clearTimeout(this.timer);var self=this;self.A.init(self.options.btn_time).run(function(i){self.ele.top_banner.style.height=(self.options.DownbannerHeight-self.options.DownbannerHeight*i)+"px";self.ele.Downbanner.style.top=(-self.options.DownbannerHeight*i)+"px";self.ele.slideDown.style.top=(-self.options.Up_DownHeight*i)+"px";},function(){self.A.init(self.options.ad_time).run(function(i){self.ele.top_banner.style.height=(self.options.UpbannerHeight*i)+"px";self.ele.Upbanner.style.top=(-self.options.UpbannerHeight+self.options.UpbannerHeight*i)+"px";},function(){self.A.init(self.options.ud_time).run(function(i){self.ele.slideUp.style.top=(-self.options.Up_DownHeight+self.options.Up_DownHeight*i)+"px";},function(){self.isCartoon=false});});});},init:function(element,options){if(typeof options=="object")
    this.options=this.merge(this.options,options);this.ele.top_banner=typeof element=="string"?doc.getElementById(element):element;this.elements=this.ele.top_banner.getElementsByTagName("*");this.ele.slideUp=this.dom(this.options.slideUp_btn);this.ele.slideDown=this.dom(this.options.slideDown_btn);this.ele.Upbanner=this.dom(this.options.ad_Upbanner);this.ele.Downbanner=this.dom(this.options.ad_Downbanner);var self=this;this.ele.slideUp.onclick=function(){self.bannerSlideUp()};this.ele.slideDown.onclick=function(){self.bannerSlideDown()};this.timer=setTimeout(function(){self.bannerSlideUp()},this.options.executeTime);}};topBanner.init("cekebrate_banner",{executeTime:6000,Up_DownHeight:C.UpDownHeight,UpbannerHeight:C.LargeImgHeight,DownbannerHeight:C.smallImgHeight,slideUp_btn:'.slideUp',slideDown_btn:'.slideDown',ad_Upbanner:'.cekebrate_bg',ad_Downbanner:'.cekebrate_bg2',ad_time:700,btn_time:700,ud_time:500});}

    module.exports = mod;
})

