//- 设置根元素fontSize
(function (doc, win) {
    var _root = doc.documentElement,
        resizeEvent = 'orientationchange' in window ? 'orientationchange' : 'resize',
        resizeCallback = function () {
            var clientWidth = _root.clientWidth,
                fontSize = 20;
            if (!clientWidth) return;
            if(clientWidth < 750) {
                fontSize = 20 * (clientWidth / 375);
            } else {
                fontSize = 20 * (750 / 375);
            }
            _root.style.fontSize = fontSize + 'px';
        };
    if (!doc.addEventListener) return;
    win.addEventListener(resizeEvent, resizeCallback, false);
    doc.addEventListener('DOMContentLoaded', resizeCallback, false);
})(document, window);

//图片居中显示
jQuery.fn.extend({
	imgSca:function(nameCla){
		return this.each(function(){
			var widBox = $(this).width();
			var heiBox = $(this).height();
			if(nameCla == undefined){
				var thisChi = $(this).find("img");
			} else {
				var thisChi = $(this).find("."+nameCla);
			}
			var widChi = thisChi.width();
			var heiChi = thisChi.height();
			var widNum =  widBox/widChi;
			var heiNum =  heiBox/heiChi;
			if(widBox>widChi && heiBox>heiChi){
				thisChi.css({
					marginLeft:(widBox-widChi)/2,
					marginTop:(heiBox-heiChi)/2,
				});
			} else {
				if(widBox/heiNum>widChi){
					thisChi.css({
						height:"100%",
						marginLeft:(widBox-widChi*heiNum)/2,
					});
				} else {
					thisChi.css({
						width:"100%",
						marginTop:(heiBox-heiChi*widNum)/2,
					});
				};
			};
		});
	},
});

//图片铺满显示
function imgCenter(aa){
	var thisNow = aa;
	thisNow.css({
		position:"absolute",
		display:"block",
		width:"auto",
	});
	thisNow.parent().css({
		display:"block",
		overflow:"hidden"
	});
	var parWid = thisNow.parent().width();
	var parHei = thisNow.parent().height();
	var imgWid = thisNow.width();
	var imgHei = thisNow.height();
	var widNum =  parWid/parHei;
	var heiNum =  imgWid/imgHei;
	if(widNum>=heiNum){
		thisNow.css({
			width:parWid,
			height:"auto",
		});
		imgHei = thisNow.height();
		thisNow.css({
			//top:"0px",
			top:-(imgHei-parHei)/2,
		});
	} else {
		if(widNum == heiNum){
			thisNow.css({
				height:parHei,
			});
		} else {
			thisNow.css({
				width:"auto",
				height:parHei,
			});
			imgWid = thisNow.width();
			thisNow.css({
				left:-(imgWid-parWid)/2,
			});
		}
	}
}

//单提示框
function promptBox(tex){
	if($(".prompt_box").size() == 0){
		$("body").append('<div class="prompt_box">'+tex+'</div>');
		$(".prompt_box").css({
			"margin-left":-$(".prompt_box").outerWidth()/2
		});
		$(".prompt_box").delay("1500").animate({
			opacity:0
		},1000,function(){
			$(".prompt_box").remove();
		});
	};
};


//确认框
function confirmationBox(tex,fun){
	if($(".confirmation_box").size() == 0){
		$("body").append('<div class="dialog_overlay_confirmation"></div><div class="confirmation_box"><span class="confirmation_box_text">'+tex+'</span><div class="confirmation_box_but"><span class="confirmation_box_cancel">取消</span><span class="confirmation_box_confirm">确认</span></div></div>');
		$(".confirmation_box").css({
			"margin-left":-$(".confirmation_box").outerWidth()/2,
			"margin-top":-$(".confirmation_box").outerHeight()/2 - 10
		});
	};
	$(".confirmation_box .confirmation_box_cancel").on("click",function(){
		$(".dialog_overlay_confirmation").remove();
		$(".confirmation_box").remove();
	});
	$(".confirmation_box .confirmation_box_confirm").on("click",function(){
		$(".dialog_overlay_confirmation").remove();
		$(".confirmation_box").remove();
		fun();
	});
};

//验证手机号
function validatemobile(mobile) { 
   	if(mobile.length==0) { 
      promptBox('请输入手机号码！'); 
      return false; 
  	};
   	if(mobile.length!=11) { 
       promptBox('请输入有效的手机号码！');
       return false; 
   	};
   	var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/; 
   	if(!myreg.test(mobile)) { 
   		promptBox('请输入有效的手机号码！');
		return false; 
    };
   	return true;
};

//滚动
function autoScroll(obj,num){  
	$(obj).find("ul").animate({  
		marginTop : "-"+num+"px"  
	},500,function(){  
		$(this).css({marginTop : "0px"}).find("li:first").appendTo(this);
	});
};

//验证姓名  以英或汉字开头，4-16字符，不可以使用特殊符号
function IsOK(str){
  var ta=str.split(""),str_l=0;
  var str_fa=Number(ta[0].charCodeAt());
  if((str_fa>=65&&str_fa<=90)||(str_fa>=97&&str_fa<=122)||(str_fa>255))
  {
    for(var i=0;i<=ta.length-1;i++)
    {
      str_l++;
      if(Number(ta[i].charCodeAt())>255){str_l++;}
    }
    if(str_l>=4&&str_l<=16){return true;}
  }
  return false;
}

//加载动画
$(function(){
	$("body").append('<div id="loading"><div id="loading-center"><div id="loading-center-absolute"><div class="object" id="object_one"></div><div class="object" id="object_two"></div><div class="object" id="object_three"></div><div class="object" id="object_four"></div></div></div></div>');
	$(".navigation").click(function(){
		if($(".navigation_href").hasClass("navigation_href_on")){
			$(".navigation_href").removeClass("navigation_href_on");
		} else {
			$(".navigation_href").addClass("navigation_href_on");
		}
	})
})
$(window).load(function() {
	setTimeout(function(){
		$("#loading").fadeOut(500);
	},500);
})