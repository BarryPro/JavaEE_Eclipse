<%
/********************
 * version v2.0
 * ������: si-tech
 * wangzn
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
    String opCode = "g222";
    String opName = "���ų�Ա������ǩ����";
    //==============================��ȡӪҵԱ��Ϣ
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
	  String org_code = (String)session.getAttribute("orgCode");
	  String regionCode = org_code.substring(0,2);
	  String nopass = (String)session.getAttribute("password");

%>

<HTML>
<HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<title>���Ų�Ʒ������ǩ����</title>
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
	if (errorCode=="000000")
	{
		if(verifyType=="query")
		{

    	

			var user_id=packet.data.findValueByName("jtuserid");
			var group_id=packet.data.findValueByName("jtprodid");
			var group_name=packet.data.findValueByName("jtprodname");
			var srv_card=packet.data.findValueByName("jtkehuid");
			var grp_product=packet.data.findValueByName("jtkehuname");
			var srv_card_end=packet.data.findValueByName("caozuotime");
			var grp_product_end=packet.data.findValueByName("yingyeyuan");
			var srv_man=packet.data.findValueByName("liushui");
			var op_time=packet.data.findValueByName("bgqproductid");
			var op_time1=packet.data.findValueByName("bgqproductname");
			var op_time2=packet.data.findValueByName("bghproductid");
			var op_time3=packet.data.findValueByName("bghproductname");
			

			document.all.jtuserid.value=user_id;
			document.all.jtprodid.value=group_id;
			document.all.jtprodname.value=group_name;
			document.all.jtkehuid.value=srv_card;
			document.all.jtkehuname.value=grp_product;
			document.all.caozuotime.value=srv_card_end;
			document.all.yingyeyuan.value=grp_product_end;
			//document.all.liushui.value=srv_man;
			document.all.bgqproductid.value=op_time; 
			document.all.bgqproductname.value=op_time1;
			document.all.bghproductid.value=op_time2;
			document.all.bghproductname.value=op_time3;
			
			document.all.yonghunote.value=document.all.jtprodid.value+"���ų�Ա������ǩ����:<%=workno%>�Լ��Ų�ƷID"+user_id;
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
			rdShowMessageDialog("���Ų�Ʒ������ǩ�����ɹ���");
			document.all.accept_no.value="";
			document.all.user_id.value="";
			document.all.group_id.value="";
			document.all.group_name.value="";
			document.all.srv_card.value="";
			document.all.grp_product.value="";
			document.all.srv_man.value="";
			document.all.op_time.value=""; 
			document.all.yonghunote.value="";
			document.all.to_note.value=""; 
			document.all.login_accept.value="0";
		}
	}
	else
	{
		if(verifyType=="query")
		{
			rdShowMessageDialog("��Ϣ��ѯʧ�ܣ��������:"+errorCode+"��������Ϣ:"+errorMsg);
			return false;
		}
		else if(verifyType=="getSysAccept")
		{
			rdShowMessageDialog("��ѯ��ˮ����,�����»�ȡ��");
			return false;
		}
		else if(verifyType=="submit")
		{
			rdShowMessageDialog("����ʧ�ܣ��������:"+errorCode+"������Ϣ:"+errorMsg);
			return false;
		}
	}	
}
 
 
function doQuery()
{
	var myPacket = new AJAXPacket("fg222_qry.jsp","���ڻ�ò�ѯ��Ϣ�����Ժ�......");	
	myPacket.data.add("verifyType","query");		
	myPacket.data.add("accept_no",document.all.accept_no.value);
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}

function doCfm()
{
    getAfterPrompt();

			showPrtDlg("Detail","ȷʵҪ��ӡ���������","Yes");
			if (rdShowConfirmDialog("�Ƿ��ύȷ�ϲ�����")==1)
			{
				frm.action="fg222Cfm.jsp";
				frm.submit();
			}
}

function doSubmit()
{
	var myPacket = new AJAXPacket("f1037_rpc_submit.jsp?sys_note="+document.all.yonghunote.value+"&to_note="+document.all.to_note.value,"���ڽ��г��������Ժ�......");	
	myPacket.data.add("verifyType","submit");		
	myPacket.data.add("login_accept",document.all.login_accept.value);
	myPacket.data.add("accept_no",document.all.accept_no.value);
	myPacket.data.add("group_id",document.all.group_id.value);
	myPacket.data.add("opCode","<%=opCode%>");
	myPacket.data.add("opName","<%=opName%>");	
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}

function getSysAccept()
{
	var getSysAccept_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s3521/pubSysAccept.jsp","�������ɲ�����ˮ�����Ժ�......");
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
    	retInfo+="���ſͻ�����:"+document.frm.jtkehuname.value+"|";
    	retInfo+="���Ų�ƷID:"+document.frm.jtprodid.value+"|";
    	retInfo+="���ſͻ�ID:"+document.frm.jtkehuid.value+"|";
    	retInfo+="���ǰ�Ĳ�ƷID:"+document.frm.bgqproductid.value+"|";
    	retInfo+="���ǰ�Ĳ�Ʒ����:"+document.frm.bgqproductname.value+"|";
			retInfo+="�����Ĳ�ƷID:"+document.frm.bghproductid.value+"|";
    	retInfo+="�����Ĳ�Ʒ����:"+document.frm.bghproductname.value+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+="ҵ�����ͣ����ų�Ա������ǩ����"+"|";
    	retInfo+="��ˮ��"+document.frm.login_accept.value+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=document.all.yonghunote.value+"|";
		 return retInfo;
}

</SCRIPT>
</head>
<BODY>
<FORM method="post" name="frm" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">���Ų�Ʒ������ǩ����</div>
</div>
<input type="hidden" name="login_accept"  value="0">
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">

<table cellspacing=0>      
    <tr> 
        <td class=blue>������ˮ��</td>
        <td colspan="3">
            <input type="text" id="accept_no" name="accept_no" maxlength="14" value="">
            <font class="orange"> *</font>
            <input type="button" class="b_text" name="Button1" value="��ѯ" onclick="doQuery()">
        </td>
    </tr>
    
    <tr> 
        <td class=blue>���ų�ԱID</td>
        <td colspan="3"> 
            <input class="InputGrey" type="text" id="jtuserid" name="jtuserid" value="">
        </td>
    </tr>
        <tr> 
        <td class=blue>���Ų�ƷID</td>
        <td > 
            <input class="InputGrey" type="text" name="jtprodid" id="jtprodid" value="">
        </td>
                <td class=blue>���Ų�Ʒ����</td>
        <td>
            <input type="text" name="jtprodname" id="jtprodname" readonly class="InputGrey" value="" size="30">
        </td>
    </tr>
    <tr> 
        <td class=blue>���ſͻ�ID</td>
        <td>
            <input type="text" name="jtkehuid" id="jtkehuid" readonly class="InputGrey" value="">
        </td>
        <td class=blue>���ſͻ�����</td>
        <td>
            <input type="text" name="jtkehuname" id="jtkehuname" readonly class="InputGrey" value="" size="30">
        </td>
    </tr>
    
    <tr> 
        <td class=blue>���ǰ�Ĳ�ƷID</td>
        <td> 
            <input type="text" name="bgqproductid" id="bgqproductid" readonly class="InputGrey" value="">
        </td>
        <td class=blue>���ǰ�Ĳ�Ʒ����</td>
        <td>
            <input type="text" name="bgqproductname" id="bgqproductname" readonly class="InputGrey" value="">
        </td>
    </tr>
    <tr> 
        <td class=blue>�����Ĳ�ƷID</td>
        <td> 
            <input type="text" name="bghproductid" id="bghproductid" readonly class="InputGrey" value="">
        </td>
        <td class=blue>�����Ĳ�Ʒ����</td>
        <td>
            <input type="text" name="bghproductname" id="bghproductname" readonly class="InputGrey" value="">
        </td>
    </tr>
    
    <tr> 
        <td class=blue>ӪҵԱ</td>
        <td> 
            <input type="text" name="yingyeyuan" id="yingyeyuan" readonly class="InputGrey" value="">
        </td>
        <td class=blue>����ʱ��</td>
        <td>
            <input type="text" name="caozuotime" id="caozuotime" readonly class="InputGrey" value="">
        </td>
    </tr>
    
    <tr>
        <td class=blue>��ע</td>
        <td colspan="3">
            <input class="InputGrey" name="beizhunote" id="beizhunote" size="70" readonly>
        </td>
    </tr>
    <tr style="display:none">
        <td class=blue>�û���ע</td>
        <td colspan="3">
            <input name="yonghunote" id="yonghunote" size="70">
        </td>
    </tr>
    <tr id="footer"> 
        <td colspan="4">
            <input name="confirm" type="button" class="b_foot" value="ȷ��" onClick="doCfm()" disabled>
            <input name="reset" type="reset" class="b_foot" value="���" >
            <input name="back" onClick="removeCurrentTab()" type="button" class="b_foot" value="����">
        </td>
    </tr> 
</table> 

<%@ include file="/npage/include/footer.jsp" %>
</FORM> 
</body>
</html>
