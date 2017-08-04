
var isIE = (document.all) ? true : false;
var Class = {
create: function() {
return function() { this.initialize.apply(this, arguments); }
}
}
var Extend = function(destination, source) {
for (var property in source) {
destination[property] = source[property];
}
}
var Bind = function(object, fun) {
return function() {
return fun.apply(object, arguments);
}
}
var Each = function(list, fun){
for (var i = 0, len = list.length; i < len; i++) { fun(list[i], i); }
};
var Contains = function(a, b){
return a.contains ? a != b && a.contains(b) : !!(a.compareDocumentPosition(b) & 16);
}

var OverLay = Class.create();
OverLay.prototype = {
initialize: function(options) {
this.SetOptions(options);
this.Lay = "string" == typeof this.options.Lay ? document.getElementById(this.options.Lay) : this.options.Lay || document.body.insertBefore(document.createElement("div"), document.body.childNodes[0]);
this.Color = this.options.Color;
this.Opacity = parseInt(this.options.Opacity);
this.zIndex = parseInt(this.options.zIndex);
with(this.Lay.style){ display = "none"; zIndex = this.zIndex; left = top = 0; position = "fixed"; width = height = "100%"; }
},
//设置默认属性
SetOptions: function(options) {
this.options = {//默认值
Lay:null,//覆盖层对象
Color:"#fff",//背景色
Opacity:50,//透明度(0-100)
zIndex: 1000//层叠顺序
};
Extend(this.options, options || {});
},
//显示
Show: function() {
//设置样式
with(this.Lay.style){
//设置透明度
isIE ? filter = "alpha(opacity:" + this.Opacity + ")" : opacity = this.Opacity / 100;
backgroundColor = this.Color; display = "block";
}
},
//关闭
Close: function() {
this.Lay.style.display = "none";
}
};

var LightBox = Class.create();
LightBox.prototype = {
initialize: function(box, options) {
this.Box = "string" == typeof box ? $("#"+box)[0] : box ;//显示层
this.OverLay = new OverLay(options);//覆盖层
this.SetOptions(options);
this.Fixed = !!this.options.Fixed;
this.Over = !!this.options.Over;
this.Center = !!this.options.Center;
this.onShow = this.options.onShow;
this.Box.style.zIndex = this.OverLay.zIndex + 1;
this.Box.style.display = "none";
},
//设置默认属性
SetOptions: function(options) {
this.options = {//默认值
Over: true,//是否显示覆盖层
Fixed:false,//是否固定定位
Center: false,//是否居中
onShow: function(){}//显示时执行
};
Extend(this.options, options || {});
},
//兼容ie6的固定定位程序
SetFixed: function(){
this.Box.style.top = document.documentElement.scrollTop - this._top + this.Box.offsetTop + "px";
this.Box.style.left = document.documentElement.scrollLeft - this._left + this.Box.offsetLeft + "px";
this._top = document.documentElement.scrollTop; this._left = document.documentElement.scrollLeft;
},
//兼容ie6的居中定位程序
SetCenter: function(){
this.Box.style.marginTop = document.documentElement.scrollTop - this.Box.offsetHeight / 2 + "px";
this.Box.style.marginLeft = document.documentElement.scrollLeft - this.Box.offsetWidth / 2 + "px";
},
//显示
Show: function(options) {
//固定定位
this.Box.style.position = this.Fixed ? "fixed" : "absolute";
//覆盖层
this.Over && this.OverLay.Show();
this.Box.style.display = "block";
//居中
if(this.Center){
this.Box.style.top = this.Box.style.left = "50%";
//设置margin
if(this.Fixed){
this.Box.style.marginTop = - this.Box.offsetHeight / 2 + "px";
this.Box.style.marginLeft = - this.Box.offsetWidth / 2 + "px";
}else{
this.SetCenter();
}
}
this.onShow();
},
//关闭
Close: function() {
this.Box.style.display = "none";
this.OverLay.Close();
}
};
var box;
$(document).ready(function(){
	$("body").append("<dl id=\"idBox\"><dt id=\"idBoxHead\"><b>服务提交中，请勿做其他操作</b> </dt> </dl>");
	$("#idBox").css("width","300px").css("background","#FFFFFF").css("border-style","solid")
							.css("border-width","1px").css("border-color","#ccc").css("line-height","25px")
							.css("top","20%").css("left","20%").css("text-align","center");
	$("idBoxHead").css("background","#f4f4f4").css("padding","5px");
	box = new LightBox("idBox");
	box.Center = true;
});
	function showLightBox(){
		document.oncontextmenu=new Function("event.returnValue=false");
		box.Show();
	}
	function hideLightBox(){
		document.oncontextmenu=new Function("event.returnValue=true");
		box.Close();
	}