<%
/********************
 version v2.0
 开发商: si-tech
 update wangjya at 2009.6.23
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
	    response.setHeader("Pragma","No-cache");
	    response.setHeader("Cache-Control","no-cache");
	    response.setDateHeader("Expires", 0);
%>
<%

		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
		String phoneNo = request.getParameter("phone_no");
		String orgCode =(String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
		/* liujian 安全加固修改 2012-4-6 16:18:13 begin */
		String op_strong_pwd = (String) session.getAttribute("password");
	   /* liujian 安全加固修改 2012-4-6 16:18:13 end */
		String workNo = (String)session.getAttribute("workNo");

		String  inputParsm [] = new String[3];
		inputParsm[0] = phoneNo;
		inputParsm[1] = opCode;
		inputParsm[2] = workNo;
		
%>	
    <wtc:service name="s1141Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg" outnum="12">			
		<wtc:param value=""/>	
		<wtc:param value=""/>	
		<wtc:param value="<%=inputParsm[1]%>"/>
		<wtc:param value="<%=inputParsm[2]%>"/>	
		<wtc:param value="<%=op_strong_pwd%>"/>	
		<wtc:param value="<%=inputParsm[0]%>"/>
		<wtc:param value=""/>
	</wtc:service>	
	<wtc:array id="tempArr" start="0" length="12"  scope="end"/>
<% 		
	if(!(errCode.equals("000000")))
	{
%>
		<script language="javascript">
	 	rdShowMessageDialog("查询失败！" + "<%=errMsg%>",0);	
	 	window.location="f9982_login.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		</script>
<%		
		return;				 			
	}

%>
<HEAD>

<script language="JavaScript">
<!--
	
  onload=function()
 {
  	
 }
function getBytesLength(str) 
{ 
	return str.replace(/[^\x00-\xff]/gi, "--").length; 
}
function commitjsp()
{
	getAfterPrompt();
	if(getBytesLength(document.all.opNote.value.trim()) > 60)
	{
		rdShowMessageDialog("备注必须少于60个英文字符或32个中文字符!",1);
		return;
	}
	if(document.frm.op_code.value == 9982)
	{
		document.frm.action="f9982_2.jsp";
	}
	if(document.frm.op_code.value == 9983)
	{
		document.frm.action="f9983_1.jsp";
	}
	document.frm.submit();
}

-->
 </script>

<title>黑龙江BOSS-sim卡校园营销案</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
</head>
<BODY>
<form action="f9982_2.jsp" method="post" name="frm">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
	<input type="hidden" name="op_code" id="op_code" value="<%=opCode%>">
	<input type="hidden" name="op_name" id="op_name" value="<%=opName%>">
	<table cellspacing="0" >
    <tr> 
        <td class=blue>操作类型</td>
        <td colspan=3><%=opName%></td>
    </tr>
    <tr> 
        <td class=blue>手机号码</td>
        <td>
        	<input name="phone_no" value="<%=phoneNo%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" size="40"> 
   		</td>
        <td class=blue>客户姓名</td>
        <td>
            <input name="cust_name" value="<%=tempArr[0][2]%>" type="text" class="InputGrey" v_must=1 readonly id="cust_name" maxlength="20" size="40"> 
        </td>
  	<tr>
  		<td class=blue>业务品牌</td>
        <td>
            <input name="sm_code" value="<%=tempArr[0][6]%>" type="text" class="InputGrey" v_must=1 readonly id="sm_code" maxlength="20" > 
        </td>
    	<td class=blue>运行状态</td>
        <td>
            <input name="run_type" value="<%=tempArr[0][8]%>" type="text" class="InputGrey" v_must=1 readonly id="run_type" maxlength="20" > 
        </td>
    </tr>
    <tr>         
        <td class=blue>VIP级别</td>
        <td>
            <input name="vip" value="<%=tempArr[0][9]%>" type="text" class="InputGrey" v_must=1 readonly id="vip" maxlength="20" > 
        </td>
        <td class=blue>可用预存</td>
        <td>
            <input name="prepay_fee" value="<%=tempArr[0][11]%>" type="text" class="InputGrey" v_must=1 readonly id="prepay_fee" maxlength="20" > 
        </td>
    </tr>
    <tr>  
    	<td class=blue>当前积分</td>
        <td>
            <input name="user_type" value="<%=tempArr[0][10]%>" type="text" class="InputGrey" v_must=1 readonly id="user_type" maxlength="20" > 	
        </td>
        <td class=blue>归属地</td>
        <td>
            <input name="belong_area" value="<%=tempArr[0][7]%>" type="text" class="InputGrey" v_must=1 readonly id="user_type" maxlength="20" > 	
        </td>
    </tr>
    <tr>
    	<td class=blue>备注</td>
        <td colspan="3" >
            <input name="opNote" type="text"  id="opNote" size="60" maxlength="60" value="<%=workNo%>对手机号<%=phoneNo%>进行sim卡营销案<%=opCode.equals("9982") ? "申请" : "冲正"%>" > 
        </td>
    </tr>
    <tr id="footer"> 
        <td colspan="4">
            <input name="confirm" type="button" class="b_foot" index="2" value="确认" onClick="commitjsp()"  >
            <input name="back" onClick="history.go(-1)" type="button" class="b_foot" value="返回">
        </td>
    </tr>
</table>
       <%@ include file="/npage/include/footer.jsp" %>   
</form>
 </BODY>
</HTML>
