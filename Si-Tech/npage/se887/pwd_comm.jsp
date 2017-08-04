<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<OBJECT ID="serialCommCtl" CLASSID="CLSID:1513CEF2-AB40-4321-B4CE-8F4237E5563B" 
	codebase="/ocx/serialComm.cab#Version=1,0,0,6"
	width=1 height=1
>
</OBJECT>
<SCRIPT LANGUAGE="JAVASCRIPT">
function showNumberDialog(obj) {
    var path = "<%=request.getContextPath()%>/npage/common/NumberDialog.jsp";
    var h=170;
    var w=470;
    var t=screen.availHeight/2-h/2;
    var l=screen.availWidth/2-w/2;
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:no; resizable:no;location:no;status:no";
    
	returnValue = window.showModalDialog(path,"",prop);
    
	if (returnValue != '') {
	   obj.value = returnValue;
	}
}

function showReNumberDialog(obj) {
    var path = "<%=request.getContextPath()%>/npage/se887/ReNumberDialog.jsp";
    var h=170;
    var w=470;
    var t=screen.availHeight/2-h/2;
    var l=screen.availWidth/2-w/2;
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:no; resizable:no;location:no;status:no";
    
	returnValue = window.showModalDialog(path,"",prop);
    
	if (returnValue != '') {
	   obj.value = returnValue;
	}
}

 function isKeyNumberdot(ifdot) 
{       
    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
	if(ifdot==0)
		if((s_keycode>=48 && s_keycode<=57 ) || (s_keycode>=97 && s_keycode<=122) || (s_keycode>=65 && s_keycode<=90))
			return true;
		else 
			return false;
    else
    {
		if(((s_keycode>=48 && s_keycode<=57) || s_keycode==46) || (s_keycode>=97 && s_keycode<=122) || (s_keycode>=65 && s_keycode<=90))
		{
		      return true;
		}
		else if(s_keycode==45)
		{
		    rdShowMessageDialog('不允许输入负值,请重新输入!');
		    return false;
		}
		else
			  return false;
    }       
}

//打开端口
function OpenPort() {
	document.all.serialCommCtl.OpenPort();
}

//关闭端口
function ClosePort() {
	document.all.serialCommCtl.ClosePort();
}

//打开绿灯
function InPutPwd() {
	document.all.serialCommCtl.InPutPwd();
}

//打开红灯
function InPutPwdAgain() {
	document.all.serialCommCtl.InPutPwdAgain();
}

//关闭绿灯,红灯
function CloseInput() {
	document.all.serialCommCtl.CloseInput();
}

//关闭灯，关闭端口
function CloseInputPort() {
   CloseInput();
   ClosePort();
}

//输入单个密码
function OnInputPwd(obj) {	
	OpenPort();
	if (document.all.serialCommCtl.errorCode == -2) {
	    rdShowMessageDialog("密码键盘端口已经被占有，请关闭已经打开的密码键盘输入对话框!");
	    window.close();
		return false;
	}
	obj.value="";
	obj.focus();
	InPutPwd();
}

//再次输入密码
function OnInputPwdAgain(obj) {
 	OpenPort();
	obj.value="";
	obj.focus();
	InPutPwdAgain();
}

function checkpwd(obj, pwd) {
 	if(obj.value!= pwd) {
		rdShowMessageDialog("输入的密码不一致，请重新输入!",0);
		document.all[obj.prefield].value="";
		obj.value="";
    } else {
		rdShowMessageDialog("输入的密码正确!",1);
    }   
 }
 
function doit(obj) {
	var tempobj;
  	if(obj.functype=="1") {
		tempobj = document.all[obj.nextfield];
	    OnInputPwdAgain(tempobj);
	} else {
         obj.blur();
 	}
 }

</SCRIPT>
<SCRIPT LANGUAGE="JavaScript" for="serialCommCtl" event="OnCommSend()">
	var serailChar=document.all.serialCommCtl.serialPortData;
	if(document.activeElement.filedtype=="pwd") {
		if (serailChar.charAt(0) == "\10") {
			document.all.inputpassword.value = "";
			//document.activeElement.value=="";
        } else if (serailChar.charAt(0) == '\r') {
			var inputPassword = document.all.inputpassword.value;
            
			if (inputPassword.length == 0) {
               rdShowMessageDialog("密码不能为空，请重新输入！");
	           document.all.inputpassword.focus();
	           return false;
            } else if (inputPassword.length < 15){
               rdShowMessageDialog("密码长度至少为15位，请重新输入！");
	           document.all.inputpassword.focus();
               return false;
            } else if (!reg.test(inputPassword)) {
				rdShowMessageDialog("必须包含字母和数字");
				document.all.inputpassword.focus();
				return false;
			}

			window.returnValue = inputPassword;     
            window.close();

			doit(document.activeElement);
		} else {
			document.activeElement.value=document.activeElement.value+serialCommCtl.serialPortData;
        }
	}
	
	
</script>
