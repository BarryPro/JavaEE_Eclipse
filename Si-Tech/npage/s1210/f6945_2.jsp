<% 
  /*
   * ����: �������������ܺ������ۺ�����_��������
�� * �汾: v1.00
�� * ����: 2010/03/23
�� * ����: dujl
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   *  
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<head>
<title>�������������ܺ������ۺ�����_��������</title>

<%
String opCode = "7478";
String opName = "�������������ܺ������ۺ�����_��������";

String work_no = (String) session.getAttribute("workNo");
String loginNoPass = (String)session.getAttribute("password");
String org_code = (String) session.getAttribute("orgCode");
String regionCode = org_code.substring(0, 2);

String printAccept="";
printAccept = getMaxAccept();

%>

<script language=javascript>
onload=function()
{
	init();
}

function init()
{
	document.all.iCodeStr1.value = "";
	document.all.iCodeStr2.value = "";
	document.all.iCodeStr3.value = "";
	document.all.iCodeStr4.value = "";
	document.all.iCodeStr5.value = "";
	document.all.iCodeStr6.value = "";
	document.all.iCodeStr7.value = "";
	document.all.iCodeStr8.value = "";
	document.all.iCodeStr9.value = "";
	document.all.iCodeStr10.value = "";
	
	for(var i=1; i<=10; i++) {
	$("#seled"+i).empty();
	$("#seled"+i).append("<option value='' selected>��ѡ��</option>");
 }

}
		function changType(i)
{
	 			var typeflag = 	$("#delayType"+i).val();
				if(typeflag=="F") {
				$("#seled"+i).empty();
				$("#seled"+i).append("<option value='02' selected>ʡ�ڼ��</option><option value='04'>�û�Ͷ��</option>");
			  }
			   else if(typeflag==""){
			  $("#seled"+i).empty();
				$("#seled"+i).append("<option value='' selected>��ѡ��</option>");
			  }
			  else {
			  $("#seled"+i).empty();
				$("#seled"+i).append("<option value='03' selected>�ٱ�����</option><option value='02'>ʡ�ڼ��</option>");
			  }

	 
}
//begin huangrong add ¼�����ԭ��ĵ�����
function addReson(bing)
{
	var resonTxt=document.getElementById(bing);
	var prop="dialogHeight:400px; dialogWidth:1000px; dialogLeft:200px; dialogTop:200px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	var ret = window.showModalDialog("./f6945_getOpReson.jsp?resonTxt="+ resonTxt.value,"",prop);
	if(typeof(ret)=="undefined")
	{
		ret="";
	}
  resonTxt.value=	ret;
}
//end huangrong add ¼�����ԭ��ĵ�����
function add1()
{
	if(document.all.phoneNo1.value.trim() == "")
	{
		document.all.phoneNo1.value = "";
		rdShowMessageDialog("�������ֻ����룡");
		return false;
	}
	if(document.all.opType1.value == "")
	{
		rdShowMessageDialog("��ѡ�����/�޸ı�־��");
		return false;
	}
	if(document.all.delayType1.value == "")
	{
		rdShowMessageDialog("��ѡ�����ڱ�־��");
		return false;
	}
	if(document.all.opReson1.value=="")
	{
		document.all.opReson1.value="��";
	}
	var seled1 = 	$("#seled1").val();
	document.all.iCodeStr1.value=document.all.phoneNo1.value+"|"+document.all.opType1.value+"|"+document.all.delayType1.value+"|"+document.all.opReson1.value+"|"+seled1;
	
	document.all.phoneNo1.disabled=true;
	document.all.opType1.disabled=true;
	document.all.delayType1.disabled=true;
	document.all.onReson1.disabled=true;//huangron add ¼�����ԭ��ťʧЧ 2011-6-21 
}

function add2()
{
	if(document.all.phoneNo2.value.trim() == "")
	{
		document.all.phoneNo2.value = "";
		rdShowMessageDialog("�������ֻ����룡");
		return false;
	}
	if(document.all.opType2.value == "")
	{
		rdShowMessageDialog("��ѡ�����/�޸ı�־��");
		return false;
	}
	if(document.all.delayType2.value == "")
	{
		rdShowMessageDialog("��ѡ�����ڱ�־��");
		return false;
	}
	if(document.all.opReson2.value=="")
	{
		document.all.opReson2.value="��";
	}
	var seled2 = 	$("#seled2").val();
	document.all.iCodeStr2.value=document.all.phoneNo2.value+"|"+document.all.opType2.value+"|"+document.all.delayType2.value+"|"+document.all.opReson2.value+"|"+seled2;
	
	document.all.phoneNo2.disabled=true;
	document.all.opType2.disabled=true;
	document.all.delayType2.disabled=true;
	document.all.onReson2.disabled=true;//huangron add ¼�����ԭ��ťʧЧ 2011-6-21 
}

function add3()
{
	if(document.all.phoneNo3.value.trim() == "")
	{
		document.all.phoneNo3.value = "";
		rdShowMessageDialog("�������ֻ����룡");
		return false;
	}
	if(document.all.opType3.value == "")
	{
		rdShowMessageDialog("��ѡ�����/�޸ı�־��");
		return false;
	}
	if(document.all.delayType3.value == "")
	{
		rdShowMessageDialog("��ѡ�����ڱ�־��");
		return false;
	}
	if(document.all.opReson3.value=="")
	{
		document.all.opReson3.value="��";
	}
	var seled3 = 	$("#seled3").val();	
	document.all.iCodeStr3.value=document.all.phoneNo3.value+"|"+document.all.opType3.value+"|"+document.all.delayType3.value+"|"+document.all.opReson3.value+"|"+seled3;
	
	document.all.phoneNo3.disabled=true;
	document.all.opType3.disabled=true;
	document.all.delayType3.disabled=true;
	document.all.onReson3.disabled=true;//huangron add ¼�����ԭ��ťʧЧ 2011-6-21 
}

function add4()
{
	if(document.all.phoneNo4.value.trim() == "")
	{
		document.all.phoneNo4.value = "";
		rdShowMessageDialog("�������ֻ����룡");
		return false;
	}
	if(document.all.opType4.value == "")
	{
		rdShowMessageDialog("��ѡ�����/�޸ı�־��");
		return false;
	}
	if(document.all.delayType4.value == "")
	{
		rdShowMessageDialog("��ѡ�����ڱ�־��");
		return false;
	}
	if(document.all.opReson4.value=="")
	{
		document.all.opReson4.value="��";
	}
	var seled4 = 	$("#seled4").val();	
	document.all.iCodeStr4.value=document.all.phoneNo4.value+"|"+document.all.opType4.value+"|"+document.all.delayType4.value+"|"+document.all.opReson4.value+"|"+seled4;
	
	document.all.phoneNo4.disabled=true;
	document.all.opType4.disabled=true;
	document.all.delayType4.disabled=true;
	document.all.onReson4.disabled=true;//huangron add ¼�����ԭ��ťʧЧ 2011-6-21 
}

function add5()
{
	if(document.all.phoneNo5.value.trim() == "")
	{
		document.all.phoneNo5.value = "";
		rdShowMessageDialog("�������ֻ����룡");
		return false;
	}
	if(document.all.opType5.value == "")
	{
		rdShowMessageDialog("��ѡ�����/�޸ı�־��");
		return false;
	}
	if(document.all.delayType5.value == "")
	{
		rdShowMessageDialog("��ѡ�����ڱ�־��");
		return false;
	}
	if(document.all.opReson5.value=="")
	{
		document.all.opReson5.value="��";
	}
	var seled5 = 	$("#seled5").val();	
	document.all.iCodeStr5.value=document.all.phoneNo5.value+"|"+document.all.opType5.value+"|"+document.all.delayType5.value+"|"+document.all.opReson5.value+"|"+seled5;
	
	document.all.phoneNo5.disabled=true;
	document.all.opType5.disabled=true;
	document.all.delayType5.disabled=true;
	document.all.onReson5.disabled=true;//huangron add ¼�����ԭ��ťʧЧ 2011-6-21 
}

function add6()
{
	if(document.all.phoneNo6.value.trim() == "")
	{
		document.all.phoneNo6.value = "";
		rdShowMessageDialog("�������ֻ����룡");
		return false;
	}
	if(document.all.opType6.value == "")
	{
		rdShowMessageDialog("��ѡ�����/�޸ı�־��");
		return false;
	}
	if(document.all.delayType6.value == "")
	{
		rdShowMessageDialog("��ѡ�����ڱ�־��");
		return false;
	}
	if(document.all.opReson6.value=="")
	{
		document.all.opReson6.value="��";
	}
	var seled6 = 	$("#seled6").val();
	document.all.iCodeStr6.value=document.all.phoneNo6.value+"|"+document.all.opType6.value+"|"+document.all.delayType6.value+"|"+document.all.opReson6.value+"|"+seled6;
	
	document.all.phoneNo6.disabled=true;
	document.all.opType6.disabled=true;
	document.all.delayType6.disabled=true;
	document.all.onReson6.disabled=true;//huangron add ¼�����ԭ��ťʧЧ 2011-6-21 
}

function add7()
{
	if(document.all.phoneNo7.value.trim() == "")
	{
		document.all.phoneNo7.value = "";
		rdShowMessageDialog("�������ֻ����룡");
		return false;
	}
	if(document.all.opType7.value == "")
	{
		rdShowMessageDialog("��ѡ�����/�޸ı�־��");
		return false;
	}
	if(document.all.delayType7.value == "")
	{
		rdShowMessageDialog("��ѡ�����ڱ�־��");
		return false;
	}
	if(document.all.opReson7.value=="")
	{
		document.all.opReson7.value="��";
	}
	var seled7 = 	$("#seled7").val();
	document.all.iCodeStr7.value=document.all.phoneNo7.value+"|"+document.all.opType7.value+"|"+document.all.delayType7.value+"|"+document.all.opReson7.value+"|"+seled7;
	
	document.all.phoneNo7.disabled=true;
	document.all.opType7.disabled=true;
	document.all.delayType7.disabled=true;
	document.all.onReson7.disabled=true;//huangron add ¼�����ԭ��ťʧЧ 2011-6-21 
}

function add8()
{
	if(document.all.phoneNo8.value.trim() == "")
	{
		document.all.phoneNo8.value = "";
		rdShowMessageDialog("�������ֻ����룡");
		return false;
	}
	if(document.all.opType8.value == "")
	{
		rdShowMessageDialog("��ѡ�����/�޸ı�־��");
		return false;
	}
	if(document.all.delayType8.value == "")
	{
		rdShowMessageDialog("��ѡ�����ڱ�־��");
		return false;
	}
	if(document.all.opReson8.value=="")
	{
		document.all.opReson8.value="��";
	}
	var seled8 = 	$("#seled8").val();
	document.all.iCodeStr8.value=document.all.phoneNo8.value+"|"+document.all.opType8.value+"|"+document.all.delayType8.value+"|"+document.all.opReson8.value+"|"+seled8;
	
	document.all.phoneNo8.disabled=true;
	document.all.opType8.disabled=true;
	document.all.delayType8.disabled=true;
	document.all.onReson8.disabled=true;//huangron add ¼�����ԭ��ťʧЧ 2011-6-21 
}

function add9()
{
	if(document.all.phoneNo9.value.trim() == "")
	{
		document.all.phoneNo9.value = "";
		rdShowMessageDialog("�������ֻ����룡");
		return false;
	}
	if(document.all.opType9.value == "")
	{
		rdShowMessageDialog("��ѡ�����/�޸ı�־��");
		return false;
	}
	if(document.all.delayType9.value == "")
	{
		rdShowMessageDialog("��ѡ�����ڱ�־��");
		return false;
	}
	if(document.all.opReson9.value=="")
	{
		document.all.opReson9.value="��";
	}
	var seled9 = 	$("#seled9").val();
	document.all.iCodeStr9.value=document.all.phoneNo9.value+"|"+document.all.opType9.value+"|"+document.all.delayType9.value+"|"+document.all.opReson9.value+"|"+seled9;
	
	document.all.phoneNo9.disabled=true;
	document.all.opType9.disabled=true;
	document.all.delayType9.disabled=true;
	document.all.onReson9.disabled=true;//huangron add ¼�����ԭ��ťʧЧ 2011-6-21 
}

function add10()
{
	if(document.all.phoneNo10.value.trim() == "")
	{
		document.all.phoneNo10.value = "";
		rdShowMessageDialog("�������ֻ����룡");
		return false;
	}
	if(document.all.opType10.value == "")
	{
		rdShowMessageDialog("��ѡ�����/�޸ı�־��");
		return false;
	}
	if(document.all.delayType10.value == "")
	{
		rdShowMessageDialog("��ѡ�����ڱ�־��");
		return false;
	}
	if(document.all.opReson10.value=="")
	{
		document.all.opReson10.value="��";
	}
	var seled10 = 	$("#seled10").val();
	document.all.iCodeStr10.value=document.all.phoneNo10.value+"|"+document.all.opType10.value+"|"+document.all.delayType10.value+"|"+document.all.opReson10.value+"|"+seled10;
	
	document.all.phoneNo10.disabled=true;
	document.all.opType10.disabled=true;
	document.all.delayType10.disabled=true;
	document.all.onReson10.disabled=true;//huangron add ¼�����ԭ��ťʧЧ 2011-6-21 
}

function onChg2()
{
	if(document.all.iCodeStr1.value == "")
	{
		document.all.phoneNo2.value = "";
		rdShowMessageDialog("��һ����δ��ӣ��밴˳����ӣ�");
		return false;
	}
}

function onChg3()
{
	if(document.all.iCodeStr2.value == "")
	{
		document.all.phoneNo3.value = "";
		rdShowMessageDialog("��һ����δ��ӣ��밴˳����ӣ�");
		return false;
	}
}

function onChg4()
{
	if(document.all.iCodeStr3.value == "")
	{
		document.all.phoneNo4.value = "";
		rdShowMessageDialog("��һ����δ��ӣ��밴˳����ӣ�");
		return false;
	}
}

function onChg5()
{
	if(document.all.iCodeStr4.value == "")
	{
		document.all.phoneNo5.value = "";
		rdShowMessageDialog("��һ����δ��ӣ��밴˳����ӣ�");
		return false;
	}
}

function onChg6()
{
	if(document.all.iCodeStr5.value == "")
	{
		document.all.phoneNo6.value = "";
		rdShowMessageDialog("��һ����δ��ӣ��밴˳����ӣ�");
		return false;
	}
}

function onChg7()
{
	if(document.all.iCodeStr6.value == "")
	{
		document.all.phoneNo7.value = "";
		rdShowMessageDialog("��һ����δ��ӣ��밴˳����ӣ�");
		return false;
	}
}

function onChg8()
{
	if(document.all.iCodeStr7.value == "")
	{
		document.all.phoneNo8.value = "";
		rdShowMessageDialog("��һ����δ��ӣ��밴˳����ӣ�");
		return false;
	}
}

function onChg9()
{
	if(document.all.iCodeStr8.value == "")
	{
		document.all.phoneNo9.value = "";
		rdShowMessageDialog("��һ����δ��ӣ��밴˳����ӣ�");
		return false;
	}
}

function onChg10()
{
	if(document.all.iCodeStr9.value == "")
	{
		document.all.phoneNo10.value = "";
		rdShowMessageDialog("��һ����δ��ӣ��밴˳����ӣ�");
		return false;
	}
}

function again()
{
	document.all.phoneNo1.value = "";
	document.all.opType1.value = "";
	document.all.delayType1.value = "";
	document.all.iCodeStr1.value = "";
	document.all.phoneNo1.disabled=false;
	document.all.opType1.disabled=false;
	document.all.delayType1.disabled=false;
	document.all.onReson1.disabled=false;
		
	document.all.phoneNo2.value = "";
	document.all.opType2.value = "";
	document.all.delayType2.value = "";
	document.all.iCodeStr2.value = "";
	document.all.phoneNo2.disabled=false;
	document.all.opType2.disabled=false;
	document.all.delayType2.disabled=false;
	document.all.onReson2.disabled=false;
		
	document.all.phoneNo3.value = "";
	document.all.opType3.value = "";
	document.all.delayType3.value = "";
	document.all.iCodeStr3.value = "";
	document.all.phoneNo3.disabled=false;
	document.all.opType3.disabled=false;
	document.all.delayType3.disabled=false;
	document.all.onReson3.disabled=false;
		
	document.all.phoneNo4.value = "";
	document.all.opType4.value = "";
	document.all.delayType4.value = "";
	document.all.iCodeStr4.value = "";
	document.all.phoneNo4.disabled=false;
	document.all.opType4.disabled=false;
	document.all.delayType4.disabled=false;
	document.all.onReson4.disabled=false;	
	
	document.all.phoneNo5.value = "";
	document.all.opType5.value = "";
	document.all.delayType5.value = "";
	document.all.iCodeStr5.value = "";
	document.all.phoneNo5.disabled=false;
	document.all.opType5.disabled=false;
	document.all.delayType5.disabled=false;
	document.all.onReson5.disabled=false;
		
	document.all.phoneNo6.value = "";
	document.all.opType6.value = "";
	document.all.delayType6.value = "";
	document.all.iCodeStr6.value = "";
	document.all.phoneNo6.disabled=false;
	document.all.opType6.disabled=false;
	document.all.delayType6.disabled=false;
	document.all.onReson6.disabled=false;
		
	document.all.phoneNo7.value = "";
	document.all.opType7.value = "";
	document.all.delayType7.value = "";
	document.all.iCodeStr7.value = "";
	document.all.phoneNo7.disabled=false;
	document.all.opType7.disabled=false;
	document.all.delayType7.disabled=false;
	document.all.onReson7.disabled=false;
		
	document.all.phoneNo8.value = "";
	document.all.opType8.value = "";
	document.all.delayType8.value = "";
	document.all.iCodeStr8.value = "";
	document.all.phoneNo8.disabled=false;
	document.all.opType8.disabled=false;
	document.all.delayType8.disabled=false;
	document.all.onReson8.disabled=false;
		
	document.all.phoneNo9.value = "";
	document.all.opType9.value = "";
	document.all.delayType9.value = "";
	document.all.iCodeStr9.value = "";
	document.all.phoneNo9.disabled=false;
	document.all.opType9.disabled=false;
	document.all.delayType9.disabled=false;
	document.all.onReson9.disabled=false;
		
	document.all.phoneNo10.value = "";
	document.all.opType10.value = "";
	document.all.delayType10.value = "";
	document.all.iCodeStr10.value = "";
	document.all.phoneNo10.disabled=false;
	document.all.opType10.disabled=false;
	document.all.delayType10.disabled=false;
	document.all.onReson10.disabled=false;	
}

function confirm()
{
	if(document.all.iCodeStr1.value == "")
	{
		rdShowMessageDialog("���Ƚ�����Ӳ�����");
		return false;
	}
	if((document.all.iCodeStr2.value=="") && ((document.all.phoneNo2.value.trim()!="")
	||(document.all.opType2.value.trim()!="")||(document.all.delayType2.value.trim()!="")))
	{
		rdShowMessageDialog("���ȶԵڶ���������Ӳ�����");
		return false;
	}
	if((document.all.iCodeStr3.value=="") && ((document.all.phoneNo3.value.trim()!="")
	||(document.all.opType3.value.trim()!="")||(document.all.delayType3.value.trim()!="")))
	{
		rdShowMessageDialog("���ȶԵ�����������Ӳ�����");
		return false;
	}
	if((document.all.iCodeStr4.value=="") && ((document.all.phoneNo4.value.trim()!="")
	||(document.all.opType4.value.trim()!="")||(document.all.delayType4.value.trim()!="")))
	{
		rdShowMessageDialog("���ȶԵ�����������Ӳ�����");
		return false;
	}
	if((document.all.iCodeStr5.value=="") && ((document.all.phoneNo5.value.trim()!="")
	||(document.all.opType5.value.trim()!="")||(document.all.delayType5.value.trim()!="")))
	{
		rdShowMessageDialog("���ȶԵ�����������Ӳ�����");
		return false;
	}
	if((document.all.iCodeStr6.value=="") && ((document.all.phoneNo6.value.trim()!="")
	||(document.all.opType6.value.trim()!="")||(document.all.delayType6.value.trim()!="")))
	{
		rdShowMessageDialog("���ȶԵ�����������Ӳ�����");
		return false;
	}
	if((document.all.iCodeStr7.value=="") && ((document.all.phoneNo7.value.trim()!="")
	||(document.all.opType7.value.trim()!="")||(document.all.delayType7.value.trim()!="")))
	{
		rdShowMessageDialog("���ȶԵ�����������Ӳ�����");
		return false;
	}
	if((document.all.iCodeStr8.value=="") && ((document.all.phoneNo8.value.trim()!="")
	||(document.all.opType8.value.trim()!="")||(document.all.delayType8.value.trim()!="")))
	{
		rdShowMessageDialog("���ȶԵڰ���������Ӳ�����");
		return false;
	}
	if((document.all.iCodeStr9.value=="") && ((document.all.phoneNo9.value.trim()!="")
	||(document.all.opType9.value.trim()!="")||(document.all.delayType9.value.trim()!="")))
	{
		rdShowMessageDialog("���ȶԵھ���������Ӳ�����");
		return false;
	}
	if((document.all.iCodeStr10.value=="") && ((document.all.phoneNo10.value.trim()!="")
	||(document.all.opType10.value.trim()!="")||(document.all.delayType10.value.trim()!="")))
	{
		rdShowMessageDialog("���ȶԵ�ʮ��������Ӳ�����");
		return false;
	}
	
	frm.submit();
}

</script>

</head>
<body>
<form name="frm" method="POST" action="f6945ImpCfm.jsp">
<%@ include file="/npage/include/header.jsp" %>

<div class="title">
    <div id="title_zi">�û���Ϣ</div>
</div>
<table cellspacing="0">
	<tr>
		<td align="center" class="blue" width="20%" nowrap>�ֻ�����</td>
	    <td align="center" class="blue" width="20%" nowrap>���/�޸ı�־</td>
	    <td align="center" class="blue" width="20%" nowrap>���ڱ�־</td>
	    <td align="center" class="blue" width="20%" nowrap>������Դ</td>
	    <td align="center" class="blue" width="20%" nowrap>����ԭ��</td><!--huangrong add ����ԭ���¼�� 2011-6-21-->
	    <td align="center" class="blue" width="20%" nowrap>��Ӳ���</td>
	</tr>
	<tr>
		<td align="center" width="20%" class="blue">
	    	<input class="button" type="text" name="phoneNo1" id="phoneNo1" value="" size="15" maxlength="11" onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
	    </td>
	    <td align="center" width="20%" class="blue">
	    	<select name="opType1" id="opType1" class="button">
	    		<option value="" selected>��ѡ��</option>
	    		<option value="A">���Ϊ�������źͺ������û�</option>
	    		<option value="U">�޸ĸ��û����������źͺ������Ļָ�ʱ��</option>
	    	</select>
	    </td>
	    <td align="center" width="20%" class="blue">
	    	<select name="delayType1" id="delayType1" class="button" onChange="changType('1')">
	    		<option value="" selected>��ѡ��</option>
	    		<option value="Y">����7��</option>
	    		<option value="N">��ͣ7��</option>
	    		<option value="T">���ڹ�ͣ</option>
	    		<option value="F">�����ָ�</option>
	    	</select>
	    </td>
	    	   
              <TD align="center" width="20%" class="blue">
                 <select id="seled1" class="button">
									</select>

	          </TD>
	    <td align="center" width="20%" class="blue"><!--huangrong add ¼��ԭ��ť���ı���-->
	    	<input class="b_text" type="button" name="onReson1" value="¼�����ԭ��" onclick="addReson('opReson1')">
	    	<input type="hidden" name="opReson1" id="opReson1" value="">
	    </td>	    
	    <td align="center" width="20%" class="blue">
	    	<input class="b_text" type="button" name="onAdd1" value="���" onclick="add1()">
	    </td>
	</tr>
	<tr>
		<td align="center" width="20%" class="blue">
	    	<input class="button" type="text" name="phoneNo2" id="phoneNo2" value="" size="15" maxlength="11" onblur="onChg2()"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
	    </td>
	    <td align="center" width="20%" class="blue">
	    	<select name="opType2" id="opType2" class="button">
	    		<option value="" selected>��ѡ��</option>
	    		<option value="A">���Ϊ�������źͺ������û�</option>
	    		<option value="U">�޸ĸ��û����������źͺ������Ļָ�ʱ��</option>
	    	</select>
	    </td>
	    <td align="center" width="20%" class="blue">
	    	<select name="delayType2" id="delayType2" class="button" onChange="changType('2')">
	    		<option value="" selected>��ѡ��</option>
	    		<option value="Y">����7��</option>
	    		<option value="N">��ͣ7��</option>
	    		<option value="T">���ڹ�ͣ</option>
	    		<option value="F">�����ָ�</option>
	    	</select>
	    </td>
	                  <TD align="center" width="20%" class="blue">
                 <select id="seled2" class="button">
									</select>

	          </TD>
	    <td align="center" width="20%" class="blue"><!--huangrong add ¼��ԭ��ť-->
	    	<input class="b_text" type="button" name="onReson2" value="¼�����ԭ��" onclick="addReson('opReson2')">
	    	<input type="hidden" name="opReson2" id="opReson2" value="">
	    </td>	    
	    <td align="center" width="20%" class="blue">
	    	<input class="b_text" type="button" name="onAdd2" value="���" onclick="add2()">
	    </td>
	</tr>
	<tr>
	    <td align="center" width="20%" class="blue">
	    	<input class="button" type="text" name="phoneNo3" id="phoneNo3" value="" size="15" maxlength="11" onblur="onChg3()"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
	    </td>
	    <td align="center" width="20%" class="blue">
	    	<select name="opType3" id="opType3" class="button">
	    		<option value="" selected>��ѡ��</option>
	    		<option value="A">���Ϊ�������źͺ������û�</option>
	    		<option value="U">�޸ĸ��û����������źͺ������Ļָ�ʱ��</option>
	    	</select>
	    </td>
	    <td align="center" width="20%" class="blue">
	    	<select name="delayType3" id="delayType3" class="button" onChange="changType('3')">
	    		<option value="" selected>��ѡ��</option>
	    		<option value="Y">����7��</option>
	    		<option value="N">��ͣ7��</option>
	    		<option value="T">���ڹ�ͣ</option>
	    		<option value="F">�����ָ�</option>
	    	</select>
	    </td>
	    	    <TD align="center" width="20%" class="blue">
                 <select id="seled3" class="button">
									</select>

	          </TD>
	    <td align="center" width="20%" class="blue"><!--huangrong add ¼��ԭ��ť-->
	    	<input class="b_text" type="button" name="onReson3" value="¼�����ԭ��" onclick="addReson('opReson3')">
	    	<input type="hidden" name="opReson3" id="opReson3" value="">
	    </td>	    
	    <td align="center" width="20%" class="blue">
	    	<input class="b_text" type="button" name="onAdd3" value="���" onclick="add3()">
	    </td>
	</tr>
	<tr>
	    <td align="center" width="20%" class="blue">
	    	<input class="button" type="text" name="phoneNo4" id="phoneNo4" value="" size="15" maxlength="11" onblur="onChg4()"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
	    </td>
	    <td align="center" width="20%" class="blue">
	    	<select name="opType4" id="opType4" class="button">
	    		<option value="" selected>��ѡ��</option>
	    		<option value="A">���Ϊ�������źͺ������û�</option>
	    		<option value="U">�޸ĸ��û����������źͺ������Ļָ�ʱ��</option>
	    	</select>
	    </td>
	    <td align="center" width="20%" class="blue">
	    	<select name="delayType4" id="delayType4" class="button" onChange="changType('4')">
	    		<option value="" selected>��ѡ��</option>
	    		<option value="Y">����7��</option>
	    		<option value="N">��ͣ7��</option>
	    		<option value="T">���ڹ�ͣ</option>
	    		<option value="F">�����ָ�</option>
	    	</select>
	    </td>
	    	    <TD align="center" width="20%" class="blue">
                 <select id="seled4" class="button">
									</select>

	          </TD>	    
	    <td align="center" width="20%" class="blue"><!--huangrong add ¼��ԭ��ť-->
	    	<input class="b_text" type="button" name="onReson4" value="¼�����ԭ��" onclick="addReson('opReson4')">
	    	<input type="hidden" name="opReson4" id="opReson4" value="">
	    </td>	    
	    <td align="center" width="20%" class="blue">
	    	<input class="b_text" type="button" name="onAdd4" value="���" onclick="add4()">
	    </td>
	</tr>
	<tr>
		<td align="center" width="20%" class="blue">
	    	<input class="button" type="text" name="phoneNo5" id="phoneNo5" value="" size="15" maxlength="11" onblur="onChg5()"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
	    </td>
	    <td align="center" width="20%" class="blue">
	    	<select name="opType5" id="opType5" class="button">
	    		<option value="" selected>��ѡ��</option>
	    		<option value="A">���Ϊ�������źͺ������û�</option>
	    		<option value="U">�޸ĸ��û����������źͺ������Ļָ�ʱ��</option>
	    	</select>
	    </td>
	    <td align="center" width="20%" class="blue">
	    	<select name="delayType5" id="delayType5" class="button" onChange="changType('5')">
	    		<option value="" selected>��ѡ��</option>
	    		<option value="Y">����7��</option>
	    		<option value="N">��ͣ7��</option>
	    		<option value="T">���ڹ�ͣ</option>
	    		<option value="F">�����ָ�</option>
	    	</select>
	    </td>
	    	    <TD align="center" width="20%" class="blue">
                 <select id="seled5" class="button">
									</select>

	          </TD>	    
	    <td align="center" width="20%" class="blue"><!--huangrong add ¼��ԭ��ť-->
	    	<input class="b_text" type="button" name="onReson5" value="¼�����ԭ��" onclick="addReson('opReson5')">
	    	<input type="hidden" name="opReson5" id="opReson5" value="">
	    </td>	    
	    <td align="center" width="20%" class="blue">
	    	<input class="b_text" type="button" name="onAdd5" value="���" onclick="add5()">
	    </td>
	</tr>
	<tr>
		<td align="center" width="20%" class="blue">
	    	<input class="button" type="text" name="phoneNo6" id="phoneNo6" value="" size="15" maxlength="11" onblur="onChg6()" onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
	    </td>
	    <td align="center" width="20%" class="blue">
	    	<select name="opType6" id="opType6" class="button">
	    		<option value="" selected>��ѡ��</option>
	    		<option value="A">���Ϊ�������źͺ������û�</option>
	    		<option value="U">�޸ĸ��û����������źͺ������Ļָ�ʱ��</option>
	    	</select>
	    </td>
	    <td align="center" width="20%" class="blue">
	    	<select name="delayType6" id="delayType6" class="button" onChange="changType('6')">
	    		<option value="" selected>��ѡ��</option>
	    		<option value="Y">����7��</option>
	    		<option value="N">��ͣ7��</option>
	    		<option value="T">���ڹ�ͣ</option>
	    		<option value="F">�����ָ�</option>
	    	</select>
	    </td>
	    	    <TD align="center" width="20%" class="blue">
                 <select id="seled6" class="button">
									</select>

	          </TD>
	    <td align="center" width="20%" class="blue"><!--huangrong add ¼��ԭ��ť-->
	    	<input class="b_text" type="button" name="onReson6" value="¼�����ԭ��" onclick="addReson('opReson6')">
	    	<input type="hidden" name="opReson6" id="opReson6" value="">
	    </td>	    
	    <td align="center" width="20%" class="blue">
	    	<input class="b_text" type="button" name="onAdd6" value="���" onclick="add6()">
	    </td>
	</tr>
	<tr>
	    <td align="center" width="20%" class="blue">
	    	<input class="button" type="text" name="phoneNo7" id="phoneNo7" value="" size="15" maxlength="11" onblur="onChg7()"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
	    </td>
	    <td align="center" width="20%" class="blue">
	    	<select name="opType7" id="opType7" class="button">
	    		<option value="" selected>��ѡ��</option>
	    		<option value="A">���Ϊ�������źͺ������û�</option>
	    		<option value="U">�޸ĸ��û����������źͺ������Ļָ�ʱ��</option>
	    	</select>
	    </td>
	    <td align="center" width="20%" class="blue">
	    	<select name="delayType7" id="delayType7" class="button" onChange="changType('7')">
	    		<option value="" selected>��ѡ��</option>
	    		<option value="Y">����7��</option>
	    		<option value="N">��ͣ7��</option>
	    		<option value="T">���ڹ�ͣ</option>
	    		<option value="F">�����ָ�</option>
	    	</select>
	    </td>
	    	    <TD align="center" width="20%" class="blue">
                 <select id="seled7" class="button">
									</select>

	          </TD>	    
	    <td align="center" width="20%" class="blue"><!--huangrong add ¼��ԭ��ť-->
	    	<input class="b_text" type="button" name="onReson7" value="¼�����ԭ��" onclick="addReson('opReson7')">
	    	<input type="hidden" name="opReson7" id="opReson7" value="">
	    </td>	    
	    <td align="center" width="20%" class="blue">
	    	<input class="b_text" type="button" name="onAdd7" value="���" onclick="add7()">
	    </td>
	</tr>
	<tr>
	    <td align="center" width="20%" class="blue">
	    	<input class="button" type="text" name="phoneNo8" id="phoneNo8" value="" size="15" maxlength="11" onblur="onChg8()"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
	    </td>
	    <td align="center" width="20%" class="blue">
	    	<select name="opType8" id="opType8" class="button">
	    		<option value="" selected>��ѡ��</option>
	    		<option value="A">���Ϊ�������źͺ������û�</option>
	    		<option value="U">�޸ĸ��û����������źͺ������Ļָ�ʱ��</option>
	    	</select>
	    </td>
	    <td align="center" width="20%" class="blue">
	    	<select name="delayType8" id="delayType8" class="button" onChange="changType('8')">
	    		<option value="" selected>��ѡ��</option>
	    		<option value="Y">����7��</option>
	    		<option value="N">��ͣ7��</option>
	    		<option value="T">���ڹ�ͣ</option>
	    		<option value="F">�����ָ�</option>
	    	</select>
	    </td>
	    	    <TD align="center" width="20%" class="blue">
                 <select id="seled8" class="button">
									</select>

	          </TD>	    
	    <td align="center" width="20%" class="blue"><!--huangrong add ¼��ԭ��ť-->
	    	<input class="b_text" type="button" name="onReson8" value="¼�����ԭ��" onclick="addReson('opReson8')">
	    	<input type="hidden" name="opReson8" id="opReson8" value="">
	    </td>	    
	    <td align="center" width="20%" class="blue">
	    	<input class="b_text" type="button" name="onAdd8" value="���" onclick="add8()">
	    </td>
	</tr>
	<tr>
	    <td align="center" width="20%" class="blue">
	    	<input class="button" type="text" name="phoneNo9" id="phoneNo9" value="" size="15" maxlength="11" onblur="onChg9()" onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
	    </td>
	    <td align="center" width="20%" class="blue">
	    	<select name="opType9" id="opType9" class="button">
	    		<option value="" selected>��ѡ��</option>
	    		<option value="A">���Ϊ�������źͺ������û�</option>
	    		<option value="U">�޸ĸ��û����������źͺ������Ļָ�ʱ��</option>
	    	</select>
	    </td>
	    <td align="center" width="20%" class="blue">
	    	<select name="delayType9" id="delayType9" class="button" onChange="changType('9')">
	    		<option value="" selected>��ѡ��</option>
	    		<option value="Y">����7��</option>
	    		<option value="N">��ͣ7��</option>
	    		<option value="T">���ڹ�ͣ</option>
	    		<option value="F">�����ָ�</option>
	    	</select>
	    </td>
	    	    <TD align="center" width="20%" class="blue">
                 <select id="seled9" class="button">
									</select>

	          </TD>	    
	    <td align="center" width="20%" class="blue"><!--huangrong add ¼��ԭ��ť-->
	    	<input class="b_text" type="button" name="onReson9" value="¼�����ԭ��" onclick="addReson('opReson9')">
	    	<input type="hidden" name="opReson9" id="opReson9" value="">
	    </td>	    
	    <td align="center" width="20%" class="blue">
	    	<input class="b_text" type="button" name="onAdd9" value="���" onclick="add9()">
	    </td>
	</tr>
	<tr>
	    <td align="center" width="20%" class="blue">
	    	<input class="button" type="text" name="phoneNo10" id="phoneNo10" value="" size="15" maxlength="11" onblur="onChg10()" onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) check_HidPwd();">
	    </td>
	    <td align="center" width="20%" class="blue">
	    	<select name="opType10" id="opType10" class="button">
	    		<option value="" selected>��ѡ��</option>
	    		<option value="A">���Ϊ�������źͺ������û�</option>
	    		<option value="U">�޸ĸ��û����������źͺ������Ļָ�ʱ��</option>
	    	</select>
	    </td>
	    <td align="center" width="20%" class="blue">
	    	<select name="delayType10" id="delayType10" class="button" onChange="changType('10')">
	    		<option value="" selected>��ѡ��</option>
	    		<option value="Y">����7��</option>
	    		<option value="N">��ͣ7��</option>
	    		<option value="T">���ڹ�ͣ</option>
	    		<option value="F">�����ָ�</option>
	    	</select>
	    </td>
	    	    <TD align="center" width="20%" class="blue">
                 <select id="seled10" class="button">
									</select>

	          </TD>
	    <td align="center" width="20%" class="blue"><!--huangrong add ¼��ԭ��ť-->
	    	<input class="b_text" type="button" name="onReson10" value="¼�����ԭ��" onclick="addReson('opReson10')">
	    	<input type="hidden" name="opReson10" id="opReson10" value="">
	    </td>	    
	    <td align="center" width="20%" class="blue">
	    	<input class="b_text" type="button" name="onAdd10" value="���" onclick="add10()">
	    </td>
	</tr>
    <tr>
        <td colspan="6" id="footer">
            <input class="b_foot" type="button" name="b_add" value="ȷ��" onClick="confirm();">
            &nbsp;
            <input class="b_foot" type="button" name="b_again" value="����" onClick="again();">
            &nbsp;
            <input class="b_foot" type="button" name="b_back" value="����" onClick="location='s6945Login.jsp'">
            &nbsp;
            <input class="b_foot" type="button" name="b_close" value="�ر�" onClick="removeCurrentTab();">
        </td>
    </tr>
</table>
<input type="hidden" name="opCode1" value="<%=opCode%>">
<input type="hidden" name="opName1" value="<%=opName%>">
<input type="hidden" name="printAccept" value="<%=printAccept%>">
<input type="hidden" name="iCodeStr1" value="">
<input type="hidden" name="iCodeStr2" value="">
<input type="hidden" name="iCodeStr3" value="">
<input type="hidden" name="iCodeStr4" value="">
<input type="hidden" name="iCodeStr5" value="">
<input type="hidden" name="iCodeStr6" value="">
<input type="hidden" name="iCodeStr7" value="">
<input type="hidden" name="iCodeStr8" value="">
<input type="hidden" name="iCodeStr9" value="">
<input type="hidden" name="iCodeStr10" value="">

    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>