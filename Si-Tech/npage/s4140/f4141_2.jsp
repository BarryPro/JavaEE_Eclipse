<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ include file="../../npage/bill/getMaxAccept_boss.jsp" %>

<%
    String opCode = "4141";
    String opName = "投诉退费管理--冲正";
    
    String chAcceptNo="",chUnPayLevel="",chUnPayKind="",chUnPayKindcode="",chFirstClass="",chSecondClass="",chThirdClass="";
    String chSpEnterCode="",chSpTranCode="",chBackMoney="",chCompMoney="",chOpNote="";
    
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);
    String phoneNo = (String)request.getParameter("phoneno");
    String backaccept = (String)request.getParameter("backaccept");
	String pass = (String)session.getAttribute("password");

	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
	
	String paraAray[] = new String[8]; 
	paraAray[0] = backaccept; 	        //操作流水
	paraAray[1] = "01";  				//渠道标识
	paraAray[2] = opCode; 			    //操作代码
	paraAray[3] = work_no;  		    //操作工号
	paraAray[4] = pass;			    //工号密码
	paraAray[5] = phoneNo;  		    //投诉电话号码
	paraAray[6] = "";			    //号码密码	
	paraAray[7] = regionCode;             //地市代码
%>	

	<wtc:service name="s4141_2Init" routerKey="phone" routerValue="<%=phoneNo%>" outnum="31" retcode="retCode" retmsg="retMsg">
    <wtc:param value="<%=paraAray[0]%>"/>
    <wtc:param value="<%=paraAray[1]%>"/> 
    <wtc:param value="<%=paraAray[2]%>"/>
    <wtc:param value="<%=paraAray[3]%>"/>
    <wtc:param value="<%=paraAray[4]%>"/>
    <wtc:param value="<%=paraAray[5]%>"/>
    <wtc:param value="<%=paraAray[6]%>"/>
    <wtc:param value="<%=paraAray[7]%>"/>
	</wtc:service>
	<wtc:array id="userInfo" scope="end"/>	
<%	
	if(retMsg.equals("")){
		retMsg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(retCode));
		if( retMsg.equals("null")){
			retMsg ="未知错误信息";
		}
	}
	 
	if(!retCode.equals("000000")){
%>
		<script language="JavaScript">
			rdShowMessageDialog("投诉退费冲正初始化处理失败: <%=retMsg%>",0);
			window.location="f4141.jsp?opCode=4141&opName=投诉退费";
		</script>
<%
	}
	
	
	System.out.println("userInfo.length="+userInfo.length);
    if(userInfo.length==0)
    {
    	retMsg = "初始化信息错误";
    }
	else
	{
		chAcceptNo = userInfo[0][2];
		chUnPayLevel = userInfo[0][3];
		chFirstClass = userInfo[0][4];
		chSecondClass = userInfo[0][5];
		chThirdClass = userInfo[0][6];
		chBackMoney = userInfo[0][7];
		chCompMoney = userInfo[0][8];
		chOpNote = userInfo[0][9];
		chUnPayKind = userInfo[0][10];
		chUnPayKindcode = userInfo[0][11];
		System.out.println("chFirstClass="+chFirstClass);
		System.out.println("chSecondClass="+chSecondClass);
		System.out.println("chThirdClass="+chThirdClass);
	}
%>
	<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
    String sysAccept = seq;
    System.out.println("sysAccept="+sysAccept);
    
    /*request.setCharacterEncoding("GBK");
    
    HashMap hm=new HashMap();
    hm.put("1","没有客户ID！");
    hm.put("3","密码错误！");
    hm.put("4","手续费不确定，您不能进行任何操作！");
    
    hm.put("2","未取到数据1，请核查数据或咨询系统管理员！");
    hm.put("10","未取到数据2，请核查数据或咨询系统管理员！");
    hm.put("11","未取到数据3，请核查数据或咨询系统管理员！");
    hm.put("12","未取到数据4，请核查数据或咨询系统管理员！");
    hm.put("13","未取到数据5，请核查数据或咨询系统管理员！");
    hm.put("14","未取到数据6，请核查数据或咨询系统管理员！");*/
    String op_name="投诉退费--冲正";
    String op_code = "4141";
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<title><%=op_name%></title>

<%@ include file="../../npage/s4140/head_4141_2_javascript.htm" %>

</head>

<body>

<form action="f4141_2Cfm.jsp" method="POST" name="f4141_2"  onKeyUp="chgFocus(f4141_2)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">退费信息</div>
</div>
<input type="hidden" name="op_code" id="op_code" value="<%=op_code%>">
<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
<input type="hidden" name="backaccept" value="<%=backaccept%>">
<input type="hidden" name="SpCode" value="<%=chSpEnterCode%>">
<input type="hidden" name="UnPayKindcode" value="<%=chSpEnterCode%>">
<%@ include file="../../include/remark.htm" %>
<table cellspacing="0">
    <tr> 
        <td class=blue nowrap>计费用户号码</td>
        <td nowrap> 
            <input class="InputGrey" type="text" name="phoneno" value="<%=phoneNo%>" readonly >            
        </td>
        <td class=blue nowrap>投诉电子流水</td>
        <td nowrap> 
            <input class="InputGrey" type="text" name="acceptno" value="<%=chAcceptNo%>" readonly size="30">            
        </td>
    </tr>
    <tr> 
        <td nowrap class=blue>退费类型</td>
        <td nowrap> 
            <input class="InputGrey" type="text" name="UnPayLevel" value="<%=chUnPayLevel%>" readonly >          
        </td>
        <td nowrap class=blue>退费种类</td>
        <td nowrap> 
            <input class="InputGrey" type="text" name="UnPayKind" value="<%=chUnPayKind%>" readonly >          
        </td>
    </tr>
    <tr> 
        <td nowrap class=blue>退费一级原因</td>
        <td nowrap> 
            <input class="InputGrey" type="text" name="FirstClass" value="<%=chFirstClass%>" size="30" readonly >          
        </td>
        <td nowrap class=blue>&nbsp;</td>
        <td nowrap> 
            <input class="InputGrey" type="hidden" name="a" value="" readonly >          
        </td>
    </tr>
    <tr> 
        <td nowrap class=blue>退费二级原因</td>
        <td nowrap> 
            <input class="InputGrey" type="text" name="SecondClass" value="<%=chSecondClass%>" size="30" readonly >          
        </td>
        <td nowrap class=blue>退费三级原因</td>
        <td nowrap> 
            <input class="InputGrey" type="text" name="ThirdClass" value="<%=chThirdClass%>" size="30" readonly >          
        </td>
    </tr>
    <tr> 
        <td nowrap class=blue>退费金额</td>
        <td nowrap> 
            <input class="InputGrey" type="text" name="backMoney" value="<%=chBackMoney%>" readonly >
        </td>
        <td nowrap class=blue>赔偿金额</td>
        <td nowrap> 
            <input class="InputGrey" type="text" name="compMoney" value="<%=chCompMoney%>" readonly >
        </td>
    </tr>
    <tr>
        <td nowrap class=blue>备注</td>
        <td colspan="3"> 
            <input class="InputGrey" type="text" name="op_note" value="<%=chOpNote%>" readonly >
        </td>
    </tr>
</table>
<table cellspacing="0">
    <tr id="footer"> 
        <td colspan="4"> 
            <input class="b_foot" type="button" name="confirm" value="确认"  onClick="printCommit()" >
            <input class="b_foot" type="button" name="b_back" value="返回"  onClick="backreturn()" >
        </td>
    </tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>

