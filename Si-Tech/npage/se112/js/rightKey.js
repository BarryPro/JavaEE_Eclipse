/*
 *�Ҽ���¼�ı����ʮ������
 *2009-12-05 14:30
 */
var rigC={
	focusObject:null,
 	Ele:null,
	menuCreate:function(){                                  //��һ���Ҽ������
		var rt = document.getElementById("rightout");
		if(rt){
			document.body.removeChild(rt);
			}
		var rightout = document.createElement("div");
 		rightout.setAttribute("id","rightout");
 		
 		var divif = document.createElement("iframe");           //���ie6��div�޷���סselect�������
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
 		_fresh.value = "ˢ��";
 		fresh_div.appendChild(_fresh);
 		
 		var copy_div = document.createElement("div");
 		copy_div.onclick = function(){
 			document.execCommand("Copy");
 			}
 		var _copy = document.createElement("input");
 		_copy.type = "button";
 		_copy.value = "����";
 		copy_div.appendChild(_copy);
 		
 		rigC.Ele = window.event.srcElement;                //�����¼�Դ
 		var paste_div = document.createElement("div");
 		paste_div.onclick = function(){
 			rigC.Ele.focus();                               
 			document.execCommand("Paste");
 			}
 		var _paste = document.createElement("input");
 		_paste.type = "button";
 		_paste.value = "ճ��";
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

	  _rightout.style.display = "none";           //��δ���cookie����ǰ�Ƚ��Ҽ��������
 		
		},
	menuShow:function(){                          //չʾ�Ҽ����
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
//cookie��д����
/************************************************** 
��������˵���� 
		sName      Cookie�� 
		sValue     Cookieֵ
		oExpires   ʧЧ����
��*************************************************/
function setCookie(sName,sValue,oExpires){
	var cookieNum = getCookie("cookieNum")?getCookie("cookieNum"):0;
	var flag = 0;
	var k = 1;
	
	if(cookieNum>10) k = cookieNum -9;   //��cookie���Ƿ����10�����ϵ�ֵ���������10������ֻ�鿴��������10�����Ƿ���˴δ�ֵ�ظ�
	for(var i=k;i<=cookieNum;i++){      
		var cName = "rkName".concat(i);
		if(sValue==getCookie(cName)){
			flag = 1;
			break;
			}
		}
		
	if(flag==0){                            //��10�δ�ֵ��û�г����ظ�ֵ������д�cookie����
		var sCookie = sName + "=" + escape(sValue);
		if(oExpires){
				sCookie += "; expires=" + oExpires.toGMTString()+"; path=/";  // ����cookieʧЧ���ڼ�cookie�ķ���·��
			}
			
		if(sCookie.length<4096){              //�ж�Cookie�ܳ����Ƿ����4K
			document.cookie = sCookie;
			return true;                        //����true��˵����ֵ�ɹ�
			}else{
				return false;
				}
	}else{
		return false;
	}
}	
/**cookie��ȡ����*/
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

/********����Ƴ�����¼cookie********/
$("input:text").bind("blur", function(){
	if(this.getAttribute("readonly")==true){
		 return false;
		}else{ 
		var Then = new Date();
		Then.setTime(Then.getTime()+1*3600000);//Сʱ
		Cookie_value = allTrim(this.value);
		var cookieNum = getCookie("cookieNum")?getCookie("cookieNum"):0;
		if(Cookie_value){
			cookieNum++;
			Cookie_name = "rkName".concat(cookieNum);      //����Ҫ���cookieֵ������
			if(setCookie(Cookie_name,Cookie_value,Then)){   //���cookieֵ����ɹ������ü�����
				setCookie("cookieNum",cookieNum,Then);
			}
		}
	}
});

/********��ȡcookieֵ��չʾ�Ҽ�********/
$("input:text").bind("contextmenu", function(){  
	if(this.getAttribute("readonly")==true){
		return false;
		}else{
		var o=event.srcElement;
		if(o.tagName=="INPUT"){
				rigC.focusObject=o;
			}
		rigC.menuCreate();
				
		var len = getCookie("cookieNum")?getCookie("cookieNum"):0;  //��ȡcookie�еļ�����
		var rightKeyMenu = document.getElementById("rightKeyMenu");
		if(len>0){
			var j = 0;
			if(len>10) j=len-9;                                     ///��ȡ��ʮ�ε�cookieֵ
			for(var i=j;i<=len;i++){
				(function(x){
					var aName = "rkName".concat(x);                  //����Ҫ��ȡ��cookieֵ������
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

	
/*��ȡ�Ҽ�ѡ�е�ֵ*/
function catchBubble(val,obj){         
	if(obj!=null){
 		obj.value = val;
 		obj.focus();       //Ϊ��Ϊ��֤validate_class.js�ṩ�����ƿ�״̬
 		obj = null;
 		rigC.focusObject = null;
	}
	rigC.menuHide();
}
	
	
/*�����Ҽ�*/
document.onclick = function(){
		rigC.menuHide();
	}