<%
/********************
 version v2.0
������: si-tech
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
		    rdShowMessageDialog('���������븺ֵ,����������!');
		    return false;
		}
		else
			  return false;
    }       
}

//�򿪶˿�
function OpenPort() {
	document.all.serialCommCtl.OpenPort();
}

//�رն˿�
function ClosePort() {
	document.all.serialCommCtl.ClosePort();
}

//���̵�
function InPutPwd() {
	document.all.serialCommCtl.InPutPwd();
}

//�򿪺��
function InPutPwdAgain() {
	document.all.serialCommCtl.InPutPwdAgain();
}

//�ر��̵�,���
function CloseInput() {
	document.all.serialCommCtl.CloseInput();
}

//�رյƣ��رն˿�
function CloseInputPort() {
   CloseInput();
   ClosePort();
}

//���뵥������
function OnInputPwd(obj) {	
	OpenPort();
	if (document.all.serialCommCtl.errorCode == -2) {
	    rdShowMessageDialog("������̶˿��Ѿ���ռ�У���ر��Ѿ��򿪵������������Ի���!");
	    window.close();
		return false;
	}
	obj.value="";
	obj.focus();
	InPutPwd();
}

//�ٴ���������
function OnInputPwdAgain(obj) {
 	OpenPort();
	obj.value="";
	obj.focus();
	InPutPwdAgain();
}

function checkpwd(obj, pwd) {
 	if(obj.value!= pwd) {
		rdShowMessageDialog("��������벻һ�£�����������!",0);
		document.all[obj.prefield].value="";
		obj.value="";
    } else {
		rdShowMessageDialog("�����������ȷ!",1);
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
               rdShowMessageDialog("���벻��Ϊ�գ����������룡");
	           document.all.inputpassword.focus();
	           return false;
            } else if (inputPassword.length < 15){
               rdShowMessageDialog("���볤������Ϊ15λ�����������룡");
	           document.all.inputpassword.focus();
               return false;
            } else if (!reg.test(inputPassword)) {
				rdShowMessageDialog("���������ĸ������");
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
