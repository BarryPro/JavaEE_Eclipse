<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
    /*
   * 功能: WLAN预付费套餐申请
   * 版本: 1.0
   * 日期: 2010/6/28
   * 作者: jianglei
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>
<%
	String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");

	String loginNo = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String groupId = (String)session.getAttribute("groupId");
	
	String printAccept="";
	printAccept = getMaxAccept();
%>
<%
	String Tempsql = " SELECT pack_type,type_name FROM swlanmode where pack_type in ('03','04')  GROUP BY pack_type,type_name";
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="TempRetCode" retmsg="TempRetMsg" outnum="2">
	<wtc:sql><%=Tempsql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end" />
	
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>WLAN预付费套餐申请</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">

function frmCfm()
{
	frm.submit();
}

function printCommit()
{
	
	if(document.all.packCode.value == "")
	{
		rdShowMessageDialog("请选择资费类型！");
		return false;
	}
	
	document.all.commit.disabled = true;//为防止二次确认

	//提交表单

	if(rdShowConfirmDialog('确认要提交信息吗？')==1)
	{
		frmCfm();
	}
	
	return true;
}

function getCardPwd()
{
 	var getAccountId_Packet = new AJAXPacket("getCardPwd.jsp","正在获得卡密码，请稍候......");
	core.ajax.sendPacket(getAccountId_Packet,dogetCardPwd,true);
	getAccountId_Packet=null;
}

function dogetCardPwd(packet){
	var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage");	
    var CardPwd = packet.data.findValueByName("CardPwd");    	    
	if(retCode=="000000")
	{  
		document.all.card_pwd.value = CardPwd;		
	}
	else
	{
		retMessage = retMessage + "[errorCode:" + retCode + "]";
		rdShowMessageDialog(retMessage,0);
		return false;
    }
}

function type_chg()
{
	if(document.all.packType.value == "")
	{
		rdShowMessageDialog("请选择套餐类型！");
		return false;
	}
	
	var sql = "SELECT pack_code,pack_name FROM swlanmode  "+
			  "where pack_type = :packType "+
			  " GROUP BY pack_code,pack_name ";
	var sqlParam = "packType="+document.all.packType.value;
	
	var rpc_flag = "typeChg";
	
	var myPacket = new AJAXPacket("rpc_select1.jsp","正在获取信息，请稍候......");
	myPacket.data.add("sql",sql);
	myPacket.data.add("sqlParam",sqlParam);
	myPacket.data.add("rpc_flag",rpc_flag);
	core.ajax.sendPacket(myPacket);
	myPacket=null;
}

function doProcess(packet)
{
	var retCode = packet.data.findValueByName("retCode");
	var retMsg =  packet.data.findValueByName("retMsg");
	var rpc_flag = packet.data.findValueByName("rpc_flag");
	self.status="";
	
	if(retCode != "000000")
	{
		rdShowMessageDialog(retMsg);
		return;
	}
	if(rpc_flag == "typeChg")
	{
		var code = packet.data.findValueByName("code");
		var text =  packet.data.findValueByName("text");
		fillSelect(document.all.packCode,code,text);
	}
}

function fillSelect(obj,code,text)
{
	obj.length=0;
	var option0 = new Option("--请选择--","");
	obj.add(option0);
	for(var i=0; i<code.length; i++)
	{
		var option1 = new Option(code[i]+"->"+text[i],code[i]);
        obj.add(option1);
	}
}

</script>

</head>
<body>
<form name="frm" method="post" action="f9390Cfm.jsp" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="printAccept" value="<%=printAccept%>">
	<div class="title">
		<div id="title_zi">套餐信息</div>
	</div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="15%" nowrap>卡号</td>
	    <td width="35%">
	    	<input  type="text" name="card_no" id="card_no" value="" size="20" >
	    </td>
	    <td class="blue" width="15%" nowrap>卡密码</td>
	    <td width="35%">
	    	<input  type="text" name="card_pwd" id="card_pwd" value="" size="20" >
	    	<input type="button" class="b_text" value="获得" id="btn_getCardPwd" onClick="getCardPwd()">  
	    </td>
	</tr>
	<tr>
		<td class="blue" width="15%" nowrap>套餐类型</td>
	    <td width="35%">
	    	<select name="packType" class="button" id="packType" onChange="type_chg()">
    			<option value="">--请选择--</option>
				<%for (int j = 0; j < result.length; j++) {%>
	      		<option value="<%=result[j][0]%>"><%=result[j][0]%>-><%=result[j][1]%>
	      		</option>
	    	<%}%>
    		</select>
	    </td>
	    <td class="blue" width="15%" nowrap>资费类型</td>
	    <td width="35%">
	    	<select name="packCode" id="packCode" >
			    <option value="">--请选择--</option>
      		</select>
	    </td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="foot">
			&nbsp;
			<input name="commit" id="commit" type="button" class="b_foot"   value="确认" onClick="printCommit();">
			&nbsp;
			<input name="reset" type="reset" class="b_foot" value="清除" >
			&nbsp;
			<input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="返回">
			&nbsp;
		</td>
	</tr>
</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
