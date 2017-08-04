<%
/********************
 * version v2.0
 * 开发商: si-tech
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
    String opName = "集团成员包年续签冲正";
    //==============================获取营业员信息
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
<title>集团产品包年续签冲正</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<SCRIPT LANGUAGE="JavaScript">
<!--
//core.loadUnit("debug");
//core.loadUnit("rpccore"); 
onload=function(){
	//core.rpc.onreceive = doProcess;
}

//接收到RPC返回的查询值
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
			
			document.all.yonghunote.value=document.all.jtprodid.value+"集团成员包年续签冲正:<%=workno%>对集团产品ID"+user_id;
			document.all.confirm.disabled=false;
			
		}
		else if(verifyType=="getSysAccept")
		{
			var sysAccept = packet.data.findValueByName("sysAccept");
			document.frm.login_accept.value=sysAccept;
			showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
			if (rdShowConfirmDialog("是否提交确认操作？")==1)
			{
				doSubmit();
			}
			else return false;	
		}
		else if(verifyType=="submit")
		{
			rdShowMessageDialog("集团产品包年续签冲正成功！");
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
			rdShowMessageDialog("信息查询失败！错误代码:"+errorCode+"；错误信息:"+errorMsg);
			return false;
		}
		else if(verifyType=="getSysAccept")
		{
			rdShowMessageDialog("查询流水出错,请重新获取！");
			return false;
		}
		else if(verifyType=="submit")
		{
			rdShowMessageDialog("冲正失败！错误代码:"+errorCode+"错误信息:"+errorMsg);
			return false;
		}
	}	
}
 
 
function doQuery()
{
	var myPacket = new AJAXPacket("fg222_qry.jsp","正在获得查询信息，请稍候......");	
	myPacket.data.add("verifyType","query");		
	myPacket.data.add("accept_no",document.all.accept_no.value);
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}

function doCfm()
{
    getAfterPrompt();

			showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
			if (rdShowConfirmDialog("是否提交确认操作？")==1)
			{
				frm.action="fg222Cfm.jsp";
				frm.submit();
			}
}

function doSubmit()
{
	var myPacket = new AJAXPacket("f1037_rpc_submit.jsp?sys_note="+document.all.yonghunote.value+"&to_note="+document.all.to_note.value,"正在进行冲正，请稍候......");	
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
	var getSysAccept_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s3521/pubSysAccept.jsp","正在生成操作流水，请稍候......");
	getSysAccept_Packet.data.add("verifyType","getSysAccept");
	core.ajax.sendPacket(getSysAccept_Packet);
	getSysAccept_Packet = null;
}


function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框
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
    	retInfo+="服务流水号:"+document.frm.accept_no.value+"|";
    	retInfo+="集团客户名称:"+document.frm.jtkehuname.value+"|";
    	retInfo+="集团产品ID:"+document.frm.jtprodid.value+"|";
    	retInfo+="集团客户ID:"+document.frm.jtkehuid.value+"|";
    	retInfo+="变更前的产品ID:"+document.frm.bgqproductid.value+"|";
    	retInfo+="变更前的产品名称:"+document.frm.bgqproductname.value+"|";
			retInfo+="变更后的产品ID:"+document.frm.bghproductid.value+"|";
    	retInfo+="变更后的产品名称:"+document.frm.bghproductname.value+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+=""+"|";
    	retInfo+="业务类型：集团成员包年续签冲正"+"|";
    	retInfo+="流水："+document.frm.login_accept.value+"|";
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
	<div id="title_zi">集团产品包年续签冲正</div>
</div>
<input type="hidden" name="login_accept"  value="0">
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">

<table cellspacing=0>      
    <tr> 
        <td class=blue>服务流水号</td>
        <td colspan="3">
            <input type="text" id="accept_no" name="accept_no" maxlength="14" value="">
            <font class="orange"> *</font>
            <input type="button" class="b_text" name="Button1" value="查询" onclick="doQuery()">
        </td>
    </tr>
    
    <tr> 
        <td class=blue>集团成员ID</td>
        <td colspan="3"> 
            <input class="InputGrey" type="text" id="jtuserid" name="jtuserid" value="">
        </td>
    </tr>
        <tr> 
        <td class=blue>集团产品ID</td>
        <td > 
            <input class="InputGrey" type="text" name="jtprodid" id="jtprodid" value="">
        </td>
                <td class=blue>集团产品名称</td>
        <td>
            <input type="text" name="jtprodname" id="jtprodname" readonly class="InputGrey" value="" size="30">
        </td>
    </tr>
    <tr> 
        <td class=blue>集团客户ID</td>
        <td>
            <input type="text" name="jtkehuid" id="jtkehuid" readonly class="InputGrey" value="">
        </td>
        <td class=blue>集团客户名称</td>
        <td>
            <input type="text" name="jtkehuname" id="jtkehuname" readonly class="InputGrey" value="" size="30">
        </td>
    </tr>
    
    <tr> 
        <td class=blue>变更前的产品ID</td>
        <td> 
            <input type="text" name="bgqproductid" id="bgqproductid" readonly class="InputGrey" value="">
        </td>
        <td class=blue>变更前的产品名称</td>
        <td>
            <input type="text" name="bgqproductname" id="bgqproductname" readonly class="InputGrey" value="">
        </td>
    </tr>
    <tr> 
        <td class=blue>变更后的产品ID</td>
        <td> 
            <input type="text" name="bghproductid" id="bghproductid" readonly class="InputGrey" value="">
        </td>
        <td class=blue>变更后的产品名称</td>
        <td>
            <input type="text" name="bghproductname" id="bghproductname" readonly class="InputGrey" value="">
        </td>
    </tr>
    
    <tr> 
        <td class=blue>营业员</td>
        <td> 
            <input type="text" name="yingyeyuan" id="yingyeyuan" readonly class="InputGrey" value="">
        </td>
        <td class=blue>操作时间</td>
        <td>
            <input type="text" name="caozuotime" id="caozuotime" readonly class="InputGrey" value="">
        </td>
    </tr>
    
    <tr>
        <td class=blue>备注</td>
        <td colspan="3">
            <input class="InputGrey" name="beizhunote" id="beizhunote" size="70" readonly>
        </td>
    </tr>
    <tr style="display:none">
        <td class=blue>用户备注</td>
        <td colspan="3">
            <input name="yonghunote" id="yonghunote" size="70">
        </td>
    </tr>
    <tr id="footer"> 
        <td colspan="4">
            <input name="confirm" type="button" class="b_foot" value="确认" onClick="doCfm()" disabled>
            <input name="reset" type="reset" class="b_foot" value="清除" >
            <input name="back" onClick="removeCurrentTab()" type="button" class="b_foot" value="返回">
        </td>
    </tr> 
</table> 

<%@ include file="/npage/include/footer.jsp" %>
</FORM> 
</body>
</html>
