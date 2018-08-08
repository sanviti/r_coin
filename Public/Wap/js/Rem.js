/* *
 	px转换rem单位
 * */

//px转换rem(设计稿最大宽度除以25   750/25 = 30;    1rem = 30px; )
//document.documentElement.style.fontSize = document.documentElement.clientWidth / 7.5 + 'px';
//window.onresize = function() {
//	document.documentElement.style.fontSize = document.documentElement.clientWidth / 7.5 + 'px';
//}

(function(win){
	var ratio,scaleValue,renderTime,
			document=window.document,
			docElem=document.documentElement,
			vpm=document.querySelector('meta[name="viewport"]');
	if(vpm){
		var tempArray=vpm.getAttribute("content").match(/initial\-scale=(["']?)([\d\.]+)\1?/);
		if(tempArray){
			scaleValue=parseFloat(tempArray[2]);
			ratio=parseInt(1/scaleValue);
		}
	}else{
		vpm=document.createElement("meta");
		vpm.setAttribute("name","viewport");
		vpm.setAttribute("content","width=device-width,initial-scale=1,user-scalable=no,minimal-ui");
		docElem.firstElementChild.appendChild(vpm);
	}

	win.addEventListener("resize",function(){
		clearTimeout(renderTime);
		renderTime=setTimeout(initPage,300);
	},false);

	win.addEventListener("pageshow", function(e) {
		e.persisted && (clearTimeout(renderTime),renderTime=setTimeout(initPage,300));
	}, false);

	"complete"===document.readyState?document.body.style.fontSize =12*ratio+"px":
			document.addEventListener("DOMContentLoaded",function(){
				document.body.style.fontSize =12*ratio+"px";
			},false);
	initPage();
	//设备的宽度除以15（750 / 15 = 50）  1rem = 50px;
	function initPage(){
		var htmlWidth=docElem.getBoundingClientRect().width;
		if(htmlWidth>750) htmlWidth=750;
		htmlWidth/ratio>750 && (htmlWidth=750*ratio);
		win.rem=htmlWidth/15;
		docElem.style.fontSize=win.rem+"px";
	}
})(window);

// 禁止微信调整字体大小
(function() {    
if (typeof WeixinJSBridge == "object" && typeof WeixinJSBridge.invoke == "function") {
        handleFontSize();
} else {        
if (document.addEventListener) {
    document.addEventListener("WeixinJSBridgeReady", handleFontSize, false);
} else if (document.attachEvent) {
    document.attachEvent("WeixinJSBridgeReady", handleFontSize);
    document.attachEvent("onWeixinJSBridgeReady", handleFontSize);  }
}    
function handleFontSize() {        
        // 设置网页字体为默认大小
        WeixinJSBridge.invoke('setFontSizeCallback', { 'fontSize' : 0 });        
        // 重写设置网页字体大小的事件
        WeixinJSBridge.on('menu:setfont', function() {
            WeixinJSBridge.invoke('setFontSizeCallback', { 'fontSize' : 0 });
        });
    }
})();


