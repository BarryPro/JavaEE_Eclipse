<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-15
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>

<%
    String opCode = "3914";
    String opName = "���Ų�Ʒ��������";
    //==============================��ȡӪҵԱ��Ϣ
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String nopass = (String)session.getAttribute("password");

%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<title>���Ų�Ʒ��������</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<SCRIPT LANGUAGE="JavaScript">
<!--
//core.loadUnit("debug");
//core.loadUnit("rpccore"); 
onload=function(){
	//core.rpc.onreceive = doProcess;
}

//���յ�RPC���صĲ�ѯֵ
function doProcess(packet){
    var errorCode=packet.data.findValueByName("errorCode");
    var errorMsg=packet.data.findValueByName("errorMsg");
    var verifyType=packet.data.findValueByName("verifyType");
	self.status="";
	
	if (errorCode=="0")
	{
		if(verifyType=="query")
		{
			var accept_no=packet.data.findValueByName("accept_no");
			var user_id=packet.data.findValueByName("user_id");
			var group_id=packet.data.findValueByName("group_id");
			var group_name=packet.data.findValueByName("group_name");
			var srv_card=packet.data.findValueByName("srv_card");
			var grp_product=packet.data.findValueByName("grp_product");
			var srv_man=packet.data.findValueByName("srv_man");
			var op_time=packet.data.findValueByName("op_time");
			//add by rendi ���Ӷ�����ע��ҵ���жϿ��������Գ���
			if(srv_card=="����ע��")
			{
				rdShowMessageDialog("����ע��ҵ�񲻿���������������",0);
				return false;
			}
			//wuxy add 20090617 ���Ӷ�TD����ҵ�񲻿��Կ�������
			if(srv_card=="TD����")
		  {
		  	rdShowMessageDialog("TD����ҵ�񲻿���������������",0);
				return false;
		  }
			
			document.all.accept_no.value=accept_no;
			document.all.user_id.value=user_id;
			document.all.group_id.value=group_id;
			document.all.group_name.value=group_name;
			document.all.srv_card.value=srv_card;
			document.all.grp_product.value=grp_product;
			document.all.srv_man.value=srv_man;
			document.all.op_time.value=op_time; 
			document.all.sys_note.value=document.all.grp_product.value+"��������:<%=workno%>�Լ��Ų�ƷID"+user_id;
			document.all.confirm.disabled=false;
			
		}
		else if(verifyType=="getSysAccept")
		{
			var sysAccept = packet.data.findValueByName("sysAccept");
			document.frm.login_accept.value=sysAccept;
			showPrtDlg("Detail","ȷʵҪ��ӡ���������","Yes");
			if (rdShowConfirmDialog("�Ƿ��ύȷ�ϲ�����")==1)
			{
				doSubmit();
			}
			else return false;	
		}
		else if(verifyType=="submit")
		{
			rdShowMessageDialog("���Ų�Ʒ���������ɹ���",2);
			document.all.accept_no.value="";
			document.all.user_id.value="";
			document.all.group_id.value="";
			document.all.group_name.value="";
			document.all.srv_card.value="";
			document.all.grp_product.value="";
			document.all.srv_man.value="";
			document.all.op_time.value=""; 
			document.all.sys_note.value="";
			document.all.to_note.value=""; 
			document.all.login_accept.value="0";
		}
	}
	else
	{
		if(verifyType=="query")
		{
			rdShowMessageDialog("��Ϣ��ѯʧ�ܣ��������:"+errorCode+"��������Ϣ:"+errorMsg,0);
			return false;
		}
		else if(verifyType=="getSysAccept")
		{
			rdShowMessageDialog("��ѯ��ˮ����,�����»�ȡ��",0);
			return false;
		}
		else if(verifyType=="submit")
		{
			rdShowMessageDialog("����ʧ�ܣ��������:"+errorCode+"������Ϣ:"+errorMsg,0);
			return false;
		}
	}	
}
 
 
function doQuery()
{
	var myPacket = new AJAXPacket("f3914_rpc_query.jsp","���ڻ�ò�Ʒ��Ϣ�����Ժ�......");	
	myPacket.data.add("verifyType","query");		
	myPacket.data.add("accept_no",document.all.accept_no.value);
	myPacket.data.add("user_id",document.all.user_id.value);
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}

function doCfm()
{
    getAfterPrompt();
	if(document.all.to_note.value=="")
	{
		document.all.to_note.value=document.all.sys_note.value;
	}
	getSysAccept();
}

function doSubmit()
{
	var myPacket = new AJAXPacket("f3914_rpc_submit.jsp?sys_note="+document.all.sys_note.value+"&to_note="+document.all.to_note.value,"���ڻ�ò�Ʒ��Ϣ�����Ժ�......");	
	myPacket.data.add("verifyType","submit");		
	myPacket.data.add("login_accept",document.all.login_accept.value);
	myPacket.data.add("user_id",document.all.user_id.value);
	myPacket.data.add("group_id",document.all.group_id.value);
	myPacket.data.add("opCode","<%=opCode%>");
	myPacket.data.add("opName","<%=opName%>");
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}

function getSysAccept()
{
	var getSysAccept_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s3914/pubSysAccept.jsp","�������ɲ�����ˮ�����Ժ�......");
	getSysAccept_Packet.data.add("verifyType","getSysAccept");
	core.ajax.sendPacket(getSysAccept_Packet);
	getSysAccept_Packet = null;
}


function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի���
   var h=190;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var printStr = printInfo(printType);
   if(printStr == "failed")
   {    return false;   }

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
   var path = "<%=request.getContextPath()%>/npage/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
   var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
   var ret=window.showModalDialog(path,"",prop);
}

function printInfo(printType)
{
		var retInfo = "";
 		retInfo+='<%=workname%>'+"|";
    	retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    	retInfo+="������ˮ��:"+document.frm.accept_no.value+"|";
    	retInfo+="���ſͻ�����:"+document.frm.group_name.value+"|";
    	retInfo+="���Ų�ƷID:"+document.frm.user_id.value+"|";
    	retInfo+="���ſͻ�ID:"+document.frm.group_id.value+"|";
    	retInfo+="����Ʒ��:"+document.frm.srv_card.value+"|";
    	retInfo+=""+"|";
		retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+="ҵ�����ͣ����Ų�Ʒ��������"+"|";
    	retInfo+="��ˮ��"+document.frm.login_accept.value+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=document.all.to_note.value+"|";
		 return retInfo;
}

</SCRIPT>
</head>
<BODY>
<FORM method="post" name="frm" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">���Ų�Ʒ��������</div>
</div>
<input type="hidden" name="login_accept"  value="0">
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">

<table cellspacing=0>      
    <tr> 
    <td class=blue>������ˮ��</td>
        <td colspan="3">
            <input type="text" name="accept_no" maxlength="15" value="">
            <font class="orange"> *</font>
            <input type="button" class="b_text" name="Button1" value="��ѯ" onclick="doQuery()">
            <font class="orange">ע������֮�������κ�ҵ�񶼲����������������</font>
        </td>
    </tr>
    
    <tr> 
        <td class=blue>���Ų�ƷID</td>
        <td colspan="3"> 
            <input type="text" name="user_id" value="" class="InputGrey" readOnly>
        </td>
    </tr>
    
    <tr> 
        <td class=blue>���ſͻ�ID</td>
        <td>
            <input type="text" name="group_id" readonly class="InputGrey" value="">
        </td>
        <td class=blue>���ſͻ�����</td>
        <td>
            <input type="text" name="group_name" readonly class="InputGrey" value="" size="30">
        </td>
    </tr>
    
    <tr> 
        <td class=blue>����Ʒ��</td>
        <td> 
            <input type="text" name="srv_card" readonly class="InputGrey" value="">
        </td>
        <td class=blue>���Ų�Ʒ</td>
        <td>
            <input type="text" name="grp_product" readonly class="InputGrey" value="">
        </td>
    </tr>
    
    <tr> 
        <td class=blue>ӪҵԱ</td>
        <td> 
            <input type="text" name="srv_man" readonly class="InputGrey" value="">
        </td>
        <td class=blue>����ʱ��</td>
        <td>
            <input type="text" name="op_time" readonly class="InputGrey" value="">
        </td>
    </tr>
    
    <tr>
        <td class=blue>��ע</td>
        <td colspan="3">
            <input class="InputGrey" name="sys_note" size="70" readonly>
        </td>
    </tr>
    <tr style="display:none">
        <td class=blue>�û���ע</td>
        <td colspan="3">
            <input class="button" name="to_note" size="70">
        </td>
    </tr>
    <tr id="footer"> 
        <td colspan="4">
            <input name="confirm" type="button" class="b_foot" value="ȷ��" onClick="doCfm()" disabled>
            <input name="reset" type="reset" class="b_foot" value="���" >
            <input name="back" onClick="removeCurrentTab()" type="button" class="b_foot" value="�ر�">
        </td>
    </tr> 
</table> 

<%@ include file="/npage/include/footer.jsp" %>
</FORM> 
</body>
</html>
