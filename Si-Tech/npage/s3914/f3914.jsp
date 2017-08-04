<%
/********************
 * version v2.0
 * 开发商: si-tech
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
    String opName = "集团产品开户冲正";
    //==============================获取营业员信息
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
<title>集团产品开户冲正</title>
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
			//add by rendi 增加对域名注册业务判断开户不可以冲正
			if(srv_card=="域名注册")
			{
				rdShowMessageDialog("域名注册业务不可以做开户冲正！",0);
				return false;
			}
			//wuxy add 20090617 增加对TD商务宝业务不可以开户冲正
			if(srv_card=="TD商务宝")
		  {
		  	rdShowMessageDialog("TD商务宝业务不可以做开户冲正！",0);
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
			document.all.sys_note.value=document.all.grp_product.value+"开户冲正:<%=workno%>对集团产品ID"+user_id;
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
			rdShowMessageDialog("集团产品开户冲正成功！",2);
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
			rdShowMessageDialog("信息查询失败！错误代码:"+errorCode+"；错误信息:"+errorMsg,0);
			return false;
		}
		else if(verifyType=="getSysAccept")
		{
			rdShowMessageDialog("查询流水出错,请重新获取！",0);
			return false;
		}
		else if(verifyType=="submit")
		{
			rdShowMessageDialog("冲正失败！错误代码:"+errorCode+"错误信息:"+errorMsg,0);
			return false;
		}
	}	
}
 
 
function doQuery()
{
	var myPacket = new AJAXPacket("f3914_rpc_query.jsp","正在获得产品信息，请稍候......");	
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
	var myPacket = new AJAXPacket("f3914_rpc_submit.jsp?sys_note="+document.all.sys_note.value+"&to_note="+document.all.to_note.value,"正在获得产品信息，请稍候......");	
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
	var getSysAccept_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s3914/pubSysAccept.jsp","正在生成操作流水，请稍候......");
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
    	retInfo+="集团客户名称:"+document.frm.group_name.value+"|";
    	retInfo+="集团产品ID:"+document.frm.user_id.value+"|";
    	retInfo+="集团客户ID:"+document.frm.group_id.value+"|";
    	retInfo+="服务品牌:"+document.frm.srv_card.value+"|";
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
    	retInfo+="业务类型：集团产品开户冲正"+"|";
    	retInfo+="流水："+document.frm.login_accept.value+"|";
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
	<div id="title_zi">集团产品开户冲正</div>
</div>
<input type="hidden" name="login_accept"  value="0">
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">

<table cellspacing=0>      
    <tr> 
    <td class=blue>服务流水号</td>
        <td colspan="3">
            <input type="text" name="accept_no" maxlength="15" value="">
            <font class="orange"> *</font>
            <input type="button" class="b_text" name="Button1" value="查询" onclick="doQuery()">
            <font class="orange">注：开户之后做了任何业务都不允许办理开户冲正！</font>
        </td>
    </tr>
    
    <tr> 
        <td class=blue>集团产品ID</td>
        <td colspan="3"> 
            <input type="text" name="user_id" value="" class="InputGrey" readOnly>
        </td>
    </tr>
    
    <tr> 
        <td class=blue>集团客户ID</td>
        <td>
            <input type="text" name="group_id" readonly class="InputGrey" value="">
        </td>
        <td class=blue>集团客户名称</td>
        <td>
            <input type="text" name="group_name" readonly class="InputGrey" value="" size="30">
        </td>
    </tr>
    
    <tr> 
        <td class=blue>服务品牌</td>
        <td> 
            <input type="text" name="srv_card" readonly class="InputGrey" value="">
        </td>
        <td class=blue>集团产品</td>
        <td>
            <input type="text" name="grp_product" readonly class="InputGrey" value="">
        </td>
    </tr>
    
    <tr> 
        <td class=blue>营业员</td>
        <td> 
            <input type="text" name="srv_man" readonly class="InputGrey" value="">
        </td>
        <td class=blue>操作时间</td>
        <td>
            <input type="text" name="op_time" readonly class="InputGrey" value="">
        </td>
    </tr>
    
    <tr>
        <td class=blue>备注</td>
        <td colspan="3">
            <input class="InputGrey" name="sys_note" size="70" readonly>
        </td>
    </tr>
    <tr style="display:none">
        <td class=blue>用户备注</td>
        <td colspan="3">
            <input class="button" name="to_note" size="70">
        </td>
    </tr>
    <tr id="footer"> 
        <td colspan="4">
            <input name="confirm" type="button" class="b_foot" value="确认" onClick="doCfm()" disabled>
            <input name="reset" type="reset" class="b_foot" value="清除" >
            <input name="back" onClick="removeCurrentTab()" type="button" class="b_foot" value="关闭">
        </td>
    </tr> 
</table> 

<%@ include file="/npage/include/footer.jsp" %>
</FORM> 
</body>
</html>
