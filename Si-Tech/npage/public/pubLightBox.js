
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
//����Ĭ������
SetOptions: function(options) {
this.options = {//Ĭ��ֵ
Lay:null,//���ǲ����
Color:"#fff",//����ɫ
Opacity:50,//͸����(0-100)
zIndex: 1000//���˳��
};
Extend(this.options, options || {});
},
//��ʾ
Show: function() {
//������ʽ
with(this.Lay.style){
//����͸����
isIE ? filter = "alpha(opacity:" + this.Opacity + ")" : opacity = this.Opacity / 100;
backgroundColor = this.Color; display = "block";
}
},
//�ر�
Close: function() {
this.Lay.style.display = "none";
}
};

var LightBox = Class.create();
LightBox.prototype = {
initialize: function(box, options) {
this.Box = "string" == typeof box ? $("#"+box)[0] : box ;//��ʾ��
this.OverLay = new OverLay(options);//���ǲ�
this.SetOptions(options);
this.Fixed = !!this.options.Fixed;
this.Over = !!this.options.Over;
this.Center = !!this.options.Center;
this.onShow = this.options.onShow;
this.Box.style.zIndex = this.OverLay.zIndex + 1;
this.Box.style.display = "none";
},
//����Ĭ������
SetOptions: function(options) {
this.options = {//Ĭ��ֵ
Over: true,//�Ƿ���ʾ���ǲ�
Fixed:false,//�Ƿ�̶���λ
Center: false,//�Ƿ����
onShow: function(){}//��ʾʱִ��
};
Extend(this.options, options || {});
},
//����ie6�Ĺ̶���λ����
SetFixed: function(){
this.Box.style.top = document.documentElement.scrollTop - this._top + this.Box.offsetTop + "px";
this.Box.style.left = document.documentElement.scrollLeft - this._left + this.Box.offsetLeft + "px";
this._top = document.documentElement.scrollTop; this._left = document.documentElement.scrollLeft;
},
//����ie6�ľ��ж�λ����
SetCenter: function(){
this.Box.style.marginTop = document.documentElement.scrollTop - this.Box.offsetHeight / 2 + "px";
this.Box.style.marginLeft = document.documentElement.scrollLeft - this.Box.offsetWidth / 2 + "px";
},
//��ʾ
Show: function(options) {
//�̶���λ
this.Box.style.position = this.Fixed ? "fixed" : "absolute";
//���ǲ�
this.Over && this.OverLay.Show();
this.Box.style.display = "block";
//����
if(this.Center){
this.Box.style.top = this.Box.style.left = "50%";
//����margin
if(this.Fixed){
this.Box.style.marginTop = - this.Box.offsetHeight / 2 + "px";
this.Box.style.marginLeft = - this.Box.offsetWidth / 2 + "px";
}else{
this.SetCenter();
}
}
this.onShow();
},
//�ر�
Close: function() {
this.Box.style.display = "none";
this.OverLay.Close();
}
};
var box;
$(document).ready(function(){
	$("body").append("<dl id=\"idBox\"><dt id=\"idBoxHead\"><b>�����ύ�У���������������</b> </dt> </dl>");
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