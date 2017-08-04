/*
 *右键记录文本框近十次输入
 *2009-12-05 14:30
 */
var rigC={
	focusObject:null,
 	Ele:null,
	menuCreate:function(){                                  //画一个右键的面板
		var rt = document.getElementById("rightout");
		if(rt){
			document.body.removeChild(rt);
			}
		var rightout = document.createElement("div");
 		rightout.setAttribute("id","rightout");
 		
 		var divif = document.createElement("iframe");           //解决ie6下div无法遮住select框的问题
 		divif.setAttribute("id","divif");
 		divif.src = "about:blank";
 		
 		var rightKeyMenu = document.createElement("div");
 		rightKeyMenu.setAttribute("id","rightKeyMenu");
 		rightKeyMenu.className = "rightMenu";
		
		var fresh_div = document.createElement("div");
		fresh_div.onclick = function(){
			document.execCommand("Refresh");
			}
		var _fresh = document.createElement("input");
 		_fresh.type = "button";
 		_fresh.value = "刷新";
 		fresh_div.appendChild(_fresh);
 		
 		var copy_div = document.createElement("div");
 		copy_div.onclick = function(){
 			document.execCommand("Copy");
 			}
 		var _copy = document.createElement("input");
 		_copy.type = "button";
 		_copy.value = "复制";
 		copy_div.appendChild(_copy);
 		
 		rigC.Ele = window.event.srcElement;                //捕获事件源
 		var paste_div = document.createElement("div");
 		paste_div.onclick = function(){
 			rigC.Ele.focus();                               
 			document.execCommand("Paste");
 			}
 		var _paste = document.createElement("input");
 		_paste.type = "button";
 		_paste.value = "粘贴";
 		paste_div.appendChild(_paste);
 		
 		rightout.appendChild(divif);
 		rightKeyMenu.appendChild(fresh_div);
 		rightKeyMenu.appendChild(copy_div);
 		rightKeyMenu.appendChild(paste_div);
 		rightout.appendChild(rightKeyMenu);
 		
 		document.body.appendChild(rightout);
 		
 	  var _rightout = document.getElementById("rightout");
 		_rightout.style.pixelLeft = event.x;
	  _rightout.style.pixelTop = event.y+(document.body.scrollTop||document.documentElement.scrollTop);

	  _rightout.style.display = "none";           //在未添加cookie数据前先将右键面板隐藏
 		
		},
	menuShow:function(){                          //展示右键面板
		var rightout = document.getElementById("rightout");
		rightout.style.display = "block";
		document.getElementById("divif").style.height = rightout.offsetHeight;
	},
		
	menuHide:function(){
		var rightout = document.getElementById("rightout");
		if(rightout){
			document.body.removeChild(rightout);
			}
		}
	}
//cookie的写操作
/************************************************** 
　　参数说明： 
		sName      Cookie名 
		sValue     Cookie值
		oExpires   失效日期
　*************************************************/
function setCookie(sName,sValue,oExpires){
	var cookieNum = getCookie("cookieNum")?getCookie("cookieNum"):0;
	var flag = 0;
	var k = 1;
	
	if(cookieNum>10) k = cookieNum -9;   //看cookie中是否存了10个以上的值，如果超过10个，则只查看最近输入的10个中是否与此次存值重复
	for(var i=k;i<=cookieNum;i++){      
		var cName = "rkName".concat(i);
		if(sValue==getCookie(cName)){
			flag = 1;
			break;
			}
		}
		
	if(flag==0){                            //近10次存值中没有出现重复值，则进行存cookie操作
		var sCookie = sName + "=" + escape(sValue);
		if(oExpires){
				sCookie += "; expires=" + oExpires.toGMTString()+"; path=/";  // 设置cookie失效日期及cookie的访问路径
			}
			
		if(sCookie.length<4096){              //判断Cookie总长度是否大于4K
			document.cookie = sCookie;
			return true;                        //返回true，说明存值成功
			}else{
				return false;
				}
	}else{
		return false;
	}
}	
/**cookie的取操作*/
function getCookie(sName){
	var sValue;
	var strCookie = document.cookie;
	var arrCookie = strCookie.split("; ");
	for(var i=0;i<arrCookie.length;i++){
		var arr=arrCookie[i].split("=");
		if(sName==arr[0]){
			sValue=unescape(arr[1]);
			break;
			}
		}
	return sValue;
}

$("input:text").bind("focus", function(){
	rigC.focusObject=this;
	});

/********鼠标移出，记录cookie********/
$("input:text").bind("blur", function(){
	if(this.getAttribute("readonly")==true){
		 return false;
		}else{ 
		var Then = new Date();
		Then.setTime(Then.getTime()+1*3600000);//小时
		Cookie_value = allTrim(this.value);
		var cookieNum = getCookie("cookieNum")?getCookie("cookieNum"):0;
		if(Cookie_value){
			cookieNum++;
			Cookie_name = "rkName".concat(cookieNum);      //设置要存的cookie值的名字
			if(setCookie(Cookie_name,Cookie_value,Then)){   //如果cookie值存入成功，设置计数器
				setCookie("cookieNum",cookieNum,Then);
			}
		}
	}
});

/********读取cookie值，展示右键********/
$("input:text").bind("contextmenu", function(){  
	if(this.getAttribute("readonly")==true){
		return false;
		}else{
		var o=event.srcElement;
		if(o.tagName=="INPUT"){
				rigC.focusObject=o;
			}
		rigC.menuCreate();
				
		var len = getCookie("cookieNum")?getCookie("cookieNum"):0;  //读取cookie中的计数器
		var rightKeyMenu = document.getElementById("rightKeyMenu");
		if(len>0){
			var j = 0;
			if(len>10) j=len-9;                                     ///读取近十次的cookie值
			for(var i=j;i<=len;i++){
				(function(x){
					var aName = "rkName".concat(x);                  //设置要读取的cookie值的名字
					var aValue = getCookie(aName);
					if(aValue){
						var first=rightKeyMenu.firstChild;
						var _div =document.createElement("div");
						first.parentNode.insertBefore(_div,first);
						_div.innerHTML = aValue;
						_div.onclick = function(){
							catchBubble(aValue,rigC.focusObject);     
							}
						}
					}(i))
				}
			}
		rigC.menuShow();
		return false;
	}
});
function allTrim(ss){
   return ss.replace(/(^\s*)|(\s*)|(\s*$)/g, "");   
	}

	
/*获取右键选中的值*/
function catchBubble(val,obj){         
	if(obj!=null){
 		obj.value = val;
 		obj.focus();       //为了为验证validate_class.js提供焦点移开状态
 		obj = null;
 		rigC.focusObject = null;
	}
	rigC.menuHide();
}
	
	
/*隐藏右键*/
document.onclick = function(){
		rigC.menuHide();
	}